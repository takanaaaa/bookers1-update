class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attachment :profile_image

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following_user, through: "follower", source: "followed"
  has_many :follower_user, through: "followed", source: "follower"

  validates :name, presence: true, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :profile_text, length: {maximum: 50}

  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    following_user.include?(user)
  end

  def self.search(search, word)
    if search == "partial_match"
      @users = User.where("name LIKE?", "%#{word}%")
    elsif search == "perfect_match"
      @users = User.where("#{word}")
    else
      @users = User.all
    end
  end


end
