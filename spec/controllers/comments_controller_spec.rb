require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:account) { create(:account) }
  let(:post) { create(:post, account: account) }
  let(:valid_attributes) { { comment: 'Test comment', post_id: post.id, return_to: feed_path } }

  before do
    sign_in account
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Comment" do
        expect {
          process :create, method: :post, params: { comment: valid_attributes }
        }.to change(Comment, :count).by(1)
      end

      it "redirects to the feed" do
        process :create, method: :post, params: { comment: valid_attributes }
        expect(response).to redirect_to(post_path(post.id))
      end
    end
  end

  describe "DELETE #destroy" do
  let(:comment) { create(:comment, account: account, post: post) }

  context "when the comment belongs to the current account" do
    it "destroys the requested comment" do
      comment
      expect {
        process :destroy, method: :delete, params: { id: comment.to_param }
      }.to change(Comment, :count).by(-1)
    end

    it "redirects to the post path" do
      process :destroy, method: :delete, params: { id: comment.to_param }
      expect(response).to redirect_to(post_path(comment.post_id))
    end
  end

  context "when the comment does not belong to the current account" do
    let(:other_account) { create(:account) }
    let(:other_comment) { create(:comment, account: other_account, post: post) }

    it "does not destroy the comment" do
      other_comment
      expect {
        process :destroy, method: :delete, params: { id: other_comment.to_param }
      }.not_to change(Comment, :count)
    end

    it "redirects to the post path" do
      process :destroy, method: :delete, params: { id: other_comment.to_param }
      expect(response).to redirect_to(post_path(other_comment.post_id))
    end
  end
end

end
