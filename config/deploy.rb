# config valid only for current version of Capistrano
lock '3.2.1'

set :application, 'imparables'
set :repo_url, 'git@github.com:dmeza/fcr.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, ->{ "/home/ruby/rubyapps/#{fetch(:application)}" }

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/email_settings.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :deploy_via, :remote_cache
set :git_shallow_clone, 1

set :rvm_type, :system
set :rvm_ruby_version, '2.1.5@voluntarios'
set :thin_command, ->{ "exec thin -C /etc/thin/#{fetch(:application)}.yml restart" }
namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      within release_path do
        execute :bundle, fetch(:thin_command)
      end
    end
  end

  after :publishing, :restart

end
