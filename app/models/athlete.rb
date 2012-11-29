require 'nokogiri'
require 'open-uri'
class Athlete < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :position, :professional_team, :season_average, :full_name



  has_many :athletes_teams
  has_many :teams, :through => :athletes_teams
  has_one :season_average

end
