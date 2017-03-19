# Load DSL and Setup Up Stages
require 'capistrano/setup'
require 'capistrano/deploy'

require 'capistrano/rails'
require 'capistrano/bundler'
require 'capistrano/rvm'
require 'capistrano/puma'

require 'capistrano/scm/git'
install_plugin Capistrano::SCM::Git

require 'whenever/capistrano'
require 'capistrano/sidekiq'

require 'envyml'
Envyml.load('./config/env.yml', 'development')

# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
