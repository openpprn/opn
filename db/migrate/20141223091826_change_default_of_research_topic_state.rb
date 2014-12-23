class ChangeDefaultOfResearchTopicState < ActiveRecord::Migration
  def up
    change_column_default :research_topics, :state, "proposed"
  end

  def down
    change_column_default :research_topics, :state, "under_review"
  end
end
