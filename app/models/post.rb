class Post < ActiveRecord::Base
  attr_accessible :content, :title, :show_title
  validates :title, :content, presence: true
  def markup_content
    RDiscount.new(GFM::gfm(content), :strict, :autolink).to_html.html_safe
  end
end
