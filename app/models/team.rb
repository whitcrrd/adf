class Team < ActiveRecord::Base
  attr_accessible :date, :user_id, :points, :name, :game

  has_many :athletes_teams
  has_many :athletes, :through => :athletes_teams
  belongs_to :user
  belongs_to :game

  accepts_nested_attributes_for :athletes

  after_create :create_game_if_not_present!

  def athlete_ids=(athlete_ids)
    self.athletes += Athlete.find_all_by_id(athlete_ids)
  end

  def total_fantasy_points
    self.athletes.sum(:fantasy_points)
  end

  private
  def create_game_if_not_present!
    self.build_game unless self.game.present?
    self.save
  end
end
