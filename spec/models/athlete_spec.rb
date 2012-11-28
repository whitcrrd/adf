require 'spec_helper'

describe Athlete do
  it "responds to teams" do
    a = Athlete.new
    a.should respond_to(:teams)
  end
end