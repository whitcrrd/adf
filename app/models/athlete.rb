class Athlete < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :position, :professional_team

  has_and_belongs_to_many :teams
end
