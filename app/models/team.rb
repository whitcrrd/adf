class Team < ActiveRecord::Base
  attr_accessible :date, :user_id, :points, :name, :game_id

  has_many :athletes_teams
  has_many :athletes, :through => :athletes_teams
  belongs_to :user
  belongs_to :game

  validates :athletes, :length => {:is => 5}

  validate :must_have_5_unique_positions

  def athlete_ids=(athlete_ids)
    self.athletes += Athlete.find_all_by_id(athlete_ids)
  end

  def total_fantasy_points
    self.athletes.sum(:fantasy_points)
  end

private
  def must_have_5_unique_positions
    positions = self.athletes.map(&:position)
    if positions.uniq.length != positions.length
      errors.add(:team, "must have a Point Guard, Center, Shooting Guard, Power Forward, and Small Forward")
    end
  end

  # helper_method :total_fantasy_points

end
