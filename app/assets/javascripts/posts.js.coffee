# Place all the behaviors and hooks related to the matching controller here.
# All logic will automatically be available in application.js.
# You can use CoffeeScript in file: http://jashkenas.github.com/coffee-script/

SITE.posts =
  show: () ->
    this.highlight()
  new: () ->
    this.highlight()
    this.preview()
    # demo()
  edit: () ->
    this.preview()
    this.updatePreview()
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