namespace :deploy do
  task :restart_workers do
    on roles(:app) do
      execute :sudo, :systemctl, :restart, 'foxyladyultimate-worker'
    end
  end
end

after 'deploy:restart', 'deploy:restart_workers'
