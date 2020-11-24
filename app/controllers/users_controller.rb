class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to books_path
    else
      puts 'não deu'
      render action: :new
    end
  end


  private
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end