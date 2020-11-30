class ApplicationController < ActionController::Base
  before_action :block_access
  protect_from_forgery with: :exception
  include SessionsHelper
  include CartsHelper

end
