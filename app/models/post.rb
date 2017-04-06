class Post < ApplicationRecord
	scope :by_date, -> { order(created_at: :desc) }
	belongs_to :user
	has_many :comments
	validates :body, presence: true

	acts_as_votable

	def self.feed(user)
    	where("user_id IN (?) OR user_id = ?", user.followed_ids, user).order("id DESC") 
  	end

  	include Presentation
end
