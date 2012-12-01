require 'nokogiri'
require 'open-uri'
class Athlete < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :position, :professional_team, :season_average, :full_name, :current_stats

  belongs_to :professional_team

  has_many :athletes_teams
  has_many :teams, :through => :athletes_teams
  has_many :current_stats

  has_one :season_average
  has_many :current_stats




  def find_stats(team_id)
    @team_id = team_id
    team = Team.find(team_id)
    # @stat = self.current_stats.find_by_game_date(self.teams.find_by_.date)
    @stat = self.current_stats.find_by_game_date(team.date)
  end

  def points
    find_stats(@team_id)
    @stat.points
  end

  def rebound_points
     find_stats(@team_id)
     @stat.rebounds
  end

  def assist_points
     find_stats(@team_id)
     @stat.assists
  end

  def fantasy_points
    points + rebound_points + assist_points
  end

  def url_name
    return 'nene' if self.full_name =~ /^Nen/
    self.full_name.split(' ').join('_').gsub(/[\.\']/, '').gsub('_Jr', '').downcase
  end


end
