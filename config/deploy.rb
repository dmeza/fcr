require 'bundler/capistrano'
require 'rvm/capistrano'

default_run_options[:pty] = true
set :application, "ayudandonos"
set :repository,  "git@github.com:dmeza/voluntarios.git"

set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
               # Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :rvm_type, :system
set :use_sudo, false

set :deploy_to, "/home/ruby/rubyapps/#{application}"

role :web, "192.241.168.104"                          # Your HTTP server, Apache/etc
role :app, "192.241.168.104"                          # This may be the same as your `Web` server
role :db,  "192.241.168.104", :primary => true # This is where Rails migrations will run

set :user, 'ruby'
set :rails_env, :production

ssh_options[:port] = 22
ssh_options[:forward_agent] = true

set :deploy_via, :remote_cache
set :git_shallow_clone, 1

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"
after 'deploy:update_code', "symlink_server_config"
before "deploy:assets:precompile", "symlink_server_config"
after "deploy:update_code", 'deploy:migrate'

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  desc 'Start thin servers'
  task :start, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && RUBY_GC_MALLOC_LIMIT=90000000 bundle exec thin -C /etc/thin/ayudandonos.yml start", :pty => false
  end

  desc 'Stop thin servers'
  task :stop, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && bundle exec thin -C /etc/thin/ayudandonos.yml stop"
  end

  desc 'Restart thin servers'
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && RUBY_GC_MALLOC_LIMIT=90000000 bundle exec thin -C /etc/thin/ayudandonos.yml restart"
  end
end

namespace :assets do

end

task :symlink_server_config do
  run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  run "ln -nfs #{shared_path}/config/email_settings.yml #{release_path}/config/email_settings.yml"
end

