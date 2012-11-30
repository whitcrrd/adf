require 'nokogiri'
require 'open-uri'

module NbaLiveStat

  # def self.get_todays_game_ids(url="http://scores.espn.go.com/nba/scoreboard")
  #   doc = Nokogiri::HTML(open(url))
  #   doc.css('div.mod-nba-scorebox').each do |box_score_div|
  #     game_start_time = box_score_div.at_css('div.game-status p').text
  #     box_score_id = box_score_div.at_css('div.game-status p').attributes()['id'].value().split('-')[0]
  #     away_team = box_score_div.css('p.team-name').xpath('.//a')[0].attributes()["href"].value().split('/')[-1]
  #     home_team = box_score_div.css('p.team-name').xpath('.//a')[1].attributes()["href"].value().split('/')[-1]
  #     away_team_obj = ProfessionalTeam.find_or_create_by_name(away_team)
  #     home_team_obj = ProfessionalTeam.find_or_create_by_name(home_team)
  #     away_team_obj.update_attributes(:playing_today => true)
  #     home_team_obj.update_attributes(:playing_today => true)
  #   end
  # end

  def self.set_teams_playing_today(url="http://scores.espn.go.com/nba/scoreboard")
    doc = Nokogiri::HTML(open(url))
    doc.css('div.mod-nba-scorebox').each do |box_score_div|
      game_start_time = box_score_div.at_css('div.game-status p').text
      box_score_id = box_score_div.at_css('div.game-status p').attributes()['id'].value().split('-')[0]
      away_team = box_score_div.css('p.team-name').xpath('.//a')[0].attributes()["href"].value().split('/')[-1]
      home_team = box_score_div.css('p.team-name').xpath('.//a')[1].attributes()["href"].value().split('/')[-1]
      away_team_obj = ProfessionalTeam.find_or_create_by_name(away_team)
      home_team_obj = ProfessionalTeam.find_or_create_by_name(home_team)
      away_team_obj.update_attributes(:playing_today => true)
      home_team_obj.update_attributes(:playing_today => true, :espn_box_score_id => box_score_id)
    end
  end

  def self.get_teams_playing_and_call_stats
    home_teams = ProfessionalTeam.where("espn_box_score_id is NOT null")
    home_teams.each do |team|
      update_athletes_live_stats(team)
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
    player_stats_rows.each do |player_row|
      full_name = row.css('td')[0].xpath('.//a')[0].text
      a = Athlete.find_or_create_by_full_name(full_name)
      (row.css('td')[1] == nil || row.css('td')[1].text.length > 2) ? a.live_stats.minutes = 0 : a.live_stats.minutes = row.css('td')[1].text
      row.css('td')[2] == nil ? a.live_stats.field_goals = 0 : a.live_stats.field_goals = row.css('td')[2].text
      row.css('td')[3] == nil ? a.live_stats.three_pointers = 0 : a.live_stats.three_pointers = row.css('td')[3].text
      row.css('td')[4] == nil ? a.live_stats.free_throws = 0 : a.live_stats.free_throws = row.css('td')[4].text
      row.css('td')[5] == nil ? a.live_stats.offensive_rebounds = 0 : a.live_stats.offensive_rebounds = row.css('td')[5].text
      row.css('td')[6] == nil ? a.live_stats.defensive_rebounds = 0 : a.live_stats.defensive_rebounds = row.css('td')[6].text
      row.css('td')[7] == nil ? a.live_stats.rebounds = 0 : a.live_stats.rebounds = row.css('td')[7].text
      row.css('td')[8] == nil ? a.live_stats.assists = 0 : a.live_stats.assists = row.css('td')[8].text
      row.css('td')[9] == nil ? a.live_stats.steals = 0 : a.live_stats.steals = row.css('td')[9].text
      row.css('td')[10] == nil ? a.live_stats.blocks = 0 : a.live_stats.blocks = row.css('td')[10].text
      row.css('td')[11] == nil ? a.live_stats.turnovers = 0 : a.live_stats.turnovers = row.css('td')[11].text
      row.css('td')[12] == nil ? a.live_stats.personal_fouls = 0 : a.live_stats.personal_fouls = row.css('td')[12].text
      row.css('td')[13] == nil ? a.live_stats.plus_minus = 0 : a.live_stats.plus_minus = row.css('td')[13].text
      row.css('td')[14] == nil ? a.live_stats.points = 0 : a.live_stats.points = row.css('td')[14].text
      a.save
    end
  end


  # def self.get_player_averages(team_name)
  #   root_url = "http://www.nba.com/"
  #   last_url = "/stats/2012"
  #   full_url = "#{root_url}#{team_name}#{last_url}"
  #   doc = Nokogiri::HTML(open(full_url),nil,'ISO-8859-1')
  #   player_avg_table = doc.at_css('.feeds-stats > table')
  #   player_rows = player_avg_table.css('tr').drop(2).reverse.drop(2).reverse
  #   player_rows.each do |stats_row|
  #     these_stats = stats_from_row(stats_row)
  #     athlete_full_name = these_stats.delete(:full_name)
  #     athlete = Athlete.find_or_create_by_full_name(:full_name => athlete_full_name, :professional_team => team_name)
  #     season_average = athlete.season_average || SeasonAverage.new(:athlete => athlete)
  #     season_average.update_attributes(these_stats)
  #   end
  #   puts "done"
  # end

  # def self.stats_from_row(stats_row)
  #   {
  #     :full_name => stats_row.css('td')[0].text,
  #     :games => stats_row.css('td')[1].text,
  #     :games_started => stats_row.css('td')[2].text,
  #     :minutes => stats_row.css('td')[3].text,
  #     :field_goals => stats_row.css('td')[4].text,
  #     :three_pointers => stats_row.css('td')[5].text,
  #     :free_throws => stats_row.css('td')[6].text,
  #     :offensive_rebounds => stats_row.css('td')[7].text,
  #     :defensive_rebounds => stats_row.css('td')[8].text,
  #     :rebounds => stats_row.css('td')[9].text,
  #     :assists => stats_row.css('td')[10].text,
  #     :steals => stats_row.css('td')[11].text,
  #     :blocks => stats_row.css('td')[12].text,
  #     :turnovers =>stats_row.css('td')[13].text,
  #     :personal_fouls => stats_row.css('td')[14].text,
  #     :points => stats_row.css('td')[15].text
  #   }
  # end

  # @nba_teams = [ ["bos", "boston-celtics"], ["bkn", "brooklyn-nets"], ["ny", "new-york-knicks"], ["phi", "philadelphia-76ers"], ["tor", "toronto-raptors"], ["chi", "chicago-bulls"], ["cle", "cleveland-cavaliers"], ["det", "detroit-pistons"], ["ind", "indiana-pacers"], ["mil", "milwaukee-bucks"], ["atl", "atlanta-hawks"], ["cha", "charlotte-bobcats"], ["mia", "miami-heat"], ["orl", "orlando-magic"], ["wsh", "washington-wizards"], ["gsw", "golden-state-warriors"], ["lac", "los-angeles-clippers"], ["lal", "los-angeles-lakers"], ["phx", "phoenix-suns"], ["sac", "sacramento-kings"], ["dal", "dallas-mavericks"], ["hou", "houston-rockets"], ["mem", "memphis-grizzlies"], ["no", "new-orleans-hornets"], ["sa", "san-antonio-spurs"], ["den", "denver-nuggets"], ["min", "minnesota-timberwolves"], ["okc", "oklahoma-city-thunder"], ["por", "portland-trail-blazers"], ["utah", "utah-jazz"]
  #   ]
  #
  # def self.populate_nba_teams
  #   @nba_teams.each do |team|
  #     ProfessionalTeam.find_or_create_by_name(:name => team[1], :short_name => team[0])
  #   end
  # end

end
