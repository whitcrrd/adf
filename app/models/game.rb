class Game < ActiveRecord::Base
  attr_accessible :away_team_id, :home_team_id, :winner_id, :loser_id

  has_many :teams
end
