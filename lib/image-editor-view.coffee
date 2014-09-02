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
		
		@iframe.load =>
			paint = @iframe[0].contentWindow
			
			# Add some commands
			@command 'paint:undo', => paint.undo()
			@command 'paint:redo', => paint.redo()
			@command 'paint:invert', => paint.invert()
			@command 'paint:clear-image', => paint.clear()
			
			# Load the image into paint
			image = new Image
			
			$(image).load =>
				paint.open_from_Image(image, uri)
				@loaded = true
			
			image.src = uri

	afterAttach: (onDom) ->
		return unless onDom

	# Retrieves this view's pane.
	#
	# Returns a {Pane}.
	getPane: ->
		@parents('.pane').view()
