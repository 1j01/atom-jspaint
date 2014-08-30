path = require 'path'
_ = require 'underscore-plus'
ImageEditor = require './image-editor'

module.exports =
	activate: ->
		atom.workspace.registerOpener (uriToOpen)->
			ext = path.extname(uriToOpen).toLowerCase()
			if ext.match /.(png|gif|jpe?g|ico)$/
				new ImageEditor(uriToOpen)
		
		# atom.packages.once 'activated', createStatusView
		# status view should be re-enabled later
		
		atom.workspaceView.command 'paint:new', =>
			# @TODO: open paint properly and specifically
			atom.workspace.open 'Untitled.png'
	
	deactivate: ->
		atom.workspace.unregisterOpener(openUri)

createStatusView = ->
	{statusBar} = atom.workspaceView
	if statusBar?
		ImageEditorStatusView = require './image-editor-status-view'
		view = new ImageEditorStatusView(statusBar)
		view.attach()
