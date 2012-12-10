class Team < ActiveRecord::Base
  attr_accessible :date, :user_id, :points, :name, :game, :game_id

  has_many :athletes_teams
  has_many :athletes, :through => :athletes_teams
  belongs_to :user
  belongs_to :game

  delegate :name, :to => :user, :prefix => true, :allow_nil => true

  accepts_nested_attributes_for :athletes

  before_create :set_date
  after_create :create_game_if_not_present!
  validate :athletes, :length => {:maximum => 5, :message => "Must have 5 athletes per team"}, :on => :update
  validate :must_have_5_unique_positions, :on => :update

  scope :all_user_teams, lambda { |input| where("user_id = ?", input).order("created_at DESC") }
  scope :all_teams_today, select("*").where("date = ?", Date.today)

  # REVIEW: separate methods into private and public

  def athlete_ids=(athlete_ids)
    self.athletes += Athlete.find_all_by_id(athlete_ids)
  end

  def set_fantasy_points!
    self.points = calculate_fantasy_points
    self.save
  end

  def total_fantasy_points
    # REVIEW: use inject/reduce
    total_points = 0
    self.athletes.each do |athlete|
      total_points += athlete.fantasy_points
    end
    total_points

    # Refactored ...
    # athletes.map(&:fantasy_points).inject(&:+)
  end

  def calculate_fantasy_points
    self.athletes.each do |athlete|
      athlete.find_stats(self.id)
    end
    total_fantasy_points
  end

  def create_game_if_not_present!
    # REVIEW: don't call save if no changes made
    unless self.game.present?
      self.build_game
      self.save
    end
  end

  def must_have_5_unique_positions
    positions = self.athletes.map(&:position)
    if positions.uniq.length != positions.length
      errors.add(:team, "must have a Point Guard, Center, Shooting Guard, Power Forward, and Small Forward")
    end
  end

  # def must_have_5_unique_positions
  #   positions = self.athletes.map(&:position)
  #   (positions.length < 2) if positions
  # end

  def save_and_swap_athletes_or_add_athlete(new_player)
    taken_positions = self.athletes.map(&:position)
    if taken_positions.include?(new_player.position)
      old_player = self.athletes.find_by_position(new_player.position)
      self.athletes.delete(old_player)
      self.athletes << new_player
    else
      self.athletes << new_player
    end

  end

  def position_available?(new_player)
    positions = self.athletes.map(&:position)
    return true unless positions.include?(new_player.position)
  end

  def position_already_taken?(new_player)
    positions = self.athletes.map(&:position)
    return true if positions.include?(new_player.position)
    false
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
