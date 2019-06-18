role :app, %w{ruby@colecta2019.fcr.org.ec}
role :web, %w{ruby@colecta2019.fcr.org.ec}
role :db,  %w{ruby@colecta2019.fcr.org.ec}

set :branch, "imparables"

set :ssh_options, {
    forward_agent: true,
}
