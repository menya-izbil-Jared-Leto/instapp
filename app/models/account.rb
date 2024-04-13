class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, :first_name, presence: true

  has_one_attached :image
  
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy

  def self.search(search)
    if search
      where("username LIKE ?", "%#{search}%")
    else
      all
    end
  end

  def followers
    follower_ids = Follower.where(following_id: self.id).pluck(:follower_id)
    Account.where(id: follower_ids)
  end

  def following
    following_ids = Follower.where(follower_id: self.id).pluck(:following_id)
    Account.where(id: following_ids)
  end

  def total_followers
    Follower.where(following_id: self.id).count
  end

  def total_following
    Follower.where(follower_id: self.id).count
  end

  def following?(other_account)
    Follower.exists?(follower_id: self.id, following_id: other_account.id)
  end
  
  before_destroy :remove_followers_and_comments

  private

  def remove_followers_and_comments
    Follower.where(follower_id: self.id).delete_all
    Follower.where(following_id: self.id).delete_all
    Comment.where(account_id: self.id).delete_all
  end

end
