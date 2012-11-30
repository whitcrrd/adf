require 'NbaLiveStat'

namespace :db do
  desc "change the teams playing today to true"
  task :set_play_today => :environment do
    NbaLiveStat.set_teams_playing_today
  end
end
