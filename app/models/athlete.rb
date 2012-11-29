class Athlete < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :position, :professional_team

  has_many :athletes_teams
  has_many :teams, :through => :athletes_teams

  # def points
  #   self.athletes.livestats.points
  # end
  #
  # def rebound_points
  #   self.athletes.livestats.rebounds
  # end
  #
  # def assist_points
  #   self.athletes.livestats.assists * 1.5
  # end
  #
  # def fantasy_points
  #   points + rebound_points + assist_points
  # end

  # helper_method :fantasy_points

end
