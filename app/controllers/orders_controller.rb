class OrdersController < ApplicationController
  before_action :commom_methods

  

  def index
    
    
  end
  

  def commom_methods
    @user_orders = Order.where(user_id: current_user)
    @books = Book.all
  end
  

end