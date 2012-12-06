module DailyResults
  def self.set_daily_results
    games_today = Game.all#_games_today
    teams_today = Team.all#_teams_today
    teams_today.each { |team| team.set_fantasy_points! }
    games_today.each do |game|
      if game.full?
        puts game.id
        game.assign_results!
      end
    end
  end
end
