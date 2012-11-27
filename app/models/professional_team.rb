class ProfessionalTeam < ActiveRecord::Base
  attr_accessible :name

  has_many :athletes
end
