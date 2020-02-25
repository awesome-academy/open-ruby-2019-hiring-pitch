require "rails_helper"

RSpec.describe CommentsController, type: :controller do
  let(:comment){ FactoryBot.create(:comment) }
  describe "POST #create" do
    before{post :create, params: {comment: FactoryBot.attributes_for(:comment)}}

    context "with valid attributes" do
      it "creates a new comment" do
        expect{comment}.to change{Comment.count}.by(1)
      end
    end

    it "redirects to the new comment" do
      is_expected.to respond_with(302)
    end
  end

    context "with invalid attributes" do
      it "does not save the new contact" do
        expect{ post :create, params: {comment: FactoryBot.attributes_for(:comment) }}
          .to_not change(Comment,:count)
      end

    it "re-renders the new method" do
      post :create, params: {comment: FactoryBot.attributes_for(:comment)}
      expect{ should set_flash[:danger] }
    end
  end

  describe "DELETE destroy" do
    before :each do
      @comment =  FactoryBot.create :comment
    end

    it "deletes the comment" do
      expect{delete :destroy, params:{id: @comment}}.to change(Comment, :count).by(-1)
    end

    it "redirects to comments#index" do
      delete :destroy, params:{id: @comment}
      expect(response).to redirect_to request.referrer || root_url
    end
  end
end
