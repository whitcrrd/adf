require 'spec_helper'

describe GamesController do
  context "routing" do
    context "editing a team when not logged in" do
      before do
        get :edit
      end
      it {should redirect_to(root_url)}
    end
    
    context "updating a team when not logged in" do
      before do
        get :update
      end
      it {should redirect_to(root_url)}
    end
  end
  
end