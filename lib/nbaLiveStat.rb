require 'nokogiri'
require 'open-uri'

module NbaLiveStat

  def self.get_teams_playing_and_call_stats
    now = Time.now.utc + Time.zone_offset('EST')
    now_hour = now.strftime("%H").to_i
    now_min = now.strftime("%M").to_i/60.0
    now_num = now_hour + now_min
    home_teams = ProfessionalTeam.where("espn_box_score_id is NOT null")
    home_teams.each do |team|
      update_athletes_live_stats(team) if now_num > ( team.game_time || 0 )
    end
  end

  def self.update_athletes_live_stats(team_object)
    box_score_root = "http://scores.espn.go.com/nba/boxscore?gameId="
    box_score_url = box_score_root + "#{team_object.espn_box_score_id}"
    doc = Nokogiri::HTML(open(box_score_url), nil, 'ISO-8859-1')
    box_score_table_bodys = doc.css("table.mod-data tbody")
    table_rows = box_score_table_bodys.css("tr")
    player_stats_rows = []
    table_rows.each do |node|
      unless node['class'] == nil
        player_stats_rows << node if node['class'].include?('player')
      end
    end
    player_stats_rows.each do |row|
      these_stats = stats_from_row(row)
      ath_full_name = these_stats.delete(:full_name)
      athlete = Athlete.find_or_create_by_full_name(:full_name => ath_full_name)
      date_today = (Time.now.utc + Time.zone_offset('EST')).to_date
      date_today -= 1 if (Time.now.strftime("%H").to_i) < 12
      current_stat = athlete.current_stats.find_by_game_date(date_today) || athlete.current_stats.build(:game_date => date_today)
      current_stat.update_attributes(these_stats)
    end
  end

  def self.stats_from_row(row)
    {
      :full_name => row.css('td')[0].xpath('.//a')[0].text,
      :minutes => ((row.css('td')[1] == nil || row.css('td')[1].text.length > 2) ? 0 : row.css('td')[1].text),
      :field_goals => (row.css('td')[2] == nil ? 0 : row.css('td')[2].text),
      :three_pointers => (row.css('td')[3] == nil ? 0 : row.css('td')[3].text),
      :free_throws => (row.css('td')[4] == nil ? 0 : row.css('td')[4].text),
      :offensive_rebounds => (row.css('td')[5] == nil ? 0 : row.css('td')[5].text),
      :defensive_rebounds => (row.css('td')[6] == nil ? 0 : row.css('td')[6].text),
      :rebounds => (row.css('td')[7] == nil ? 0 : row.css('td')[7].text),
      :assists => (row.css('td')[8] == nil ? 0 : row.css('td')[8].text),
      :steals => (row.css('td')[9] == nil ? 0 : row.css('td')[9].text),
      :blocks => (row.css('td')[10] == nil ? 0 : row.css('td')[10].text),
      :turnovers => (row.css('td')[11] == nil ? 0 : row.css('td')[11].text),
      :personal_fouls => (row.css('td')[12] == nil ? 0 : row.css('td')[12].text),
      :plus_minus => (row.css('td')[13] == nil ? 0 : row.css('td')[13].text),
      :points => (row.css('td')[14] == nil ? 0 : row.css('td')[14].text)
    }
  end

end
