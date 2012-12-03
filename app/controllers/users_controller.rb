class UsersController < ApplicationController
  load_resource
  def show
    @posts = @user.posts.order("id DESC").paginate(:page => params[:page], :per_page => 5)
  end
end
