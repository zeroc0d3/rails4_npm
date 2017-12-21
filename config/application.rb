require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Rails4
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Asia/Jakarta'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :en

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    config.assets.enabled = true
    #--------
    initializer 'setup_asset_pipeline', :group => :all  do |app|
      # We don't want the default of everything that isn't js or css, because it pulls too many things in
      app.config.assets.paths << Rails.root.join("app", "assets")
      app.config.assets.paths << Rails.root.join("vendor", "assets")
      
      app.config.assets.precompile.shift
      # Explicitly register the extensions we are interested in compiling
      app.config.assets.precompile.push(Proc.new do |path|
        File.extname(path).in? [
          '.html', '.erb', '.haml',                           # Templates
          '.png',  '.gif', '.jpg', '.jpeg',                   # Images
          '.eot',  '.otf', '.svc', '.woff', '.woff2', '.ttf', # Fonts
          '.md',                                              # Markdown File
        ]
      end)
    end
    #--------

    config.npm.enable_watch = Rails.env.development?

    # Command to install dependencies
    config.npm.install = ['npm install']

    # Command to build production assets
    config.npm.build = ['npm run build']

    # Command to start a file watcher
    config.npm.watch = ['npm run start']

    # The commands are arrays; you may add more commands as needed:
    config.npm.watch = [
      # 'npm run webpack:start',
      # 'npm run brunch:start'
      'gulp:start',
    ]

    # If 'true', runs 'npm install' on 'rake assets:precompile'. (v1.6.0+)
    # If you disable this, you'll need to run `npm install` yourself.
    # This is generally desired, but you may set this to false when
    # deploying to Heroku to speed things up.
    config.npm.install_on_asset_precompile = false

    # If 'true', runs 'npm install' on 'rails server'. (v1.7.0+)
    # If you disable this, you'll need to run `npm install` yourself.
    config.npm.install_on_rails_server = true
  end
end
