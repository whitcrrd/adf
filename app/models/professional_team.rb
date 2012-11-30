class ProfessionalTeam < ActiveRecord::Base
  attr_accessible :name, :playing_today, :short_name, :espn_box_score_id

  has_many :athletes
end
