lock '3.20.0'

set :application, 'foxyladyultimate.com'
set :repo_url, 'github-foxyladyultimate:bclennox/foxyladyultimate'

append :linked_files, '.rbenv-vars', 'config/master.key'
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache'

set :rbenv_ruby, File.read('.ruby-version').strip
set :bundle_version, 4

ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
