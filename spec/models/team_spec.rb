require 'spec_helper'

describe Team do
  before (:each) do
    @t = Team.new
  end

	it "should respond to user" do 
		@t.should respond_to(:user)
	end

	it "should respond to athletes" do
		@t.should respond_to(:athletes)
	end

  it "should have only 5 athletes" do
    4.times do
      @t.athletes << FactoryGirl.create(:athlete)
    end

    @t.should_not be_valid
    @t.should have(1).errors_on(:team)

  end

  it "should have only 5 athletes" do
    6.times do
      @t.athletes << FactoryGirl.create(:athlete)
    end

    @t.should_not be_valid
    @t.should have(1).errors_on(:team)
  end

end