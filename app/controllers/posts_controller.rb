class PostsController < ApplicationController
  load_and_authorize_resource
  default_resource_actions
  def show
    @title = @post.title
    @meta = {description: @post.content}
    render layout: "post"
  end

  def new
    @post.content = t("demo_content")
    render layout: "editor"
  end
end