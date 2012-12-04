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
  
  # factory :game do |game|
  #   a = FactoryGirl.build(:team)
  #   b = FactoryGirl.build(:team)
  #   a.game_id = game.id
  #   b.game_id = game.id
  #   game.winner_id = a.id
  #   game.loser_id = b.id
  # end
end









