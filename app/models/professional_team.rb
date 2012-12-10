class ProfessionalTeam < ActiveRecord::Base
  attr_accessible :name, :playing_today, :short_name, :espn_box_score_id, :game_time

  has_many :athletes

end
