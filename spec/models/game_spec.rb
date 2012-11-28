require 'spec_helper'

describe Game do
  it "should respond to team" do
    g = Game.new
    g.should respond_to(:teams)
  end
end