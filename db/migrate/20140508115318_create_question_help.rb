class CreateQuestionHelp < ActiveRecord::Migration
  def change
    create_table :question_help_messages do |t|
      t.text :message_en
      t.text :message_s

      t.timestamps
    end
  end
end
