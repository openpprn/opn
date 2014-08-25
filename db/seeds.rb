# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


## To re-create and re-seed database (including test fixtures)
# bundle exec rake db:drop; bundle exec rake db:create; bundle exec rake db:migrate; bundle exec rake db:fixtures:load RAILS_ENV=development; bundle exec rake db:seed;

unless Rails.env == "test"



  to_keep = [ "users", "schema_migrations"]
  tables = [
      "answer_edges",
      "answer_options",
      "answer_options_answer_templates",
      "answer_sessions",
      "answer_templates",
      "answer_templates_questions",
      "answer_values",
      "answers",
      "comments",
      "display_types",
      "groups",
      "posts",
      "question_edges",
      "question_flows",
      "question_help_messages",
      "questions",
      "units",
      "votes"
  ]

  tables.each do |table|
    ActiveRecord::Base.connection.execute("TRUNCATE #{table}")
    ActiveRecord::Base.connection.execute("SELECT SETVAL('#{table}_id_seq', 100000000)")
  end

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

  qe_path = Rails.root.join('lib', 'data', 'surveys', 'question_edges.yml')
  puts(qe_path)

  yaml_data = YAML.load_file(qe_path)

  yaml_data.each_with_index do |attrs, i|

    q1 = Question.find(attrs['parent_question_id'])
    q2 = Question.find(attrs['child_question_id'])

    qe = QuestionEdge.build_edge(q1, q2, attrs['condition'], attrs['question_flow_id'])

    puts("Creating edge #{i} of #{yaml_data.length} between #{q1.id} and #{q2.id}")
    raise StandardError, qe.errors.full_messages unless qe.save
  end

  QuestionFlow.all.each {|qf| qf.reset_paths }

  if (user = User.find_by_email("piotr.mankowski@gmail.com"))
    user.add_role :admin
    user.add_role :owner
  else
    user = User.create(email: "piotr.mankowski@gmail.com", password: "12345678")
    user.add_role :admin
    user.add_role :owner
  end
end
