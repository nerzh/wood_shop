module WoodShop
  class UsersController < ApplicationController
    before_action :authenticate_user!

    def profile
      @form = RegistrationFormObject.new(current_user: current_user)
      @user = ActiveModelSerializers::SerializableResource.new(current_user, {group: :profile}).serializable_hash
    end

    def orders
      @user = ActiveModelSerializers::SerializableResource.new(current_user, {group: :orders}).serializable_hash
    end

    def address
      @form = RegistrationFormObject.new(current_user: current_user)
      @user = ActiveModelSerializers::SerializableResource.new(current_user, {group: :address}).serializable_hash
    end
  end
end