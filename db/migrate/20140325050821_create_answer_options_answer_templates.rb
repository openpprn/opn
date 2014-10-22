class CreateAnswerOptionsAnswerTemplates < ActiveRecord::Migration
  def change
    create_table :answer_options_answer_templates do |t|
      t.references :answer_template
      t.references :answer_option

      t.timestamps
    end
  end
end
