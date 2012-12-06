require 'dailySetup'

namespace :db do
  desc "resets box score ids and game times to nil for every team"
  task :reset_nba_schedule => :environment do
    DailySetup.reset_daily_schedule
  end
end
