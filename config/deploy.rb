set :rbenv_type, :user
set :rbenv_ruby, "2.1.3"

set :rack_env, :production

set :user, "deploy"
set :domain, "customers.projects.nitschmann.io"
set :application, "customers_api"
set :deploy_to, "/home/deploy/customers_api"
set :scm, "git"
set :repo_url, "git@github.com:fnitschmann/json_api_sample.git"
set :branch, "master"

set :keep_releases, 3

set :linked_files, %w{config.yml}
set :linked_dirs, %w{bin db tmp}

namespace :deploy do
  desc "restart the application"
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join("tmp/restart.txt")
    end
  end

  after :publishing, "deploy:restart"
  after :finishing, "deploy:cleanup"
end
