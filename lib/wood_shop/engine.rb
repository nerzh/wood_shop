module WoodShop
  class Engine < ::Rails::Engine
    isolate_namespace WoodShop

    initializer :append_migrations do |app|
      unless app.root.to_s.match root.to_s
        config.paths["db/migrate"].expanded.each do |expanded_path|
          app.config.paths["db/migrate"] << expanded_path
        end
      end
    end

    # config.to_prepare do
    #   Devise::SessionsController.layout "layout_for_sessions_controller"
    # end
  end
end
