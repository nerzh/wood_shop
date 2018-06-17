module WoodShop
  class Engine < ::Rails::Engine
    engine_name "wood_shop"
    isolate_namespace WoodShop

    # rake_tasks do
    #   load "tasks/wood_shop_load_city_task.rake"
    # end

    initializer :append_migrations do |app|
      unless app.root.to_s.match root.to_s
        config.paths["db/migrate"].expanded.each do |expanded_path|
          app.config.paths["db/migrate"] << expanded_path
        end
      end
    end

    config.to_prepare do
      # Rails.application.config.assets.precompile += %w(wood_shop/*)
      DeviseController.respond_to :html, :json
    end

    initializer :assets do |app|
      Rails.application.config.assets.paths += [WoodShop::Engine.root.join("app", "assets")]
    end

    initializer "wood_shop", before: :load_config_initializers do |app|
      Rails.application.routes.append do
        mount WoodShop::Engine, at: '/', as: 'wood_shop'
      end
    end

    initializer :action_controller do
      ActiveSupport.on_load(:action_controller) do
        ApplicationHelper.include WoodShop::Engine.routes.url_helpers
        include MainappApplicationControllerExtension
        helper WoodShop::Engine.helpers
      end
    end
  end
end
