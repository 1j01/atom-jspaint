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
    ###@image.hide().attr('src', editor.getUri())

    @image.load =>
      @originalHeight = @image.height()
      @originalWidth = @image.width()
      @loaded = true
      @image.show()

    @command 'paint:zoom-in', => @zoomIn()
    @command 'paint:zoom-out', => @zoomOut()
    @command 'paint:reset-zoom', => @resetZoom()

    @whiteTransparentBackgroundButton.setTooltip("Use white transparent background")
    @blackTransparentBackgroundButton.setTooltip("Use black transparent background")###

  afterAttach: (onDom) ->
    return #unless onDom

    if pane = @getPane()
      @imageControls.find('a').on 'click', (e) =>
        @changeBackground $(e.target).attr 'value'

      # Hide controls for jpg and jpeg images as they don't have transparency
      if path.extname(@image.attr 'src').toLowerCase() in ['.jpg', '.jpeg']
        @imageControls.hide()

  # Retrieves this view's pane.
  #
  # Returns a {Pane}.
  getPane: ->
    @parents('.pane').view()

  # Zooms the image out by 10%.
  zoomOut: ->
    @adjustSize(0.73)

  # Zooms the image in by 10%.
  zoomIn: ->
    @adjustSize(1/0.73)

  # Zooms the image to its normal width and height.
  resetZoom: ->
    return #unless @loaded and @isVisible()

    @image.width(@originalWidth)
    @image.height(@originalHeight)

  # Adjust the size of the image by the given multiplying factor.
  #
  # factor - A {Number} to multiply against the current size.
  adjustSize: (factor) ->
    return #unless @loaded and @isVisible()

    newWidth = @image.width() * factor
    newHeight = @image.height() * factor
    @image.width(newWidth)
    @image.height(newHeight)

  # Changes the background color of the image view.
  #
  # color - A {String} that is a valid CSS hex color.
  changeBackground: (color) ->
    return #unless @loaded and @isVisible() and color
    # TODO: in the future, probably validate the color
    @image.css 'background-color', color
