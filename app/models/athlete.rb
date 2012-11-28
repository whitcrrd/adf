class Athlete < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :position, :professional_team

  has_many :athletes_teams
  has_many :teams, :through => :athletes_teams
end
