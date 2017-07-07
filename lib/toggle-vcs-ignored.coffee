ToggleVcsIgnoredView = require './toggle-vcs-ignored-view'
{CompositeDisposable} = require 'atom'

module.exports = ToggleVcsIgnored =
  toggleVcsIgnoredView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @toggleVcsIgnoredView = new ToggleVcsIgnoredView(state.toggleVcsIgnoredViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @toggleVcsIgnoredView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'VCS-ignored:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @toggleVcsIgnoredView.destroy()

  serialize: ->
    toggleVcsIgnoredViewState: @toggleVcsIgnoredView.serialize()

  toggle: ->
    excludeVcsIgnoredPaths = atom.config.get "core.excludeVcsIgnoredPaths"
    atom.config.set("core.excludeVcsIgnoredPaths", !excludeVcsIgnoredPaths)
    @toggleVcsIgnoredView.showMessage(excludeVcsIgnoredPaths)
    @modalPanel.show()
    run = () =>
      @modalPanel.hide()
    setTimeout(run, 2000)
