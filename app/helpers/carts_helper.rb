module CartsHelper

  def subtotal
    subtotal = 0
    @user_cart.each do |i|
      subtotal += @books.find_by(id: i.book_id).price * i.quantity
    end
    return subtotal.round(2)
  end

  def total
    return 9
  end

  
end