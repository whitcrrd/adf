require 'nokogiri'
require 'open-uri'
class Athlete < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :position, :professional_team, :season_average, :full_name

  belongs_to :professional_team

  has_many :athletes_teams
  has_many :teams, :through => :athletes_teams

  # def points
  #   self.athletes.livestats.points
  # end
  #
  # def rebound_points
  #   self.athletes.livestats.rebounds
  # end
  #
  # def assist_points
  #   self.athletes.livestats.assists * 1.5
  # end
  #
  # def fantasy_points
  #   points + rebound_points + assist_points
  # end

  # helper_method :fantasy_points

  has_one :season_average
  has_one :current_stat


end
