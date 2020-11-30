class CartsController < ApplicationController
  def index
    @books = Book.all
    @user_cart = Cart.where(user_id: params['user_id'])
    
  end

  def create #or update
    @user = User.find_by(id: params['user_id'])

    c = Cart.find_by(user_id: params['user_id'], book_id: params['book_id'])

    if c
      @cart = @user.carts.new(id: c.id, book_id: params['book_id'])
      @cart.increment!(:quantity, by=1)
    else
      @cart = @user.carts.create(book_id: params['book_id'], quantity: params['quantity'])
    end
    @cart_value = Cart.where(user_id: @user.id).sum(:quantity)
  end

  def update
    @user_cart = Cart.where(user_id: params['user_id'])
    @books = Book.all

    
    @cart_item = Cart.find_by(user_id: params['user_id'], book_id: params['id'])
    if params[:commit] == '+'
      @cart_item.increment!(:quantity, by=1)
    else
      @cart_item.decrement!(:quantity, by=1)
      if @cart_item.quantity == 0
        destroy
      end
    end

    @cart_item_total = (@cart_item.quantity * @books.find_by(id: @cart_item.book_id).price)

  end

  def destroy
    @cart_item.destroy
  end

  private
  def carts_params
  end
  
end