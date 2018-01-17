module WoodShop
  class RegistrationController < Devise::RegistrationsController
    def new
      super
    end

    def create
      @object = RegistrationFormObject.new(params: params, current_user: current_user)
      @object.apply_parameters
      if @object.save
        return redirect_to user_profile_path(current_user) if sign_in(:user, form.user)
        redirect_to root_path
      else
        redirect_to new_user_session_path
        method_complete = false
      end
    end

    def update
      @object = RegistrationFormObject.new(params: params, current_user: current_user)
      @object.apply_parameters
      if @object.save
        sign_out
        return redirect_to user_profile_path(current_user) if sign_in(:user, form.user)
        redirect_to root_path
      else
        redirect_to new_user_session_path
        method_complete = false
      end
    end
  end
end