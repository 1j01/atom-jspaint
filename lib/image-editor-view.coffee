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
		
		console.log "loading iframe", @iframe[0]
		@iframe.load =>
			# The Worst Way To Load An Image
			# We take a Universal Resource Indicator,
			# Load the URI as an image,
			# Make a canvas, and draw the image to the canvas,
			# Then we get the URI from the canvas so we can
			# Send it to the page(!), which
			# Loads the URI as an image, and finally
			# Puts it on a canvas
			# SOUNDS LEGIT LET'S SHIP IT
			img = document.createElement 'img'
			#@iframe[0].contentWindow.open_from_Image(img, uri)
			console.log "loading image", img
			$(img).load =>
				console.log "loaded image", img
				canvas = document.createElement 'canvas'
				ctx = canvas.getContext '2d'
				canvas.width = img.width
				canvas.height = img.height
				ctx.drawImage img, 0, 0
				data_uri = canvas.toDataURL()
				console.log "opening image"
				@iframe[0].contentWindow.open_from_URI data_uri, uri
				
				@loaded = true
			img.src = uri

	afterAttach: (onDom) ->
		return unless onDom

	# Retrieves this view's pane.
	#
	# Returns a {Pane}.
	getPane: ->
		@parents('.pane').view()
