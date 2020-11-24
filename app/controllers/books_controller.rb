class BooksController < ApplicationController
  
  def index
    if logged_in?
      @books = Book.all
    else
      redirect_to '/sign_in'
    end
  end

  def show
    @book = Book.find(params['id'])
  end


end