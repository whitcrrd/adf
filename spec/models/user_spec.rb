require 'spec_helper'

describe User do
  
  context "associations" do
    it { should have_many(:teams) }
    it { should have_many(:games).through(:teams) }
  end
  
  it "should respond to teams" do
    user = User.new
    user.should respond_to(:teams)
  end
  
  describe "#new" do
    it "should have a default value of 0 for wins" do 
      user = FactoryGirl.create(:user)
      user.wins.should eq 0
    end 
  end
  
  describe ".add_wins" do
    it "should increase users wins by 1" do
      user = FactoryGirl.create(:user)      
      user.add_win
      user.wins.should eq 1
    end
    
    it "should increase users wins by 1 again" do
      user = FactoryGirl.create(:user)
      2.times do 
        user.add_win
      end
      user.wins.should eq 2
    end
  end
  
  describe ".add_loss" do
    it "should increase users losses by 1" do
      user = FactoryGirl.create(:user)      
      user.add_loss
      user.losses.should eq 1
    end
    
    it "should increase users losses by 1 again" do
      user = FactoryGirl.create(:user)
      2.times do 
        user.add_loss
      end
      user.losses.should eq 2
    end
  end
  
  describe ".last_five_teams" do
    it "should show last 5 teams" do
      user = FactoryGirl.create(:user)
      6.times do
        user.teams.create
      end
      last_five = user.last_five_teams
      last_five.length.should eq 5
    end
  end
end

















