# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

SITE.home = 
  index: () ->
    $('#post_content').val('')
    this.highlight()
    this.preview()
    # this.ace()
    this.demo()
  about: () ->
    hljs.initHighlightingOnLoad()
  updatePreview: () ->
    source = $('#post_content')
    preview = $('#preview')
    converter = new Markdown.Converter()
    preview.html(converter.makeHtml(source.val()))
    MathJax.Hub.Queue(["Typeset",MathJax.Hub]);
    preview.find('pre code').each (i, e) ->
      hljs.highlightBlock(e)
  highlight: () ->
    hljs.initHighlightingOnLoad()
  preview: () ->
    $('#post_content').bind('keyup', this.updatePreview);
  demo: () ->
    content = """
## TJMarkdownPaste

It's really common to see an online markdown editor, but most of them don't have features for publishing or sharing. However, it's still common to just add only a publish feature.

**It's cool to have automatic code hightlight, isn't it?**

    #include<stdio.h>
    int main(int argc, char* argv[]){
      printf("Hello, TJMarkdownPaste");
      return 0;
    }

Ruby code:

    def ruby_code
      cool_boy = name: "tonytonyjan", age: 18
    end

**And what about some mathematic syntax?**

$J\_\\alpha(x) = \\sum\\limits\_{m=0}^\\infty \\frac{(-1)^m}{m! \\, \\Gamma(m + \\alpha + 1)}{\\left({\\frac{x}{2}}\\right)}^{2 m + \\alpha}$
    """
    $('#post_content').autotype(content, {delay: 5})
  ace: () ->
    editor = ace.edit("editor")
    editor.setTheme("ace/theme/clouds_midnight")
    editor.renderer.setShowGutter(false)
    editor.getSession().setMode("ace/mode/markdown")
    source = $('#post_content')
    editor.on("change", () ->
      source.val(editor.getValue()).trigger("keyup")
    )
    # source.bind('keydown', () ->
    #   editor.setValue(source.val())
    # )