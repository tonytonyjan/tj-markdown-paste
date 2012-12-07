class PostsController < ApplicationController
  load_and_authorize_resource
  layout "editor", only: [:new, :create, :edit, :update]

  def index
    @posts = Post.paginate(page: params[:page], order: 'id DESC')

    respond_to do |format|
      format.html
      format.json { render json: @posts }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @post }
    end
  end

  def new
    respond_to do |format|
      format.html
      format.json { render json: @post }
    end
  end

  def create
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: t('tj.succeeded') }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: t('tj.succeeded') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to current_user || posts_url, notice: t('tj.succeeded') }
      format.json { head :no_content }
    end
  end
end
