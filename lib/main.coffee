path = require 'path'
_ = require 'underscore-plus'
ImageEditor = require './image-editor'

openUri = (uriToOpen)->
	console.log "opener for paint called for #{uriToOpen}"
	ext = path.extname(uriToOpen).toLowerCase()
	if ext.match /.(png|gif|jpe?g|bmp|ico)$/
		new ImageEditor(uriToOpen)

createStatusView = ->
	{statusBar} = atom.workspaceView
	if statusBar?
		ImageEditorStatusView = require './image-editor-status-view'
		view = new ImageEditorStatusView(statusBar)
		view.attach()

module.exports =
	activate: ->
		atom.workspace.registerOpener(openUri)
		
		# atom.packages.once 'activated', createStatusView
		# status view should be re-enabled later
		
		atom.workspaceView.command 'paint:new', =>
			# @TODO: open paint properly and specifically
			# This relies on paint being first in line to open images
			# and currently only allows one new paint instance
			atom.workspace.open 'Untitled.png'
	
	deactivate: ->
		atom.workspace.unregisterOpener(openUri)
