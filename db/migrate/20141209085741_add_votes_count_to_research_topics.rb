class AddVotesCountToResearchTopics < ActiveRecord::Migration
  def change
    add_column :research_topics, :votes_count, :integer
  end
end
