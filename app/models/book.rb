class Book < ApplicationRecord
  attachment :image
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.search(search, word)
    if search == "partial_match"
      @books = Book.where("name LIKE?", "%#{word}%")
    elsif search == "perfect_match"
      @books = Book.where("#{word}")
    else
      @books = Book.all
    end
  end


end
