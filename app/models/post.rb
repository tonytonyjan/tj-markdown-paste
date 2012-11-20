class Post < ActiveRecord::Base
  attr_accessible :content, :title, :show_title
  validates :title, presence: true
  def markup_content
    RDiscount.new(content, :strict).to_html.html_safe
  end
end
