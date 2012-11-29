class SeasonAverage < ActiveRecord::Base
  attr_accessible :games, :games_started, :minutes, :free_throws, :field_goals, :three_pointers, :offensive_rebounds, :defensive_rebounds, :rebounds, :assists, :steals, :blocks, :turnovers, :personal_fouls, :points, :athlete

  belongs_to :athlete

end
