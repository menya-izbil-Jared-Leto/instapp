require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let(:account) { create(:account) }
  before { sign_in account }

  describe "GET /posts" do
    let!(:posts) { create_list(:post, 3, account: account) }

    subject { get feed_path }

    it "return success" do
      subject
      expect(response).to have_http_status(200)
    end

    it 'renders the correct content of the posts' do
      subject

      posts.each do |post|
        expect(post.image.attached?).to be true
        expect(response.body).to include(post.description)
      end
    end
  end

  describe "POST /posts" do
    let(:image) { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'img.jpg'), 'image/jpg') }
    let(:post_params) { { post: { description: 'New post', image: image } } }
  
    subject { post posts_path, params: post_params }
  
    it 'creates a new post' do
      expect { subject }.to change { Post.count }.by(1)
      expect(response).to redirect_to(feed_path)
    end
  end

end
