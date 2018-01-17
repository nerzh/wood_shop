module MainappApplicationControllerExtension
  def self.included(klass)
    klass.extend ClassMethods
    klass.include InstanceMethods
  end

  module ClassMethods
    def self.extended(klass)
      klass.class_eval do
        include WoodShop::Engine.routes.url_helpers
        attr_accessor :method_complete
        alias_method :method_complete?, :method_complete
        before_action :set_default_method_state
        after_action  :set_csrf_cookie_for_ng
        before_action :menu_catalogs, :current_user_hash
        respond_to :html, :json

        def after_sign_in_path_for(resource)
          return admin_root_path if resource.class == WoodShop::AdminUser
          user_profile_path(resource)
        end

        protected

        def menu_catalogs
          @menu_catalogs = ActiveModelSerializers::SerializableResource.new(
              WoodShop::Catalog.all.order(:name), {group: :with_categories}).serializable_hash
        end

        def current_user_hash
          @current_user_hash = ActiveModelSerializers::SerializableResource.new(
              current_user, {group: :profile}).serializable_hash if current_user
        end

        def set_csrf_cookie_for_ng
          cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
        end

        def verified_request?
          super || valid_authenticity_token?(session, request.headers['X-XSRF-TOKEN'])
        end

        # for debug speed load page
        def start_timer
          $time = nil; $time = Time.now.to_f
        end

        def end_timer
          $time = Time.now.to_f - $time if $time
        end

        private

        def set_default_method_state
          @method_complete = true
        end
      end
    end
  end

  module InstanceMethods
  end
end