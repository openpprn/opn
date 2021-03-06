# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w( day_theme.less night_theme.less )

# Add to assets path
Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets', 'fonts')

# Had to add these here to get in Precompile Package
Rails.application.config.assets.precompile += %w( font-awesome-4.2.0/css/font-awesome.min.css )
Rails.application.config.assets.precompile += %w( pages.css )
Rails.application.config.assets.precompile += %w( forem.css forem.js )
Rails.application.config.assets.precompile += %w( social/maps.js social/places.js typeahead-addresspicker.js google_analytics.js uservoice.js )
Rails.application.config.assets.precompile += %w( .svg .eot .woff .ttf)
Rails.application.config.assets.precompile += %w( reports/default.js )
