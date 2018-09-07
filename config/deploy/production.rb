role :app, %w{ruby@uio.acolita.org}
role :web, %w{ruby@uio.acolita.org}
role :db,  %w{ruby@uio.acolita.org}

set :branch, "acuerdo_cancer"

set :ssh_options, {
    forward_agent: true,
}
