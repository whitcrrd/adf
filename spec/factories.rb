require 'factory_girl'

positions = ["PG", "C", "SG", "PF", "SF"]

FactoryGirl.define do
  factory :athlete do |athlete|
    athlete.first_name  Faker::Name.first_name
    athlete.last_name   Faker::Name.last_name
    athlete.professional_team Faker::Lorem.word
    athlete.position positions.sample
  end
end
