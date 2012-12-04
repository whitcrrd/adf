require 'spec_helper'

describe Game do
  context "associations" do
    let(:game) {FactoryGirl.build(:game)}
    it { should have_many(:teams) }
    it { should belong_to(:winner) }
    it { should belong_to(:loser) }
  end
  
  # context "#full?" do
  #   let(:game) {FactoryGirl.build(:game)}    
  # end
end