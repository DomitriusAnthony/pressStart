class Post < ApplicationRecord
	belongs_to :user
	has_many :comments
	validates :body, presence: true

	def self.feed(user)
		where("user_id IN (?) OR user_id = ?", user.followed_ids, user).order("id DESC")
  	end
end
