require 'bundler/capistrano'

default_run_options[:pty]   = true

set :domain,        '212.71.239.171'
set :application,   'wyld-stallyns'
set :user,          'deploy'
set :password,      'railsrumble'

set :scm,           :git
set :scm_verbose,   true
set :repository,    "git@github.com:railsrumble/r13-team-515.git"

set :keep_releases, 5
set :ssh_options,   {:forward_agent => true}
set :use_sudo,      false

set :rails_env,     'production'
set :branch,        'master'

set :deploy_to,     "/home/deploy/apps/#{application}"
set :deploy_via,    :remote_cache

role :web, domain
role :app, domain
role :db,  domain, :primary => true

# deploy:assets:symlink comes from Capistrano deploy/asset in Capfile
after 'deploy:assets:symlink', 'deploy:symlink_config'
after 'deploy:restart',        'deploy:cleanup'

namespace :deploy do
  task :symlink_config, :roles => :app, :except => {:no_release => true, :no_symlink => true} do
    run "ln -nsf #{shared_path}/config/database.yml #{current_release}/config"
    run "mkdir -p #{shared_path}/assets && ln -nsf #{shared_path}/assets #{current_release}/public/assets"
  end

  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end
