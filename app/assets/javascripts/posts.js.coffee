# Place all the behaviors and hooks related to the matching controller here.
# All logic will automatically be available in application.js.
# You can use CoffeeScript in file: http://jashkenas.github.com/coffee-script/

SITE.posts =
  show: () ->
    this.highlight()
  new: () ->
    this.highlight()
    this.preview()
    this.ace()
    this.show_title()
    # demo()
  edit: () ->
    this.preview()
    this.updatePreview()
    this.ace()
    this.show_title()
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
  ace: () ->
    editor = ace.edit("editor")
    editor.setTheme("ace/theme/clouds_midnight")
    editor.renderer.setShowGutter(false)
    editor.getSession().setMode("ace/mode/markdown")
    editor.on("change", () ->
      $('#post_content').val(editor.getValue()).trigger("keyup")
    )
  show_title: () ->
    title = $('#post_title')
    title_preview = $('#post_title_preview')    
    show_title = $('#post_show_title')
    update_title = () ->
      if show_title.attr("checked")
        title_preview.text(title.val())
        title_preview.css(display: "inherit")
      else
        title_preview.css(display: "none")
    update_title()
    show_title.change update_title
    title.bind("keyup", update_title)