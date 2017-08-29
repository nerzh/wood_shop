class UpdateController < ApplicationController
  include FastXlsToHash
  FastXlsToHash.with_xls_style = true

  ExistenceTrue  = true
  ExistenceFalse = false

  def index
    @vendor = Vendor.all
  end

  def upload
    vendors = Vendor.all

    vendors.each do |vendor|
      if params["#{vendor.name}"]

        name = "#{vendor.name}"
        @dir = Rails.root.join('doc', 'uploads', 'price')
        in_file = params["#{vendor.name}"]
        in_file.original_filename =~ /^.*\.(.*)$/

        FileUtils::mkdir_p(@dir) unless Dir.exists?(@dir)
        File.open(Rails.root.join('doc', 'uploads', 'price',  "#{name}.#{$1}"), 'wb') do |file|
          file.write(in_file.read)
          file.close
        end

      end
    end
    # тут надо - если пустая дир, то рендер парт

    read_parse_update
  end


  def read_parse_update
    #read
    FileUtils::mkdir_p(@dir) unless Dir.exists?(@dir)
    files = Dir.entries(@dir).grep(/^.*\.(xls|xlsx)$/)
    #parse
    files.each do |file|
      file =~ /^.*\.xls$/ ? xls(file) : xlsx(file)
    end

    update_price
  end

  def xls(file)
    file            =~ /^(.*)\..*$/
    file_name       = $1
    file_dir        = Rails.root.join("doc", "uploads", "price", "#{file_name}.xls").to_s
    hash_of_xls     = ParseXls.to_hash(file_dir)

    vendor          = Vendor.where(file: file_name).first
    base_codes      = vendor.base_codes.all.pluck(:id, :article)
    base_reject     = vendor.base_rejects.all.pluck(:id, :article)
    base_new        = {}
    vendor.product_news.all.pluck(:article).each { |sku| base_new[sku] = nil }
    @array_updated_products  = []
    @array_rejected_products = []
    @array_new_products      = []
    BaseCode.update_all(price: 0)

    hash_of_xls.each do |name, xls_list|
      mass_base_codes = []
      mass_new        = []

      xls_list.each do |num, row|
        namexls    = row[vendor.colname.to_sym].to_s.del_spaces
        articlexls = row[vendor.colarticle.to_sym].to_s.del_spaces.gsub(/\.\d+$/, '')
        pricexls   = row[vendor.colprice.to_sym]
        next if namexls == ''

        if is_reject?(base_reject, articlexls)
          @array_rejected_products << {article: articlexls, name: namexls, price: pricexls}
          next
        end

        triger = false
        if code = is_exist_product?(base_codes, articlexls)
          mass_base_codes << BaseCode.new(id: code, price: pricexls.to_cent)
          @array_updated_products << {article: articlexls, name: namexls, price: pricexls}
          triger = true
        end
        if !triger
          @array_new_products << {article: articlexls, name: namexls, price: pricexls}
          if !base_new.include?(articlexls)
            mass_new << ProductNew.new(vendor_id: vendor.id, article: articlexls, name: namexls, price: pricexls.to_cent)
          end
        end
      end

      BaseCode.import( mass_base_codes, on_duplicate_key_update: {conflict_target: [:id], columns: [:price]} )
      ProductNew.import( mass_new, on_duplicate_key_update: [:article] )
    end
  end

  def is_reject?(list_reject, article)
    list_reject.each do |id_code|
      return true if id_code[1].to_s == article
    end
    false
  end

  def is_exist_product?(list_base_codes, article)
    list_base_codes.each do |id_code|
      return id_code[0] if id_code[1].to_s == article
    end
    false
  end


  def xlsx(file)
  end



  def update_price
    massbc   = BaseCode.joins(:vendor).order(:sub_product_id, 'vendors.order').pluck(:sub_product_id, :price, :vendor_id)
    massve   = Vendor.all.pluck(:id, :formula, :if)
    # massprod = SubProduct.all.pluck(:id, :created_at)

    massve.each do |mass|
      currency = CurrencyVendor.find_by(primary: true, vendor_id: mass[0]).value
      unless currency
        currency_id = CurrencyVendor.find_by(primary: true, vendor_id: mass[0]).currency.id
        currency    = Currency.find(currency_id).value
      end
      mass << currency
    end

    hash_prices = {}
    massbc.each do |str|
      hash_prices[str[0]] ||= []
      @mass = []
      @mass << str[1]
      @mass << str[2]
      massve.each do |mass|
        if mass[0] == str[2]
          @mass << mass[1]; @mass << mass[2]; @mass << mass[3]
        end
      end

      hash_prices[str[0]] << @mass
    end

    hash_prices.each do |id, prod|
      @price = 0
      @vendorid = nil
      prod.each do |str|
        prod_id       = id.to_i
        prod_price    = str[0].to_i
        prod_vendorid = str[1].to_i
        prod_formula  = str[2].to_s
        prod_if       = str[3].to_s
        prod_currency = str[4].to_i
        vendorprice   = calc(prod_price, prod_currency, prod_formula)
        @mass_base  ||= []

        if prod.size-1 == prod.index(str)
          if @price == 0
            @mass_base << SubProduct.new(id: prod_id, price: vendorprice, vendor_id: prod_vendorid)
            break
          end
          @mass_price = ifcase( @price, vendorprice, prod_if, prod_vendorid, @vendorid )
          @price      = @mass_price[0]
          @vendorid   = @mass_price[1]
          @mass_base << SubProduct.new(id: prod_id, price: @price, vendor_id: @vendorid)
        else
          (@price = vendorprice; @vendorid = prod_vendorid; next) if @price == 0
          @mass_price = ifcase( @price, vendorprice, prod_if, prod_vendorid, @vendorid )
          @price = @mass_price[0]
          @vendorid = @mass_price[1]
        end
      end
    end

    SubProduct.import( @mass_base, on_duplicate_key_update: {conflict_target: [:id], columns: [:price, :vendor_id]} )
    p "COMPLETE"

    update_product_min_max_price
  end

  def update_product_min_max_price
    res = ActiveRecord::Base.connection.execute('select p.id, min(NULLIF(sp.price, 0)), max(sp.price)
                                                     from products as p inner join sub_products as sp
                                                     on p.id = sp.product_id group by p.id')
    arr_values = []
    res.each do |hash|
      temp_values = []
      temp_values << hash['id']
      hash['min'] == nil ? temp_values << 0 : temp_values << hash['min']
      temp_values << hash['max']
      (hash['min'] == nil and hash['max'] <= 0) ? temp_values << ExistenceFalse : temp_values << ExistenceTrue
      arr_values  << temp_values
    end
    Product.update_all(existence: false)
    Product.import( ['id', 'min_price', 'max_price', 'existence'], arr_values,
                    on_duplicate_key_update: {conflict_target: [:id], columns: [:min_price, :max_price, :existence]} )
  end

  def ifcase(inprice, invendorprice, inprod_if, inprod_vendorid, vendorid)
    return [inprice, vendorid] if (inprice != 0 and invendorprice != 0)
    case inprod_if
      when "m"
        inprice > invendorprice ? [invendorprice, inprod_vendorid] : [inprice, vendorid]
        # raise "M SUPER"
      when "b"
        inprice < invendorprice ? [invendorprice, inprod_vendorid] : [inprice, vendorid]
        # raise "B SUPER"
      when "z"
        [invendorprice, inprod_vendorid]
        # raise "Z SUPER"
      else
        raise "CASE"
    end
  end

  private

  def calc(price, currency, formula)
    return 0 if price == 0
    raise "NO CURRENCY" if currency == 0
    x   = price.to_price
    k   = currency.to_price
    out = eval(Unicode.downcase(formula)) * k

    return out.to_cent
  end

end