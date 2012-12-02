class PostsController < ApplicationController
  load_and_authorize_resource
  default_resource_actions

  def index
    @posts = Post.order("id DESC").paginate page: params[:page]
  end

  def show
    @title = @post.title
    @meta = {description: @post.content}
    render layout: "post"
  end

  def new
    render layout: "editor"
  end

  def create
    @post = user_signed_in? ? current_user.posts.build(params[:post]) : Post.new(params[:post])
    save_record! @post
  end

  def edit
    render layout: "editor"
  end

  def destroy
    @post.destroy
    flash[:notice] = t("tj.destroy_successful")
    redirect_to current_user || posts_path
  end
end