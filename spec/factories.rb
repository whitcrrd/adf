require 'factory_girl'

positions = ["PG", "C", "SG", "PF", "SF"]
teams = ["Atlanta Hawks",
"Boston Celtics",
"Charlotte Bobcats",
"Chicago Bulls",
"Cleveland Cavaliers",
"Dallas Mavericks",
"Denver Nuggets",
"Detroit Pistons",
"Golden State Warriors",
"Houston Rockets",
"Indiana Pacers",
"Los Angeles Clippers",
"Los Angeles Lakers",
"Memphis Grizzlies",
"Miami Heat",
"Milwaukee Bucks",
"Minnesota Timberwolves",
"New Jersey Nets",
"New Orleans Hornets",
"New York Knicks",
"Oklahoma City Thunder",
"Orlando Magic",
"Philadelphia 76ers",
"Phoenix Suns",
"Portland Trail Blazers",
"Sacramento Kings",
"San Antonio Spurs",
"Toronto Raptors",
"Utah Jazz",
"Washington Wizards"]

FactoryGirl.define do
  factory :athlete do |athlete|
    athlete.first_name  {Faker::Name.first_name}
    athlete.last_name   {Faker::Name.last_name}
    athlete.professional_team {teams.sample}
    athlete.position {positions.sample}
  end
end
