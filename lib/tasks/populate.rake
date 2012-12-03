namespace :db do
  desc "add fake athletes to the db"
  task :populate => :environment do
    50.times do
      FactoryGirl.create(:athlete)
    end
  end

  desc "add users and teams to the db"
    task :populate => :environment do
      15.times do
        FactoryGirl.create(:user)
      end
    end

    task :populate => :environment do
      15.times do
        FactoryGirl.create(:team)
      end
    end
end