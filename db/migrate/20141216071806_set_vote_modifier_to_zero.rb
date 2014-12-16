class SetVoteModifierToZero < ActiveRecord::Migration
  def up
    User.all.each do |user|
      user.vote_modifier = 0;
      user.save
    end
  end

  def down
    # not much we can do here
  end
end
