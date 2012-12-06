require 'nokogiri'
require 'open-uri'

module DailySetup
  # def self.set_teams_playing_today(url="http://scores.espn.go.com/nba/scoreboard")
  def self.set_daily_schedule(url="http://scores.espn.go.com/nba/scoreboard")
    doc = Nokogiri::HTML(open(url))
    doc.css('div.mod-nba-scorebox').each do |box_score_div|
      game_start_time = box_score_div.at_css('div.game-status p').text
      game_time_hour = game_start_time.split(":")[0].to_i
      game_time_hour = game_time_hour + 12 unless game_time_hour == 12
      game_time_min = 0#game_start_time.split(":")[1].split(' ')[0].to_i/60.0 unless game_start_time == "Final"
      game_time_num = game_time_hour + game_time_min unless game_start_time == "Final"
      box_score_id = box_score_div.at_css('div.game-status p').attributes()['id'].value().split('-')[0]
      away_team = box_score_div.css('p.team-name').xpath('.//a')[0].attributes()["href"].value().split('/')[-1]
      home_team = box_score_div.css('p.team-name').xpath('.//a')[1].attributes()["href"].value().split('/')[-1]
      away_team_obj = ProfessionalTeam.find_or_create_by_name(away_team)
      home_team_obj = ProfessionalTeam.find_or_create_by_name(home_team)
      away_team_obj.update_attributes(:game_time => game_time_num)
      home_team_obj.update_attributes(:game_time => game_time_num, :espn_box_score_id => box_score_id)
    end
  end

  def self.reset_daily_schedule
    teams = ProfessionalTeam.all
    teams.each do |team|
      team.update_attributes(:espn_box_score_id => nil, :game_time => nil)
    end
  end

end