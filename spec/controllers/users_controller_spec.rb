require "rails_helper"

RSpec.describe UsersController, type: :controller do
  describe "GET #new" do
    before{get :new}

    it "Return to success response" do
      expect(response.status).to eq 200
    end

    it "Render sign up template" do
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "when valid attributes" do
      before{post :create, params: {user: FactoryBot.attributes_for(:user)}}

      it "created a new user" do
        expect(assigns(:user)).to be_a User
      end

      it "redirects to the new user" do
        expect(response).to redirect_to root_path
      end
    end

    context "when invalid attributes" do
      before{post :create, params: {user: FactoryBot.attributes_for(:user, email: "")}}

      it "Render sign up template" do
        expect(response).to render_template :new
      end
    end
  end
end
