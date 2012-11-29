class Game < ActiveRecord::Base
  attr_accessible :winner_id, :loser_id

  has_many :teams

  # Add @game.game_winner to game show view to display the winner of the game
  def game_winner
    find_teams
    if @home_team.points > @away_team.points
      self.winner_id = @home_team.id
      self.loser_id = @away_team.id
      @home_team.name
    elsif
      self.winner_id = @away_team.id
      self.loser_id = @home_team.id
      @away_team.name
    else
      "Tie Game"
    end
  end

  def find_teams
    teams_array = []
    if self.teams.length > 1
      self.teams.each do |team|
        teams_array << team
      end
      @away_team = Team.find_by_id(teams_array[0].id)
      @home_team = Team.find_by_id(teams_array[1].id)
    end
  end
end
