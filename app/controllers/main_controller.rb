class MainController < ApplicationController
  def home
    @post = Post.new
    @posts = Post.all_for_user(current_user).nuevos.paginate(page: params[:page], per_page: 5)
  end

  def unregistered; end

  protected

  def set_layout # se sobreescribe el método del padre
    return "landing" if action_name == "unregistered"
    super
  end
end
