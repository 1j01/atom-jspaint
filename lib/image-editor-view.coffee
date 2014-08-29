_ = require 'underscore-plus'
path = require 'path'
{$, ScrollView} = require 'atom'

# View that renders the image of an {ImageEditor}.
module.exports =
class ImageEditorView extends ScrollView
  @content: ->
    @div class: 'paint', tabindex: -1, =>
      @iframe src: 'http://1j01.github.io/jspaint/', outlet: 'iframe'
      #@img outlet: 'image'

  initialize: (editor) ->
    super

    @loaded = false
    
    uri = editor.getUri()
    
    @image.load =>
      @loaded = true

  afterAttach: (onDom) ->
    return unless onDom

  # Retrieves this view's pane.
  #
  # Returns a {Pane}.
  getPane: ->
    @parents('.pane').view()
