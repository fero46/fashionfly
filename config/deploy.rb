lock '3.5.0'

set :application, 'fashionfly'
set :repo_url, 'git@bitbucket.org:fashionfly/fashionfly.git'

set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"

set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, false  # Change to true if using ActiveRecord


namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before 'puma:start', 'puma:make_dirs'
end

namespace :deploy do

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  before :restart, :symlink_upload do
    on roles(:app), in: :sequence, wait: 5 do
      execute :mkdir, "-p #{shared_path}/sitemaps"
      execute :rm, "-rf","#{release_path}/public/sitemaps"
      execute :ln, "-s", "#{shared_path}/sitemaps #{release_path}/public/sitemaps"
      execute :rm, "-rf","#{release_path}/public/uploads"
      execute :ln, "-s", "#{deploy_to}/shared/uploads #{release_path}/public/uploads"
      execute :rm, "-rf","#{release_path}/log"
      execute :ln, "-s", "#{deploy_to}/shared/log #{release_path}/log"
      execute :rm, "-rf","#{release_path}/tmp"
      execute :ln, "-s", "#{deploy_to}/shared/tmp #{release_path}/tmp"
    end
  end

  before :compile_assets, :symlink_database do
    on roles(:app), in: :sequence, wait: 5 do
      execute :ln, "-nfs", "#{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
    end
  end


end
