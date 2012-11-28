class Game < ActiveRecord::Base
  attr_accessible :away_team_id, :home_team_id, :winner_id, :loser_id

  has_many :teams
  
  # Add @game.game_winner to game show view to display the winner of the game
  def game_winner
    find_teams
    if @home_team.points > @away_team.points
      self.winner_id = self.home_team_id
      self.loser_id = self.away_team_id
      @home_team.name
    else
      self.winner_id = self.away_team_id
      self.loser_id = self.home_team_id
      @away_team.name
    end
  end
  
  def find_teams
    @away_team = Team.find(params[:away_team_id])
    @home_team = Team.find(params[:home_team_id])
  end
end
