require 'spec_helper'

describe ProfessionalTeam do
  context "associations" do
    it { should have_many(:athletes) }
  end
end
