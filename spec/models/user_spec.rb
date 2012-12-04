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
end