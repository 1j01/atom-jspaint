path = require 'path'
_ = require 'underscore-plus'
ImageEditor = require './image-editor'

module.exports =
  activate: ->
    atom.workspace.registerOpener(openUri)
    #atom.packages.once('activated', createImageStatusView)
    atom.workspaceView.command 'paint:new', =>
      return atom.workspace.open 'UNTITLED.png'
      ###console.log item = new ImageEditor
      pane = new Pane(items: [item])
      
      _this = atom.workspace # I think?
      _this.paneContainer.root = pane
      _this.itemOpened(item)
      
      pane.activateItem(item)
      
      if changeFocus
        pane.activate()
      
      #(_this = atom.workspace?).emit "uri-opened" # um?###

  deactivate: ->
    atom.workspace.unregisterOpener(openUri)

createImageStatusView = ->
  {statusBar} = atom.workspaceView
  if statusBar?
    ImageEditorStatusView = require './image-editor-status-view'
    view = new ImageEditorStatusView(statusBar)
    view.attach()

# Files with these extensions will be opened as images
imageExtensions = ['.gif', '.ico', '.jpeg', '.jpg', '.png']
openUri = (uriToOpen) ->
  uriExtension = path.extname(uriToOpen).toLowerCase()
  # if uriExtension.match /.(png|gif|jpe?g|ico)$/
  if _.include(imageExtensions, uriExtension)
    new ImageEditor(uriToOpen)
