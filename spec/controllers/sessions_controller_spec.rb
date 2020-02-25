require "rails_helper"

RSpec.describe SessionsController, type: :controller do
  describe "POST #create" do
    let!(:user){FactoryBot.create :user}
    describe "Login success" do
      before{post :create, params: {session: {email: user.email, password: user.password }}}

      context "Return to success response" do
        it{expect(response.status).to eq 302}
      end

      context "Check login success" do
        it{expect(session[:user_id]).to eq user.id}
      end

      context "Redirect to home page" do
        it{expect(response).to redirect_to root_path}
      end

    end

    describe "Login fail" do
      context "Invalid email" do
        before{post :create, params: {session: {email: nil, password: "123123" }}}
        it{expect(response).to render_template :new}
      end

      context "Invalid password" do
        before{post :create, params: {session: {email: user.email, password: nil }}}
        it{expect(response).to render_template :new}
      end
    end
  end
end
