class PostsController < ApplicationController
  load_and_authorize_resource
  default_resource_actions
  def show
    render layout: "clean"
  end
end