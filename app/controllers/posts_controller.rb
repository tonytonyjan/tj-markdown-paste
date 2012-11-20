class PostsController < ApplicationController
  default_resource_actions
  def show
    render layout: "clean"
  end
end