class Team < ActiveRecord::Base
  attr_accessible :date, :user_id, :points, :name, :game

  has_many :athletes_teams
  has_many :athletes, :through => :athletes_teams
  belongs_to :user
  belongs_to :game

  accepts_nested_attributes_for :athletes

  after_create :create_game_if_not_present!
  # validate :athletes, :length => {:is => 5, :message => "Must have 5 athletes per team"}#, :on => :create
  # validate :must_have_5_unique_positions

  
  def athlete_ids=(athlete_ids)
    self.athletes += Athlete.find_all_by_id(athlete_ids)
  end

  def total_fantasy_points
    total_points = 0
    self.athletes.each do |athlete|
      total_points += athlete.fantasy_points
    end
    total_points
  end

  def calculate_fantasy_points
    self.athletes.each do |athlete|
      athlete.find_stats(self.id)
    end
    total_fantasy_points
  end

  private

  def create_game_if_not_present!
    self.build_game unless self.game.present?
    self.save
  end

  def must_have_5_unique_positions
    positions = self.athletes.map(&:position)
    if positions.uniq.length != positions.length
      errors.add(:team, "must have a Point Guard, Center, Shooting Guard, Power Forward, and Small Forward")
    end
  end

  # helper_method :total_fantasy_points


end
