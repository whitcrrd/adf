namespace :db do
  desc "add fake athletes to the db"
  task :populate => :environment do
    50.times do
      FactoryGirl.create(:athlete)
    end
  end
end