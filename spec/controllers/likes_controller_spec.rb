require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  let(:account) { create(:account) }
  let(:inst_post) { create(:post, account: account) }
  let(:valid_attributes) { { post_id: inst_post.id } }

  before do
    sign_in account
    @valid_session = { "warden.user.user.key" => session["warden.user.user.key"] }
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Like" do
        expect {
          post :create, params: { like: valid_attributes }
        }.to change(Like, :count).by(1)
      end

      it "redirects to the feed" do
        post :create, params: { like: valid_attributes }
        expect(response).to redirect_to(feed_path)
      end
    end
  end

  describe "DELETE #destroy" do
  let(:like) { create(:like, account: account, post: inst_post) }

  context "when the like belongs to the current account" do
    it "destroys the requested like" do
      like
      expect {
        delete :destroy, params: { id: like.to_param }
      }.to change(Like, :count).by(-1)
    end

    it "redirects to the feed" do
      delete :destroy, params: { id: like.to_param }
      expect(response).to redirect_to(feed_path)
    end
  end
end

end
