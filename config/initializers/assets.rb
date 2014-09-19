# Add to assets path
Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets', 'fonts')

# Had to add these here to get in Precompile Package
Rails.application.config.assets.precompile += %w( font-awesome-4.1.0/css/font-awesome.min.css )
Rails.application.config.assets.precompile += %w( pages.css )
Rails.application.config.assets.precompile += %w( forem.css forem.js )
Rails.application.config.assets.precompile += %w( social/maps.js social/places.js typeahead.js typeahead-addresspicker.js )
Rails.application.config.assets.precompile += %w( .svg .eot .woff .ttf)


