require 'NbaLiveStat'

namespace :db do
  desc "update current playing players with their stats"
  task :update_live_players => :environment do
    NbaLiveStat.get_teams_playing_and_call_stats
  end
end
