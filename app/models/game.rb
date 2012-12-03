class Game < ActiveRecord::Base
  attr_accessible :winner_id, :loser_id, :teams, :teams_attributes

  has_many :teams
  accepts_nested_attributes_for :teams, :reject_if => proc { |attributes| attributes['name'].blank? }
  belongs_to :winner, :class_name => "Team"
  belongs_to :loser, :class_name => "Team"
  
  delegate :user_name, :to => :winner, :prefix => true, :allow_nil => true # call game.winner_user_name to get name of winner
  delegate :user_name, :to => :loser, :prefix => true, :allow_nil => true # call game.loser_user_name to get name of loser
  
  scope :all_user_games, lambda { |input| joins(:teams).where("teams.user_id = ?", input).order("teams.created_at desc").uniq }
  
  # scope :today, where("game_time < ? and game_time >= ?", [Time.zone.now.end_of_day, Time.zone.now.beginning_of_day])

  MAX_TEAM_COUNT = 2
  def assign_results!
    self.winner = teams.max { |t1, t2| t1.score <=> t2.score }
    self.loser = teams.min { |t1, t2| t1.score <=> t2.score }
  end

  def full?
    self.teams.count >= MAX_TEAM_COUNT
  end
end
