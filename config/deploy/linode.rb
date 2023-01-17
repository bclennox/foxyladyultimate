server 'newbclennox.com', user: 'deploy', roles: %w(app db web)

set :deploy_to, "/home/deploy/apps/#{fetch(:application)}"
set :default_env, path: '~/.rbenv/shims:~/.rbenv/bin:$PATH'

# https://coderwall.com/p/rul3ma/capistrano-task-for-compiling-tasks-locally
namespace :assets do
  desc 'Run the assets:precompile locally and upload to server'
  task :precompile do
    run_locally do
      rake 'assets:precompile'
      `tar -C public -zvcf tmp/public.tar.gz assets packs`
    end

    on roles(:app) do
      upload! 'tmp/public.tar.gz', "#{release_path}/tmp"
      execute "tar -C #{release_path}/public -zxvf #{release_path}/tmp/public.tar.gz"
    end
  end
end
after 'deploy:updated', 'assets:precompile'

namespace :deploy do
  desc 'Restart Puma service'
  task :restart_web do
    on roles(:app) do
      execute :sudo, :systemctl, :restart, 'foxyladyultimate-web'
    end
  end

  desc 'Restart background workers'
  task :restart_workers do
    on roles(:app) do
      execute :sudo, :systemctl, :restart, 'foxyladyultimate-worker'
    end
  end
end
after 'deploy:restart', 'deploy:restart_web'
after 'deploy:restart', 'deploy:restart_workers'
