module MainappApplicationControllerExtension
  def self.included(klass)
    klass.extend ClassMethods
    klass.include InstanceMethods
  end

  module ClassMethods
    def self.extended(klass)
      klass.class_eval do
        after_action  :set_csrf_cookie_for_ng
        before_action :menu_catalogs
        respond_to :html, :json
      end
    end
  end

  module InstanceMethods
    protected

    def menu_catalogs
      @menu_catalogs = WoodShop::Catalog.includes(:categories).select('wood_shop_catalogs.id',
                                                                      'wood_shop_catalogs.name',
                                                                      'wood_shop_catalogs.slug')
    end

    def set_csrf_cookie_for_ng
      cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
    end

    def verified_request?
      super || valid_authenticity_token?(session, request.headers['X-XSRF-TOKEN'])
    end

    def start_timer
      $time = nil; $time = Time.now.to_f
    end

    def end_timer
      $time = Time.now.to_f - $time if $time
    end
  end
end