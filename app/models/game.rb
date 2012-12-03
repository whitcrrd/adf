class Game < ActiveRecord::Base
  attr_accessible :winner_id, :loser_id, :teams, :teams_attributes

  has_many :teams
  accepts_nested_attributes_for :teams, :reject_if => proc { |attributes| attributes['name'].blank? }
  belongs_to :winner, :class_name => "Team"
  belongs_to :loser, :class_name => "Team"
  
  delegate :user_name, :to => :winner, :prefix => true, :allow_nil => true # call game.winner_user_name to get name of winner
  delegate :user_name, :to => :loser, :prefix => true, :allow_nil => true # call game.loser_user_name to get name of loser
  
  scope :all_user_games, lambda { |input| joins(:teams).where("teams.user_id = ?", input).order("teams.created_at desc").uniq }

  # Add @game.game_winner to game show view to display the winner of the game
  MAX_TEAM_COUNT = 2
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

  def full?
    self.teams.count >= MAX_TEAM_COUNT
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
