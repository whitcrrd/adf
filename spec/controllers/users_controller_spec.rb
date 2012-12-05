require 'spec_helper'

describe UsersController do
  let(:current_user) { FactoryGirl.create(:user) }
  
	describe "#show" do
    it "shows the correct user when user is logged in" do
      controller.stub(:current_user).and_return(current_user)
      user = current_user
      get :show, id: user
      assigns(:user).should eq(user)
    end
	end
end
