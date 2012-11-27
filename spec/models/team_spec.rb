require 'spec_helper'

describe Team do
	it "should respond to user" do 
		t = Team.new
		t.should respond_to(:user)
	end

	it "should respond to athletes" do 
		t = Team.new
		t.should respond_to(:athletes)
	end
end