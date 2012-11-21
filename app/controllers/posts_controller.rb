class PostsController < ApplicationController
  load_and_authorize_resource
  default_resource_actions
  def show
    @meta = {description: @post.content}
    render layout: "clean"
  end
end