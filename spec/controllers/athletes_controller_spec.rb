require 'spec_helper'

describe AthletesController do
  context "destroying athletes" do
    before do
      get :destroy
    end
    it { should redirect_to(root_url) }
  end
end