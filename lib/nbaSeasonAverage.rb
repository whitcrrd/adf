require 'nokogiri'
require 'open-uri'

module NbaSeasonAverage

  # http://espn.go.com/nba/team/stats/_/name/okc/oklahoma-city-thunder
  def self.get_player_averages(team_object)
    root_url = "http://espn.go.com/nba/team/stats/_/name/"
    full_url = "#{root_url}#{team_object.short_name}/#{team_object.name}"
    doc = Nokogiri::HTML(open(full_url),nil,'ISO-8859-1')
    player_avg_table = doc.at_css('table.tablehead')
    table_rows = player_avg_table.css("tr")
    player_stats_rows = []
    table_rows.each do |node|
      unless node['class'] == nil
        player_stats_rows << node if node['class'].include?('player')
      end
    end
    player_stats_rows.each do |stats_row|
      these_stats = stats_from_row(stats_row)
      ath_full_name = these_stats.delete(:full_name)
      ath_position = these_stats.delete(:position)
      athlete = team_object.athletes.find_or_create_by_full_name(:full_name => ath_full_name, :position => ath_position)
      athlete.update_attributes(:professional_team_id => team_object.id) if athlete.professional_team_id == nil
      season_average = athlete.season_average || SeasonAverage.new(:athlete => athlete)
      season_average.update_attributes(these_stats)
    end
  end

  def self.stats_from_row(stats_row)
    {
     :full_name => stats_row.css('td')[0].xpath('.//a')[0].text,
     :position => stats_row.css('td')[0].text.split(',')[-1].strip,
     :games => stats_row.css('td')[1].text,
     :games_started => stats_row.css('td')[2].text,
     :minutes => stats_row.css('td')[3].text,
     :points => stats_row.css('td')[4].text,
     :offensive_rebounds => stats_row.css('td')[5].text,
     :defensive_rebounds => stats_row.css('td')[6].text,
     :rebounds => stats_row.css('td')[7].text,
     :assists => stats_row.css('td')[8].text,
     :steals => stats_row.css('td')[9].text,
     :blocks => stats_row.css('td')[10].text,
     :turnovers => stats_row.css('td')[11].text,
     :personal_fouls => stats_row.css('td')[12].text
    }
  end

  @nba_teams = [ ["bos", "boston-celtics"], ["bkn", "brooklyn-nets"], ["ny", "new-york-knicks"], ["phi", "philadelphia-76ers"], ["tor", "toronto-raptors"], ["chi", "chicago-bulls"], ["cle", "cleveland-cavaliers"], ["det", "detroit-pistons"], ["ind", "indiana-pacers"], ["mil", "milwaukee-bucks"], ["atl", "atlanta-hawks"], ["cha", "charlotte-bobcats"], ["mia", "miami-heat"], ["orl", "orlando-magic"], ["wsh", "washington-wizards"], ["gsw", "golden-state-warriors"], ["lac", "los-angeles-clippers"], ["lal", "los-angeles-lakers"], ["phx", "phoenix-suns"], ["sac", "sacramento-kings"], ["dal", "dallas-mavericks"], ["hou", "houston-rockets"], ["mem", "memphis-grizzlies"], ["no", "new-orleans-hornets"], ["sa", "san-antonio-spurs"], ["den", "denver-nuggets"], ["min", "minnesota-timberwolves"], ["okc", "oklahoma-city-thunder"], ["por", "portland-trail-blazers"], ["unlesstah", "utah-jazz"]
    ]

  def self.populate_nba_teams
    @nba_teams.each do |team|
      ProfessionalTeam.find_or_create_by_name(:name => team[1], :short_name => team[0])
    end
  end
end



