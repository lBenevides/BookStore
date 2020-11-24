class SessionsController < ApplicationController
  before_action :block_access, except: [:destroy]

  def new
  end

  def create
    @user = User.find_by(username: params[:session][:username].downcase)
      if @user && @user.authenticate(params[:session][:password])
        sign_in
        redirect_to books_path
      else
        render action: :new
      end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
  
end