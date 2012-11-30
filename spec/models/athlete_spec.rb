require 'spec_helper'

describe Athlete do
  it { should have_many :athletes_teams }
  it { should have_many(:teams).through(:athletes_teams) }
  it { should have_one(:season_average)}

end