require 'spec_helper'

describe SessionsController do
  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new current session using facebook login"
      it "redirects to the root url" 
      
    end
  end
  
  describe "DELETE #destroy" do
    it "resets the current session user's id to nil"
    it "redirects to the root url"
  end
  
end