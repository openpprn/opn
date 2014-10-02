# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


unless Rails.env == "test"
  general = Forem::Category.where( name: 'General' ).first_or_create
  forum = general.forums.where( name: 'Introductions' ).first_or_create( description: 'Are you new to the site? Stop in and say hi!' )
end
