class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :image
  
  has_many :posts
  has_many :likes

  def total_followers
    
    Follower.where(following_id: self.id).count
  end

  def total_following
    Follower.where(follower_id: self.id).count
  end

  def following?(other_account)
    Follower.exists?(follower_id: self.id, following_id: other_account.id)
  end

end
