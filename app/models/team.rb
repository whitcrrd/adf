class Team < ActiveRecord::Base
  attr_accessible :date, :user_id, :points, :name, :game_id

  has_many :athletes_teams
  has_many :athletes, :through => :athletes_teams
  belongs_to :user
  belongs_to :game

  def athlete_ids=(athlete_ids)
    self.athletes += Athlete.find_all_by_id(athlete_ids)
  end

  def total_fantasy_points
    @team = Team.find(params[:id])
    @total_points = 0
    @team.athletes.each do |athlete|
      @total_points = @total_points + athlete.fantasy_points
    end
    @total_points
  end

  # helper_method :total_fantasy_points

end
