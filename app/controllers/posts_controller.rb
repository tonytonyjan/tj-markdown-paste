class PostsController < ApplicationController
  load_and_authorize_resource

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

  def update
    if @post.update_attributes params[:post]
      flash[:notice] = t("tj.succeeded")
      redirect_to @post
    else
      render "edit"
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = t("tj.succeeded")
    redirect_to current_user || posts_path
  end
end