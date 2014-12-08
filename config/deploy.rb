require "capistrano/bundler"
require "capistrano/rbenv"

set :rbenv_type, :user
set :rbenv_ruby "2.1.3"

set :rack_env, :production

set :user, "deploy"
set :domain, "customers.projects.nitschmann.io"
set :application, "customers_api"
set :deploy_to, "/home/deploy/#{application}"
set :scm, "git"
set :repo_url "git@github.com:fnitschmann/json_api_sample.git"
set :branch, "master"

ssh_options[:forward_agent] = true
ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "id_rsa")]
ssh_options[:paranoid] = false
default_run_options[:pty] = true

namespace :deploy do
  desc 'restart the app'
  task :restart do
    admin.nginx_restart
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
end
