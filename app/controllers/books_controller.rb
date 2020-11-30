class BooksController < ApplicationController
  
  def index
    if logged_in?
      @books = Book.all
      @cart_value = Cart.where(user_id: @current_user.id).sum(:quantity)
      
    else
      redirect_to '/sign_in'
    end
  end

  def show
    @book = Book.find(params['id'])
  end


end