require 'spec_helper'

describe Athlete do
  context "associations" do
    it { should have_many :athletes_teams }
    it { should have_many(:teams).through(:athletes_teams) }
    it { should have_many(:current_stats)}
    it { should have_one(:season_average) }
  end
  
  # describe "#find_stats" do
  #   it "should find stats for a team given a team_id" do
  #     team = FactoryGirl.create(:team)
  #     user_team = Team.find(team.id)
  #     current_stat = FactoryGirl.create(:current_stat)
  #     stat = self.current_stats.find_by_game_date(team.date)
  #     stat.should be_an_instance_of(current_stat)
  #   end
  # end
  before(:each) do
    @stats.stub(:blank?).and_return(false)
    @stats.stub(:points).and_return(20)
    @stats.stub(:rebounds).and_return(10)
    @stats.stub(:assists).and_return(9)
  end
  describe "#points_today" do
    it "should return the points scored by the athlete today" do
      athlete = FactoryGirl.create(:athlete)
      stats = FactoryGirl.create(:current_stat)
      stats.athlete = athlete
      athlete.points_today(Date.today).should eq 20
    end
  end
  
  describe "#rebounds_today" do
    it "should return the rebounds collected by the athlete today" do
      athlete = FactoryGirl.create(:athlete)
      stats = FactoryGirl.create(:current_stat)
      stats.athlete = athlete
      athlete.rebounds_today(Date.today).should eq 10
    end
  end
  
  describe "#assists_today" do
    it "should return the total assists by the athlete today" do
      athlete = FactoryGirl.create(:athlete)
      stats = FactoryGirl.create(:current_stat)
      stats.athlete = athlete
      athlete.assists_today(Date.today).should eq 9
    end
  end
  
  describe "#fantasy_points_today" do
    it "should return the sum of points, rebounds, and assists for the player that day" do
      athlete = FactoryGirl.create(:athlete)
      athlete.fantasy_points_today(Date.today).should eq 39
    end
  end
  
  describe "#points" do
    it "should return the number of points scored" #do
    #   athlete = FactoryGirl.create(:athlete)
    #   team = FactoryGirl.create(:team)
    #   stat = FactoryGirl.create(:current_stat)
    #   athlete.find_stat(team.id)
    #   athlete.points.should eq 0
    # end
  end
end

