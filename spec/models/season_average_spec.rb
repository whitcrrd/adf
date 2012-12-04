require 'spec_helper'

describe SeasonAverage do
  context "associations" do
    it { should belong_to(:athlete) }
  end
end
