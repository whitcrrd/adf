require 'dailyResults'

namespace :db do 
  desc "set the results for each of the games from today"
  task :set_results => :environment do
    DailyResults.set_daily_results
  end
end