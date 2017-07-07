module.exports =
class ToggleVcsIgnoredView
  constructor: (serializedState) ->
    # Create root element
    @element = document.createElement('div')
    @element.classList.add('toggle-vcs-ignored')

    # Create message element
    message = document.createElement('div')
    message.classList.add('message')
    @element.appendChild(message)

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element

  showMessage: (excludeVCS) ->
    if excludeVCS
      displayText = "VCS Ignored Paths Included"
    else
      displayText = "VCS Ignored Paths Excluded"
    @element.children[0].textContent = displayText
