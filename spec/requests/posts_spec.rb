require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let(:account) { create(:account) }
  before { sign_in account }

  describe "GET /posts" do
    let!(:posts) { create_list(:post, 3, account: account) }

    subject { get posts_path }

    it "return success" do
      subject
      expect(response).to have_http_status(200)
    end

    it 'renders the correct content of the posts' do
      subject

      posts.each do |post|
        expect(post.image.attached?).to be true
        expect(response).to include(post.description)
      end
    end
  end

end
