# frozen_string_literal: true

# Load DSL and Setup Up Stages
require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/rails'
require 'capistrano/rails/collection'
require 'capistrano/sidekiq'
require 'capistrano/puma'
Dir.glob('lib/capistrano/tasks/*.cap').each { |r| import r }
