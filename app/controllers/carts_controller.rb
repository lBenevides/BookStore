class CartsController < ApplicationController
  def index
    @books = Book.all
    @user_cart = Cart.where(user_id: params['user_id'])
  end

  def create #or update if request comes from book#index
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
    @cart_item = Cart.find_by(user_id: params['user_id'], book_id: params['id'])
    if params[:commit] == '+'
      @cart_item.increment!(:quantity, by=1)
    else
      @cart_item.decrement!(:quantity, by=1)
    end
    @user_cart = Cart.where(user_id: params['user_id'])
    @books = Book.all

    @cart_item_total = (@cart_item.quantity * @books.find_by(id: @cart_item.book_id).price)

    if @cart_item.quantity == 0
      destroy
      render 'carts/destroy.js.erb'
    end
  end

  def destroy
    @cart_item = Cart.find_by(user_id: params['user_id'], book_id: params['id'])
    @cart_item.destroy
    @user_cart = Cart.where(user_id: params['user_id'])
    @books = Book.all
   
  end

  def buy
    @books = Book.all
    @user_cart = Cart.where(user_id: params['user_id'])
  end

  def pay
    @books = Book.all
    @user_cart = Cart.where(user_id: current_user)
    if @current_user.cash >= subtotal 
      current_user.decrement!(:cash, by=subtotal)
      order_number = Order.maximum(:order_number) 
      if order_number.nil? 
        order_number = 1
      else
        order_number += 1
      end
      @user_cart.map do |c|
        Order.create(
          book_id: c.book_id,
          quantity: c.quantity,
          user_id: c.user_id,
          order_number: order_number,
          price: @books.find(c.book_id).price
        )
      end

      @user_cart.destroy_all
      redirect_to books_path
    else
      puts 'Couldnt buy'
    end
      
  end

  def shipping

  
  end

  private
  def carts_params
  end
  
  
end