# -*- encoding: utf-8 -*-
# stub: sitebootstrapperv2 0.0.2 ruby lib

Gem::Specification.new do |s|
  s.name = "sitebootstrapperv2"
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Gustavo Gonzalez"]
  s.date = "2016-02-24"
  s.description = ""
  s.email = ["gustavo@martintechlabs.com"]
  s.files = ["MIT-LICENSE", "README.rdoc", "Rakefile", "app/assets", "app/assets/images", "app/assets/images/SBv2.png", "app/assets/images/default_user.png", "app/assets/images/facebookbutton.png", "app/assets/images/glyphicons-halflings-white.png", "app/assets/images/glyphicons-halflings.png", "app/assets/images/sitebootstrapperv2", "app/assets/javascripts", "app/assets/javascripts/sitebootstrapper.js", "app/assets/javascripts/sitebootstrapperv2", "app/assets/javascripts/sitebootstrapperv2/flot", "app/assets/javascripts/sitebootstrapperv2/flot/excanvas.min.js", "app/assets/javascripts/sitebootstrapperv2/flot/jquery.colorhelpers.min.js", "app/assets/javascripts/sitebootstrapperv2/flot/jquery.flot.crosshair.min.js", "app/assets/javascripts/sitebootstrapperv2/flot/jquery.flot.fillbetween.min.js", "app/assets/javascripts/sitebootstrapperv2/flot/jquery.flot.image.min.js", "app/assets/javascripts/sitebootstrapperv2/flot/jquery.flot.min.js", "app/assets/javascripts/sitebootstrapperv2/flot/jquery.flot.navigate.min.js", "app/assets/javascripts/sitebootstrapperv2/flot/jquery.flot.pie.min.js", "app/assets/javascripts/sitebootstrapperv2/flot/jquery.flot.resize.min.js", "app/assets/javascripts/sitebootstrapperv2/flot/jquery.flot.selection.min.js", "app/assets/javascripts/sitebootstrapperv2/flot/jquery.flot.stack.min.js", "app/assets/javascripts/sitebootstrapperv2/flot/jquery.flot.symbol.min.js", "app/assets/javascripts/sitebootstrapperv2/flot/jquery.flot.threshold.min.js", "app/assets/stylesheets", "app/assets/stylesheets/bootstrap.css", "app/assets/stylesheets/sitebootstrapper.css", "app/controllers", "app/controllers/admin", "app/controllers/admin/admin_controller.rb", "app/controllers/admin/users_controller.rb", "app/controllers/application_controller.rb", "app/controllers/home_controller.rb", "app/controllers/users", "app/controllers/users/omniauth_callbacks_controller.rb", "app/helpers", "app/mailers", "app/models", "app/models/authentication.rb", "app/models/user.rb", "app/views", "app/views/admin", "app/views/admin/users", "app/views/admin/users/index.haml", "app/views/admin/users/resend_activation.js.haml", "app/views/devise", "app/views/devise/confirmations", "app/views/devise/confirmations/new.html.erb", "app/views/devise/mailer", "app/views/devise/mailer/confirmation_instructions.html.erb", "app/views/devise/mailer/reset_password_instructions.html.erb", "app/views/devise/mailer/unlock_instructions.html.erb", "app/views/devise/passwords", "app/views/devise/passwords/edit.html.erb", "app/views/devise/passwords/new.html.erb", "app/views/devise/registrations", "app/views/devise/registrations/edit.html.haml", "app/views/devise/registrations/new.html.haml", "app/views/devise/sessions", "app/views/devise/sessions/new.html.haml", "app/views/devise/shared", "app/views/devise/shared/_links.erb", "app/views/devise/unlocks", "app/views/devise/unlocks/new.html.erb", "app/views/home", "app/views/home/home.html.haml", "app/views/home/index.html.haml", "app/views/layouts", "app/views/layouts/sitebootstrapper.html.haml", "app/views/shared", "app/views/shared/_facebook_init.erb", "app/views/shared/_social_buttons.html.haml", "config/initializers", "config/initializers/devise.rb", "config/locales", "config/locales/devise.en.yml", "config/routes.rb", "db/migrate", "db/migrate/20111117204614_devise_create_users.rb", "lib/generators", "lib/generators/sitebootstrapper", "lib/generators/sitebootstrapper/views", "lib/generators/sitebootstrapper/views/USAGE", "lib/generators/sitebootstrapper/views/views_generator.rb", "lib/sitebootstrapperv2", "lib/sitebootstrapperv2.rb", "lib/sitebootstrapperv2/engine.rb", "lib/sitebootstrapperv2/version.rb", "lib/tasks", "lib/tasks/sitebootstrapperv2_tasks.rake", "test/dummy", "test/dummy/Rakefile", "test/dummy/app", "test/dummy/app/assets", "test/dummy/app/assets/javascripts", "test/dummy/app/assets/javascripts/application.js", "test/dummy/app/assets/stylesheets", "test/dummy/app/assets/stylesheets/application.css", "test/dummy/app/controllers", "test/dummy/app/controllers/application_controller.rb", "test/dummy/app/helpers", "test/dummy/app/helpers/application_helper.rb", "test/dummy/app/mailers", "test/dummy/app/models", "test/dummy/app/views", "test/dummy/config", "test/dummy/config.ru", "test/dummy/config/application.rb", "test/dummy/config/boot.rb", "test/dummy/config/database.yml", "test/dummy/config/environment.rb", "test/dummy/config/environments", "test/dummy/config/environments/development.rb", "test/dummy/config/environments/production.rb", "test/dummy/config/environments/test.rb", "test/dummy/config/initializers", "test/dummy/config/initializers/backtrace_silencers.rb", "test/dummy/config/initializers/inflections.rb", "test/dummy/config/initializers/mime_types.rb", "test/dummy/config/initializers/secret_token.rb", "test/dummy/config/initializers/session_store.rb", "test/dummy/config/initializers/wrap_parameters.rb", "test/dummy/config/locales", "test/dummy/config/locales/en.yml", "test/dummy/config/routes.rb", "test/dummy/db", "test/dummy/db/migrate", "test/dummy/db/migrate/20111123200225_devise_create_users.rb", "test/dummy/db/schema.rb", "test/dummy/lib", "test/dummy/lib/assets", "test/dummy/log", "test/dummy/public", "test/dummy/public/404.html", "test/dummy/public/422.html", "test/dummy/public/500.html", "test/dummy/public/favicon.ico", "test/dummy/script", "test/dummy/script/rails", "test/fixtures", "test/fixtures/users.yml", "test/integration", "test/integration/navigation_test.rb", "test/sitebootstrapperv2_test.rb", "test/test_helper.rb", "test/unit", "test/unit/user_test.rb"]
  s.homepage = "https://github.com/martintechlabs/sitebootstrapperv2"
  s.rubygems_version = "2.2.2"
  s.summary = ""
  s.test_files = ["test/sitebootstrapperv2_test.rb", "test/unit", "test/unit/user_test.rb", "test/test_helper.rb", "test/integration", "test/integration/navigation_test.rb", "test/dummy", "test/dummy/script", "test/dummy/script/rails", "test/dummy/config", "test/dummy/config/database.yml", "test/dummy/config/routes.rb", "test/dummy/config/environments", "test/dummy/config/environments/test.rb", "test/dummy/config/environments/production.rb", "test/dummy/config/environments/development.rb", "test/dummy/config/locales", "test/dummy/config/locales/en.yml", "test/dummy/config/initializers", "test/dummy/config/initializers/wrap_parameters.rb", "test/dummy/config/initializers/secret_token.rb", "test/dummy/config/initializers/session_store.rb", "test/dummy/config/initializers/inflections.rb", "test/dummy/config/initializers/mime_types.rb", "test/dummy/config/initializers/backtrace_silencers.rb", "test/dummy/config/application.rb", "test/dummy/config/environment.rb", "test/dummy/config/boot.rb", "test/dummy/app", "test/dummy/app/assets", "test/dummy/app/assets/javascripts", "test/dummy/app/assets/javascripts/application.js", "test/dummy/app/assets/stylesheets", "test/dummy/app/assets/stylesheets/application.css", "test/dummy/app/views", "test/dummy/app/helpers", "test/dummy/app/helpers/application_helper.rb", "test/dummy/app/controllers", "test/dummy/app/controllers/application_controller.rb", "test/dummy/app/mailers", "test/dummy/app/models", "test/dummy/config.ru", "test/dummy/log", "test/dummy/public", "test/dummy/public/500.html", "test/dummy/public/404.html", "test/dummy/public/favicon.ico", "test/dummy/public/422.html", "test/dummy/db", "test/dummy/db/schema.rb", "test/dummy/db/migrate", "test/dummy/db/migrate/20111123200225_devise_create_users.rb", "test/dummy/lib", "test/dummy/lib/assets", "test/dummy/Rakefile", "test/fixtures", "test/fixtures/users.yml"]

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, ["~> 3.2.0"])
      s.add_runtime_dependency(%q<devise>, [">= 0"])
      s.add_runtime_dependency(%q<omniauth>, ["~> 1.0"])
      s.add_runtime_dependency(%q<omniauth-facebook>, [">= 0"])
      s.add_runtime_dependency(%q<omniauth-twitter>, [">= 0"])
      s.add_runtime_dependency(%q<omniauth-openid>, [">= 0"])
      s.add_runtime_dependency(%q<omniauth-google-oauth2>, [">= 0"])
      s.add_runtime_dependency(%q<paperclip>, [">= 0"])
      s.add_runtime_dependency(%q<haml>, [">= 0"])
      s.add_runtime_dependency(%q<will_paginate>, [">= 0"])
      s.add_development_dependency(%q<mysql2>, [">= 0"])
    else
      s.add_dependency(%q<rails>, ["~> 3.2.0"])
      s.add_dependency(%q<devise>, [">= 0"])
      s.add_dependency(%q<omniauth>, ["~> 1.0"])
      s.add_dependency(%q<omniauth-facebook>, [">= 0"])
      s.add_dependency(%q<omniauth-twitter>, [">= 0"])
      s.add_dependency(%q<omniauth-openid>, [">= 0"])
      s.add_dependency(%q<omniauth-google-oauth2>, [">= 0"])
      s.add_dependency(%q<paperclip>, [">= 0"])
      s.add_dependency(%q<haml>, [">= 0"])
      s.add_dependency(%q<will_paginate>, [">= 0"])
      s.add_dependency(%q<mysql2>, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>, ["~> 3.2.0"])
    s.add_dependency(%q<devise>, [">= 0"])
    s.add_dependency(%q<omniauth>, ["~> 1.0"])
    s.add_dependency(%q<omniauth-facebook>, [">= 0"])
    s.add_dependency(%q<omniauth-twitter>, [">= 0"])
    s.add_dependency(%q<omniauth-openid>, [">= 0"])
    s.add_dependency(%q<omniauth-google-oauth2>, [">= 0"])
    s.add_dependency(%q<paperclip>, [">= 0"])
    s.add_dependency(%q<haml>, [">= 0"])
    s.add_dependency(%q<will_paginate>, [">= 0"])
    s.add_dependency(%q<mysql2>, [">= 0"])
  end
end
