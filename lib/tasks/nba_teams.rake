namespace :db do
  desc "nba teams to the database"
  task :nba_teams => :environment do
    NbaSeasonAverage.populate_nba_teams
  end
end
