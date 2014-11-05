namespace :surveys do
  SEQUENCE_VALUE = 10000000

  desc "Truncate survey tables and create reserved id space for survey model tables by setting sequence startpoint"
  task :setup_db => :environment do
    survey_tables = [
        "answer_options",
        "answer_templates",
        "display_types",
        "groups",
        "questions",
        "question_flows",
        "question_help_messages",
        "units"
    ]

    survey_tables.each do |table|
      ActiveRecord::Base.connection.execute("TRUNCATE #{table}")
      ActiveRecord::Base.connection.execute("SELECT SETVAL('#{table}_id_seq', #{SEQUENCE_VALUE})")
    end
  end

  desc "Update all survey models except for question endges."
  task :update_questions => :environment do
    if warn_user
      tables_to_update = [
          "answer_options",
          "answr_options_answer_templates",
          "answer_templates",
          "answer_templates_questions",
          "display_types",
          "groups",
          "questions",
          "question_flows",
          "question_help_messages",
          "units"
      ]

      join_tables = [
          "answr_options_answer_templates",
          "answer_templates_questions"
      ]


      clean_tables(tables_to_update)
      clean_join_tables(join_tables)

      files = [
          ["units.yml", Unit],
          ["groups.yml", Group],
          ["display_types.yml", DisplayType],
          ["answer_options.yml", AnswerOption],
          ["answer_templates.yml", AnswerTemplate],
          ["question_help_messages.yml", QuestionHelpMessage],
          ["questions.yml", Question],
          ["question_flows.yml", QuestionFlow]
      ]



      files.each do |file_name, model_class|
        file_path = Rails.root.join('lib', 'data', 'surveys', file_name)

        puts(file_path)

        yaml_data = YAML.load_file(file_path)

        yaml_data.each do |object_attrs|
          puts object_attrs
          model_class.create(object_attrs)
        end
      end
    end
  end

  # TODO: MAKE THIS OPERATION SAFER FOR EXISTING ANSWER DATA
  desc "Update question edges."
  task :update_question_edges => :environment do
    if warn_user                        #      ActiveRecord::Base.connection.execute("SELECT SETVAL('#{table}_id_seq', 100000000)")

      clean_join_tables(["question_edges"])

      qe_path = Rails.root.join('lib', 'data', 'surveys', 'question_edges.yml')

      puts(qe_path)

      yaml_data = YAML.load_file(qe_path)

      yaml_data.each_with_index do |attrs, i|

        q1 = Question.find(attrs['parent_question_id'])
        q2 = Question.find(attrs['child_question_id'])

        qe = QuestionEdge.build_edge(q1, q2, attrs['condition'], attrs['question_flow_id'])

        puts("Creating edge #{i+1} of #{yaml_data.length} between #{q1.id} and #{q2.id}")
        raise StandardError, qe.errors.full_messages unless qe.save
      end

      QuestionFlow.all.each {|qf| qf.reset_paths }

    end

  end

  desc "Updates questions and question edges."
  task :update => :environment do
    Rake::Task["surveys:update_questions"].invoke
    Rake::Task["surveys:update_question_edges"].invoke
  end

  desc "Updates questions and question edges."
  task :create => :environment do
    Rake::Task["surveys:setup_db"].invoke
    Rake::Task["surveys:update"].invoke
  end


  def clean_tables(tables)
    tables.each do |table|
      ActiveRecord::Base.connection.execute("DELETE FROM #{table} where id < #{SEQUENCE_VALUE}")
    end



  end

  def clean_join_tables(tables)
    tables.each do |table|
      ActiveRecord::Base.connection.execute("truncate #{table}")
    end
  end

  def warn_user
    puts "WARNING: Any major changes to the ids or structure of the survey data will likely invalidate previously done answer sessions."
    puts "Are you sure you want to continue? (y/n)"

    STDIN.gets.strip == 'y'

  end
end
