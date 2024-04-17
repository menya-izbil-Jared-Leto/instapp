require 'rails_helper'

RSpec.describe AccountsController, type: :controller do
  let(:account) { create(:account) }

  before do
    sign_in account
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "renders the :index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "assigns @posts" do
      post = create(:post, account: account)
      get :index
      expect(assigns(:posts)).to eq([post])
    end
  end

  describe "GET #profile" do
    it "returns http success" do
      get :profile, params: { username: account.username }
      expect(response).to have_http_status(:success)
    end

    it "renders the :profile template" do
      get :profile, params: { username: account.username }
      expect(response).to render_template(:profile)
    end

    it "assigns @account" do
      get :profile, params: { username: account.username }
      expect(assigns(:account)).to eq(account)
    end

    it "assigns @posts" do
      post = create(:post, account: account)
      get :profile, params: { username: account.username }
      expect(assigns(:posts)).to eq([post])
    end
  end
  
end
