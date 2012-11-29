class UsersController < ApplicationController
  load_resource
  def show
    @posts = @user.posts.paginate(:page => params[:page], :per_page => 5)
  end
end
