class Post < ApplicationRecord
    default_scope { order created_at: :desc }
    belongs_to :account

    has_many :likes

    has_one_attached :image

    def total_likes
        0
    end

end
