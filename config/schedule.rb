# Learn more: http://github.com/javan/whenever

set :output, "#{path}/log/cron.log"
set :environment, "development"

# initialize game with reset of professional_teams and current_stats
every 1.day, :at => "3:00 am" do
  rake "db:reset_nba_schedule"
end

every 1.day, :at => "4:00 am" do
  rake "db:set_play_today"
end

every 1.day, :at => "11:45 pm" do
  rake "db:set_results"
end

every 10.minutes do
  rake "db:update_live_players"
end

