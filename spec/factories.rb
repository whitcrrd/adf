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
    # athlete.professional_team {teams.sample}
    athlete.position {positions.sample}
  end

  factory :team do |team|
    team.date {Date.current}
    team.sequence(:user_id) {|n| "#{n}"}
    team.points {rand(0..100)}
    team.name {Faker::Name.first_name}
    team.sequence(:game_id) {|n| "#{n}"}
    # team.sequence(:user_id) {|n| "#{n}"}
  end

  factory :user do |user|
    user.name {Faker::Name.name}
  end
  
  factory :game do |game|
    game.winner_id {rand(0..100)}
    game.loser_id {rand(0..100)}
  end

  factory :season_average do
  end



  factory :professional_team do
    name "MyString"
    playing_today false
  end
  
  factory :current_stat do |stat|
    stat.minutes {rand(0..48)}
    stat.points {rand(0..50)}
    stat.rebounds {rand(0..20)}
    stat.assists {rand(0..15)}
  end
end









