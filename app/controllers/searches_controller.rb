class SearchesController < ApplicationController

  def search
    @user = current_user
    @range = params[:range]
    search = params[:serch]
    word = params[:word]
    if @range == '1'
      @books = Book.search(search, word)
    else
      @users = User.search(search, word)
    end
  end
end
