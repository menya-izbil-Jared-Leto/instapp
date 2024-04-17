require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:account) { create(:account) }
  let(:valid_attributes) { { description: 'Test description', image: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'img.jpg'), 'image/jpg') } }
  let(:invalid_attributes) { { description: nil } }

  before do
    sign_in account
    @valid_session = { "warden.user.user.key" => session["warden.user.user.key"] }
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}, session: @valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Post" do
        expect {
          post :create, params: { post: valid_attributes }, session: @valid_session
        }.to change(Post, :count).by(1)
      end

      it "redirects to the feed" do
        post :create, params: { post: valid_attributes }, session: @valid_session
        expect(response).to redirect_to(feed_path)
      end
    end

    context "with invalid params" do
      it "does not create a new Post" do
        expect {
          post :create, params: { post: invalid_attributes }, session: @valid_session
        }.to change(Post, :count).by(0)
      end

      it "redirects to the 'new' template" do
        post :create, params: { post: invalid_attributes }, session: @valid_session
        expect(response).to redirect_to(new_post_path)
      end
    end
  end
end

