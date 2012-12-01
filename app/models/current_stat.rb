class CurrentStat < ActiveRecord::Base
  attr_accessible :minutes, :field_goals, :three_pointers, :free_throws, :offensive_rebounds, :defensive_rebounds, :rebounds, :assists, :steals, :blocks, :personal_fouls, :plus_minus, :points, :turnovers, :game_date, :athlete_id

  belongs_to :athlete

end

#
# # Sample code
# c = CurrentStat.new
# a = Athlete.new
#
# # add current stat to athlete's list
# a.current_stats << c
#
# # create a new stat for the athlete (will auto-populate stat.athlete_id)
# a.current_stats.build
#
# # add the athlete to the stat
# c.athlete = a
