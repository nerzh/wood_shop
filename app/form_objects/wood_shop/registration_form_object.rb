module WoodShop
  class RegistrationFormObject < SlimFormObject::Base
    validate :validation_models
    set_model_name('RegForm')
    self.base_module = WoodShop
    init_models WoodShop::User, WoodShop::AddressUser
    not_save_empty_object_for WoodShop::User, WoodShop::AddressUser
    attr_accessor :user_password, :user_password_confirmation

    allow_to_save_object do |object|
      result = true
      if object.class == WoodShop::ImageUser and object.image.file.nil?
        result = false
      end
      result
    end

    def initialize(params: {}, current_user: nil)
      super(params: permit_params(params))
      if current_user
        self.user         = current_user
        self.address_user = current_user.address_user
      end
    end

    def permit_params(params)
      return {} if params.empty?
      params.require(:reg_form).permit( user: [
                                          :email, :password, :password_confirmation,
                                          image_user: [
                                            :image, :primary
                                          ]
                                        ],
                                        address_user: [
                                          :area_id, :city_id, :street_id, :first_name, :last_name, :phone, :address
                                        ]
                                    )
    end
  end
end