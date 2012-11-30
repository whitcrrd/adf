require 'NbaSeasonAverage'

namespace :db do
  desc "add every nba team, then add players and their stats to the first"
  task :test_pop => :environment do
    NbaSeasonAverage.populate_nba_teams
    teams = ProfessionalTeam.all
    teams.each do |team|
      NbaSeasonAverage.get_player_averages(team)
    end
  end
end
