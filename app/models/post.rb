# encoding: utf-8
class Post < ActiveRecord::Base
  attr_accessible :content, :title, :show_title
  validates :title, :content, presence: true

  def self.demo_content
    %q(
[reference link]: http://tonytonyjan.github.com "不歸錄" 

## List

*   [link 1](http://tonytonyjan.github.com "不歸錄")
*   [link 2][reference link]
*   ![rikka](/assets/rikka.gif "Rikka")

---

1.  *italic*
2.  **bold**

## Blockquotes

> Enjoy your pain, sorrow and hatred,
> as you can enjoy your happiness,
> since they are all part of your life.

## Code

  #!/usr/bin/ruby
    class Fixnum
      def prime?
        ('1' * self) !~ /^1?$|^(11+?)\1+$/
      end
    end

## Tex

$E=mc^2$

`$E=mc^2$`
).strip
  end

  def markup_content
    RDiscount.new(GFM::gfm(content), :strict, :autolink).to_html.html_safe
  end
end
