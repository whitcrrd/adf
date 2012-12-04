require 'spec_helper'

describe TeamsController do
  let(:team) { FactoryGirl.create(:team)}
  let(:user) { FactoryGirl.create(:user)}
  
  context "routing" do
    context "viewing the team show page when not logged in" do
      before do
        get :show
      end
      it {should redirect_to(root_url)}
    end
  end
end
