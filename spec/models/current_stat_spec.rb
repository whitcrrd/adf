require 'spec_helper'

describe CurrentStat do
  it { should belong_to(:athlete) }
  
  describe "#set_fantasy_points!" do
    stat = FactoryGirl.create(:current_stat)
    before(:each) do
      stat.stub(:points).and_return(20)
      stat.stub(:rebounds).and_return(10)
      stat.stub(:assists).and_return(9)
    end
    
    it "should return the number of fantasy points for that player" do
      stat.set_fantasy_points!.should eq 39
    end
  end
end
