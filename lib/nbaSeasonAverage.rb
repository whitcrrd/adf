require 'nokogiri'
require 'open-uri'

module NbaSeasonAverage

  def self.get_player_averages(team_name)
    root_url = "http://www.nba.com/"
    last_url = "/stats/2012"
    full_url = "#{root_url}#{team_name}#{last_url}"
    doc = Nokogiri::HTML(open(full_url),nil,'ISO-8859-1')
    player_avg_table = doc.at_css('.feeds-stats > table')
    player_rows = player_avg_table.css('tr').drop(2).reverse.drop(2).reverse
    player_rows.each do |stats_row|
      these_stats = stats_from_row(stats_row)
      athlete_full_name = these_stats.delete(:full_name)
      athlete = Athlete.find_or_create_by_full_name(:full_name => athlete_full_name, :professional_team => team_name)
      season_average = athlete.season_average || SeasonAverage.new(:athlete => athlete)
      season_average.update_attributes(these_stats)
    end
    puts "done"
  end

  def self.stats_from_row(stats_row)
    {
      :full_name => stats_row.css('td')[0].text,
      :games => stats_row.css('td')[1].text,
      :games_started => stats_row.css('td')[2].text,
      :minutes => stats_row.css('td')[3].text,
      :field_goals => stats_row.css('td')[4].text,
      :three_pointers => stats_row.css('td')[5].text,
      :free_throws => stats_row.css('td')[6].text,
      :offensive_rebounds => stats_row.css('td')[7].text,
      :defensive_rebounds => stats_row.css('td')[8].text,
      :rebounds => stats_row.css('td')[9].text,
      :assists => stats_row.css('td')[10].text,
      :steals => stats_row.css('td')[11].text,
      :blocks => stats_row.css('td')[12].text,
      :turnovers =>stats_row.css('td')[13].text,
      :personal_fouls => stats_row.css('td')[14].text,
      :points => stats_row.css('td')[15].text
    }
  end

end