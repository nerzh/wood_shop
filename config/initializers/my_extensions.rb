if RUBY_VERSION >= "2.4.0"
  class Integer
    def to_price
      self.to_dec.ceil
    end

    def to_dec
      return 0.0 if self == 0
      (self.to_d/1000).round 2
    end

    def to_cent
      self * 1000
    end
  end
else
  class Fixnum
    def to_price
      self.to_dec.ceil
    end

    def to_dec
      return 0.0 if self == 0
      (self.to_d/1000).round 2
    end

    def to_cent
      self * 1000
    end
  end
end

class String
  def to_price
    self.to_dec.ceil
  end

  def to_dec
    return 0.0 if self == "0"
    (self.to_d/1000).round 2
  end

  def to_cent
    (self.to_d * 1000).to_i
  end

  def del_spaces
    self.gsub!(/^\s+/, '')
        &.gsub!(/\s+$/, '')
    self
  end

  def uni_downcase
    Unicode.downcase(self)
  end

  def uni_upcase
    Unicode.upcase(self)
  end

  def uni_capitalize
    Unicode.capitalize(self)
  end
end

class BigDecimal
  def to_price
    self.to_dec.ceil
  end

  def to_dec
    return 0.0 if self == 0.0
    (self/1000).round 2
  end

  def to_cent
    (self * 1000).to_i
  end
end

class Float
  def to_price
    self.to_dec.ceil
  end

  def to_dec
    return self if self == 0.0
    (self.to_d/1000).round 2
  end

  def to_cent
    (self.to_d * 1000).to_i
  end
end