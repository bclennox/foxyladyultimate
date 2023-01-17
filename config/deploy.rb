lock '3.17.1'

set :application, 'foxyladyultimate.com'
set :repo_url, 'github-foxyladyultimate:bclennox/foxyladyultimate'

append :linked_files, '.rbenv-vars'
append :linked_dirs, 'log', 'node_modules', 'tmp/pids', 'tmp/cache'

set :rbenv_ruby, File.read('.ruby-version').strip

ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
