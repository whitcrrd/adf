require 'spec_helper'

describe TeamsController do
  let(:team) { FactoryGirl.create(:team)}

  let(:current_user) { FactoryGirl.create(:user) }

# context "viewing the team show page when not logged in" do
  # before do
  #   get :show
  # end
  #   it {should redirect_to(root_url)}
  # end
  
  describe "#index" do
    it "will show the root url when user is not logged in" do
      get :index
      controller.should redirect_to(root_url)
    end
    
    it "will show the team index when user is logged in"
  end
  
  describe "#create" do
    it "creates a valid team with a valid user" do
      controller.stub(:current_user).and_return(current_user)
      post :create, {
        "team"=>{"name"=>"Scott Chiang's Team"}
      }
      
      team = assigns(:team) ## takes team from line 28
      team.name.should eq "Scott Chiang's Team"
    end
  end
  
  describe "#show" do
    it "shows the correct team for the logged in user" do
      controller.stub(:current_user).and_return(current_user)
      team = FactoryGirl.create(:team)
      team.user = current_user
      get :show, id: team
      assigns(:team).should eq(team)
    end
  end
  
  describe "#update" do
    before :each do
      team = FactoryGirl.create(:team)
    end
    it "locates the correct team" do
      controller.stub(:current_user).and_return(current_user)
      team.user = current_user
      get :show, id: team
      assigns(:team).should eq(team)
    end
    
    it "redirects for a successful update" 

    
  end
end











