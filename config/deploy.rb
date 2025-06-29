lock '3.19.2'

set :application, 'foxyladyultimate.com'
set :repo_url, 'github-foxyladyultimate:bclennox/foxyladyultimate'

append :linked_files, '.rbenv-vars', 'config/master.key'
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache'

set :rbenv_ruby, File.read('.ruby-version').strip

ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
