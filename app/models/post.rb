class Post < ApplicationRecord
    default_scope { order created_at: :desc }
    belongs_to :account

    has_many :likes
    has_many :comments

    has_one_attached :image

    validates :image, presence: true

end
