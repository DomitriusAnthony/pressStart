class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :posts, :dependent => :destroy

  has_many :comments, :dependent => :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png", :dependent => :destroy
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  has_many :relationships, foreign_key: :follower_id, :dependent => :destroy
  has_many :followed, through: :relationships, source: :followed, :dependent => :destroy

  has_many :reverse_relationships, foreign_key: :followed_id, class_name: 'Relationship', :dependent => :destroy
    
  has_many :followers, through: :reverse_relationships, source: :follower, :dependent => :destroy

  has_many :messages, :dependent => :destroy
  has_many :conversations, foreign_key: :sender_id, :dependent => :destroy


    # Class method to follow a user
  def follow!(user)
    followed << user
  end
end
