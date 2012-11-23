class PostsController < ApplicationController
  load_and_authorize_resource
  default_resource_actions
  def show
    @title = @post.title
    @meta = {description: @post.content}
    render layout: "clean"
  end

  def new
    render layout: "editor"
  end
end