require 'nokogiri'
require 'open-uri'
class Athlete < ActiveRecord::Base
  POSITIONS = ['PG', 'SG', 'SF', 'PF', 'C']
  attr_accessible :first_name, :last_name, :position, :professional_team, :season_average, :full_name, :current_stats

  belongs_to :professional_team

  has_many :athletes_teams
  has_many :teams, :through => :athletes_teams
  has_many :current_stats

  has_one :season_average
  has_many :current_stats

  # scope :top_pos, lambda { |input|  joins(:professional_team, :season_average).where("professional_teams.game_time is not null and athletes.position = '#{input}'").limit(10).order("season_averages.points DESC").includes(:professional_team)}
  scope :top_pos, lambda { |input|  joins(:professional_team, :season_average).select("athletes.*, (season_averages.points + season_averages.rebounds + season_averages.assists) as fantasy_points").where("professional_teams.game_time is not null and athletes.position = ?", input).order("fantasy_points desc").limit(10)
  }
  
  # (season_averages.points + season_averages.rebounds + season_averages.assists) AS 

  def find_stats(team_id)
    @team_id = team_id
    team = Team.find(team_id)
    # @stat = self.current_stats.find_by_game_date(self.teams.find_by_.date)
    @stat = self.current_stats.find_by_game_date(team.date)
  end

  def points
    return 0 unless find_stats(@team_id)
    @stat.points
  end

  def rebound_points
    return 0 unless find_stats(@team_id)
    @stat.rebounds
  end

  def assist_points
    return 0 unless find_stats(@team_id)
    @stat.assists
  end

  def fantasy_points
    points + rebound_points + assist_points
  end

  def url_name
    return 'nene' if self.full_name =~ /^Nen/
    self.full_name.split(' ').join('_').gsub(/[\.\']/, '').gsub('_Jr', '').downcase
  end
  
  def self.top_by_position
    athletes = []
    POSITIONS.each { |pos| athletes += top_pos(pos) }
    athletes
  end
  
  def self.top_tens_by_position
    POSITIONS.collect { |pos| top_pos(pos) }
  end


end
