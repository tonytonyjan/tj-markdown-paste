# encoding: utf-8
class Post < ActiveRecord::Base
  attr_accessible :content, :title, :show_title, :is_published
  validates :title, :content, presence: true
  belongs_to :user

  def markup_content
    RDiscount.new(GFM::gfm(content), :strict, :autolink).to_html.html_safe
  end
end
