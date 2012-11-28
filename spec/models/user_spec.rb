require 'spec_helper'

describe User do
  it "should respond to teams" do
    user = User.new
    user.should respond_to(:teams)
  end
end