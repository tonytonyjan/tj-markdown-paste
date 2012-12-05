require 'spec_helper'

describe UsersController do

  def valid_attributes
    {
      email: "abc@gg.com",
      password: "ru03ru03ru03",
      password_confirmation: "ru03ru03ru03",
      name: "Name"
    }
  end

  def valid_session
    {}
  end

  describe "GET show" do
    it "assigns the requested user as @user" do
      user = User.create! valid_attributes
      get :show, {:id => user.to_param}, valid_session
      assigns(:user).should eq(user)
      # response.should be_success
    end
  end

end
