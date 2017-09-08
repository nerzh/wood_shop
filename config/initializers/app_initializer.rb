MAINAPP = Object.const_get( Rails.application.class.parent_name )

Rails.application.configure do
  config.assets.paths   += [Rails.root.join('vendor', 'assets', 'bower_components').to_s]
  config.autoload_paths += [Rails.root.join("app", "models", "concerns").to_s]

  # config.angular_templates.markups.push 'haml'
  #on helpers form for Sprockets ~> 3 in ANGULAR JS
  config.assets.configure do |env|
    env.context_class.class_eval do
      # def view_renderer
      #   ActionView::Base.new.view_renderer
      # end
      include ActionView::Helpers
      include Rails.application.routes.url_helpers
    end
  end
end