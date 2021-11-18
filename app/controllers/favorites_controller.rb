class FavoritesController < ApplicationController
  def index
    @user = current_user
    favorites = Favorite.where(user_id: current_user.id).pluck(:book_id)
    @favorite_list = Book.find(favorites)
  end

  def create
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: @book.id)
    favorite.save
  end

  def destroy
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: @book.id)
    favorite.destroy
  end
end
