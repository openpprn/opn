namespace :research_topics do

  desc "Load research topic if it does not exist yet"
  task :update => :environment do


    files = [
        ["research_topics.yml", ResearchTopic],
    ]

    files.each do |file_name, model_class|
      file_path = Rails.root.join('lib', 'data', 'research_topics', file_name)

      puts(file_path)

      yaml_data = YAML.load_file(file_path)

      yaml_data.each do |object_attrs|
        puts object_attrs

        model_class.create(object_attrs) unless model_class.find_by_text(object_attrs["text"])
      end
    end
  end
end