Rake tasks to setup the database:

rake db:test_pop to populate all players
rake db:reset_nba_schedule to reset team table for the day
rake db:set_play_today to set games for the day
rake db:update_live_players to get live stats for current games
rake db:set_results to update wins on a game and set points to a team
