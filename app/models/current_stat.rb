class CurrentStat < ActiveRecord::Base
  attr_accessible :minutes, :field_goals, :three_pointers, :free_throws, :offensive_rebounds, :defensive_rebounds, :rebounds, :assists, :steals, :blocks, :personal_fouls, :plus_minus, :points

  belongs_to :athlete

end
