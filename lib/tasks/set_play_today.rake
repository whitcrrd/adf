require 'dailySetup'

namespace :db do
  desc "change the teams playing today to true"
  task :set_play_today => :environment do
    DailySetup.set_daily_schedule
  end
end
