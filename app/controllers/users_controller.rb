class UsersController < ApplicationController
  load_resource
  def show
    @posts = @user.posts.paginate(:page => params[:page])
    render "posts/index"
  end
end
