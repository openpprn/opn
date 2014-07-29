# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


unless Rails.env == "test"
  to_keep = [ "users", "schema_migrations"]
  tables = [
      "answer_types",
      "question_answer_options",
      "answer_sessions",
      "answers",
      "answer_values",
      "questions",
      "answer_edges",
      "units",
      "question_help_messages",
      "answer_options",
      "question_types",
      "question_edges",
      "question_flows",
      "votes",
      "groups"
  ]

  tables.each do |table|
    ActiveRecord::Base.connection.execute("TRUNCATE #{table}")
    ActiveRecord::Base.connection.execute("SELECT SETVAL('#{table}_id_seq', 100000000)")
  end

  files = [
      ["units.yml", Unit],
      ["groups.yml", Group],
      ["answer_types.yml", AnswerType],
      ["question_types.yml", QuestionType],
      ["answer_options.yml", AnswerOption],
      ["question_help_messages.yml", QuestionHelpMessage],
      ["questions.yml", Question],
      ["question_flows.yml", QuestionFlow],
  ]

  files.each do |file_name, model_class|
    file_path = Rails.root.join('lib', 'data', 'surveys', file_name)

    puts(file_path)

    yaml_data = YAML.load_file(file_path)

    yaml_data.each do |object_attrs|
      #MY_LOG.info object_attrs
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
    nil
  else
    user = User.create(email: "piotr.mankowski@gmail.com", password: "12345678")
  end
end
