require 'spec_helper'

describe Athlete do
  context "associations" do
    it { should have_many :athletes_teams }
    it { should have_many(:teams).through(:athletes_teams) }
    it { should have_many(:current_stats)}
    it { should have_one(:season_average) }
  end
  
  describe "#find_stats" do
    it "should find stats for a team given a team_id" do
      team = FactoryGirl.create(:team)
      user_team = Team.find(team.id)
      current_stat = FactoryGirl.create(:current_stat)
      stat = self.current_stats.find_by_game_date(team.date)
      stat.should be_an_instance_of(current_stat)
    end
  end
end