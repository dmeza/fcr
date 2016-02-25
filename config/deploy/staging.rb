role :app, %w{ruby@test-site.alturasoluciones.com}
role :web, %w{ruby@test-site.alturasoluciones.com}
role :db,  %w{ruby@test-site.alturasoluciones.com}

set :application, "ayudandonos_staging"

set :branch, "develop"

set :ssh_options, {
  forward_agent: true
}
