require 'fileutils'
require 'erb'
require 'digest/sha1'
require 'securerandom'

root_folder = FileUtils.pwd
FileUtils.cd('lib/templates')
template_folder = FileUtils.pwd

puts template_folder
puts root_folder

files = [['config/environments', 'production.rb'],
  ['config/initializers', '00_site_name.rb'],
  ['config/initializers', 'action_mailer.rb'],
  ['app/assets/javascripts', 'google_analytics.js']
  # ['config','database.yml'],
  # ['config/initializers', 'secret_token.rb'],
  # ['config/initializers', 'devise.rb']
  ]

files.each do |folder_name, file_name|
  file_template = File.join(template_folder, file_name + '.erb')
  file_original = File.join(root_folder, folder_name, file_name)
  overwrite = true
  if File.exists?(file_template)
    if File.exists?(file_original)
      overwrite = false
      puts file_original + " already exists! Overwrite? [yes|no]"
      s = gets.chomp()
      overwrite = true if s.downcase == 'yes'
    end
    if overwrite
      puts "Creating file: " + file_original
      file_in = File.new(file_template, "r")
      file_out = File.new(file_original, "w")
      template = ERB.new(file_in.sysread(File.size(file_in)))
      file_out.syswrite(template.result)
      file_in.close()
      file_out.close()
    end
  else
    puts "Error: Make sure you are running this ruby command from the rails root directory!"
  end
end
