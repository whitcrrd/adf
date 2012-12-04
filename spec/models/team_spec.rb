require 'spec_helper'

describe Team do
  let(:team) {FactoryGirl.build(:team)}
  it { should have_many :athletes_teams }
  it { should have_many(:athletes).through(:athletes_teams) }
  it { should belong_to :user }
  it { should belong_to :game }

  describe "#valid?" do
   
    context "with invalid attributes" do
      it "should be invalid with 4 athletes" do
        4.times do
          team.athletes << FactoryGirl.build(:athlete)
        end
        team.should_not be_valid
      end

      it "should be invalid with 6 athletes" do
        6.times do
          team.athletes << FactoryGirl.build(:athlete)
        end

        team.should_not be_valid
      end

      it "should be invalid with multiple positions of the same" do
        5.times do
          a = FactoryGirl.build(:athlete)
          a.position = "C"
          team.athletes << a
        end
        team.should_not be_valid
      end
    end
    
  end
  
  context "delegate" do
    it { should respond_to(:name)}
  end
end

