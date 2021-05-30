source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.1' #this should correspond to the ruby version you are running

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
# to scope a gem to a specific major version you can use the ~> symbol before the gem version
# this will make sure a gem is stuck at a major version
gem 'rails', '~> 6.0.2', '>= 6.0.2.2'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'
gem 'cancancan'
gem 'bootstrap', '~> 4.4.1'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

gem 'delayed_job_active_record', '~> 4.1', '>= 4.1.4'
gem 'delayed_job_web', '~> 1.4', '>= 1.4.3'

gem 'letter_opener'

gem 'active_model_serializers'

gem 'rack-cors'
gem 'mini_magick'
# gems listed above here are considered production gems. These should gems that are core to your application
gem 'omniauth-github', '~> 1.4'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 4.0.0' #libary heavily integrated into rails to allow us to test stuff really easily
  gem 'factory_bot_rails', '~> 5.2'
  gem 'rails-controller-testing'
  gem 'faker'
end

# gems listed underneath group :development are gems that are only installed in development environment

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # to add gems to rails project just list them out in the gemfile here.
  gem 'cowsay'
  gem 'pry'
  gem 'pry-rails'
  gem 'faker'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
