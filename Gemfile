source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'

gem 'rails', '~> 5.2.4', '>= 5.2.4.5'
#gem 'rails-i18n'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
#gem 'bootstrap', '~> 4.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'bootsnap', '>= 1.1.0', require: false

# ログイン機能
gem 'devise'

# 日本語化
gem 'rails-i18n', '~> 5.1'
gem 'devise-i18n'

# Bootstrap
gem 'bootstrap', '~> 4.5'
gem 'jquery-rails'
gem 'devise-bootstrap-views', '~> 1.0'

#サンプル追加
gem 'faker'

# リッチテキスト
gem 'simple_form'
gem 'summernote-rails', '~> 0.8.10.0'

# 画像投稿機能
gem 'carrierwave'

# AWSのS3連携
gem 'fog-aws'

# 画像のリサイズ
gem 'mini_magick'
#will_paginate
gem 'will_paginate'
gem 'bootstrap-will_paginate'

#csvファイルimport
gem 'roo'

# デコレーター
gem 'active_decorator'

# URLを検出してaタグに
gem 'rinku'

group :development, :test do
  gem 'rspec-rails', '~> 3.8.0'
  gem 'factory_bot_rails', '~> 4.10.0'
  gem 'sqlite3'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'capybara', '>= 2.15'
  #gem 'launchy', '~> 2.4.3'
  gem 'selenium-webdriver'
  #gem 'chromedriver-helper'
  gem 'webdrivers', '~> 3.0'
end

# group :production do
#   gem 'pg', '0.20.0'
# end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
