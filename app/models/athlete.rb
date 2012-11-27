class Athlete < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :position, :professional_team_id

  has_and_belongs_to_many :teams
  belongs_to :professional_team
end
