role :app, %w{ruby@voluntarios.fcr.org.ec}
role :web, %w{ruby@voluntarios.fcr.org.ec}
role :db,  %w{ruby@voluntarios.fcr.org.ec}

set :ssh_options, {
    forward_agent: true,
}
