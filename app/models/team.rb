class Team < ActiveRecord::Base
  attr_accessible :date, :user_id, :points

  has_many :athletes_teams
  has_many :athletes, :through => :athletes_teams
  belongs_to :user

  def athlete_ids=(athlete_ids)
    self.athletes = Athlete.find_all_by_id(athlete_ids)
  end
end
