class CartsController < ApplicationController
  def index
    @books = Book.all
    @cart = Cart.where(user_id: params['user_id'])
  end



  def create
    @user = User.find_by(id: params['user_id'])

    c = Cart.find_by(user_id: params['user_id'], book_id: params['book_id'])

    if c
      @cart = @user.carts.new(id: c.id, book_id: params['book_id'])
      @cart.increment!(:quantity, by=1)
    else
      @cart = @user.carts.create(book_id: params['book_id'], quantity: params['quantity'])
    end

  end

  private
  def carts_params
  end
  
end