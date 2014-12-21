class ChangeDefaultValueOfVotesCountOnResearchTopics < ActiveRecord::Migration
  def up
    change_column_default :research_topics, :votes_count, 0
    ResearchTopic.all.each do |r|
      r.votes_count = 0
      r.save
    end
  end

  def down
    change_column_default :research_topics, :votes_count, nil
    ResearchTopic.all.each do |r|
      r.votes_count = nil
      r.save
    end

  end
end
