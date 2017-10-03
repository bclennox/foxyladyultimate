server 'foxyladyultimate.com', user: 'deploy', roles: %w(app db web)

set :deploy_to, "~/apps/#{fetch(:application)}"
set :default_env, path: '~/.rbenv/shims:~/.rbenv/bin:$PATH'
