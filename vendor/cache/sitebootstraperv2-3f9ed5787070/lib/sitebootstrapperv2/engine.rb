module Sitebootstrapperv2
  class Engine < Rails::Engine
    if Rails.version > "3.1"
      initializer "Sitebootstrapperv2 precompile hook" do |app|
        app.config.assets.precompile += ['sitebootstrapper.js', 'sitebootstrapper.css']
      end
    end
  end
end
