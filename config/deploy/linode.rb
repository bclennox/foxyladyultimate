server 'foxyladyultimate.com', user: 'deploy', roles: %w(app db web)

set :deploy_to, "/home/deploy/apps/#{fetch(:application)}"
set :default_env, path: '~/.rbenv/shims:~/.rbenv/bin:$PATH'

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
after 'deploy:symlink:release', 'deploy:restart_web'
after 'deploy:symlink:release', 'deploy:restart_workers'
