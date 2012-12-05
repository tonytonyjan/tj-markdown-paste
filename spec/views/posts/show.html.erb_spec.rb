require 'spec_helper'

describe "posts/show" do
  before(:each) do
    @post = assign(:post, stub_model(Post,
      :title => "Title",
      :content => "MyText",
      :show_title => true
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/) if @post.show_title
    rendered.should match(/MyText/)
  end
end
