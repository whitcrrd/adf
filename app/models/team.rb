class Team < ActiveRecord::Base
  attr_accessible :date, :user_id, :points, :name, :game

  has_many :athletes_teams
  has_many :athletes, :through => :athletes_teams
  belongs_to :user
  belongs_to :game
  
  delegate :name, :to => :user, :prefix => true, :allow_nil => true

  accepts_nested_attributes_for :athletes

  before_create :set_date
  after_create :create_game_if_not_present!
  validate :athletes, :length => {:is => 5, :message => "Must have 5 athletes per team"}#, :on => :create
  validate :must_have_5_unique_positions

  scope :all_user_teams, lambda { |input| where("user_id = ?", input).order("created_at DESC") }
  scope :all_teams_today, select("*").where("date = ?", Date.today)
  
  def athlete_ids=(athlete_ids)
    self.athletes += Athlete.find_all_by_id(athlete_ids)
  end
  
  def set_fantasy_points!
    self.points = calculate_fantasy_points
    self.save
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
  
  def set_date
    self.date = (Time.now.utc + Time.zone_offset('PST')).to_date
  end
  
  def name=(new_name)
    new_name = "Team_#{date}" if new_name.blank?
    super(new_name)
  end

  # helper_method :total_fantasy_points


end
