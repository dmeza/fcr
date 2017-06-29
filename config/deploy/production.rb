role :app, %w{ruby@acuerdo.acolita.org}
role :web, %w{ruby@acuerdo.acolita.org}
role :db,  %w{ruby@acuerdo.acolita.org}

set :branch, "acuerdo_cancer"

set :ssh_options, {
    forward_agent: true,
}
