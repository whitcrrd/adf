require 'NbaSeasonAverage'

namespace :db do
  desc "add lakers athletes and their season averages"
  task :season_average => :environment do
    NbaSeasonAverage.get_player_averages("lakers")
  end
end
