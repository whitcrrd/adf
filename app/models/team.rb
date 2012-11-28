class Team < ActiveRecord::Base
  attr_accessible :date, :user_id, :points, :name, :game_id

  has_many :athletes_teams
  has_many :athletes, :through => :athletes_teams
  belongs_to :user
  belongs_to :game

  def athlete_ids=(athlete_ids)
    self.athletes = Athlete.find_all_by_id(athlete_ids)
  end
  
  def points
    #calculate points from that day's box score
  end
end
