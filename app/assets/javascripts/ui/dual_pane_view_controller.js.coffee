# Namespace
@app.namespace "ui"

##
# DualPaneViewController
# ----------------------
# Manages the communication between UI elements
# for the application's primary view.
class app.ui.DualPaneViewController

  ##
  # Initializes view objects and binds any necessary
  # callbacks or other handlers.
  constructor: (config={}) ->
    @leftDropdown = new app.ui.SourceDropdown(config.leftDropdown)
    @rightDropdown = new app.ui.SourceDropdown(config.rightDropdown)
    @slider = new app.ui.ScreenshotSlider(config.slider)

    # Callbacks

    # Only allow one dropdown active at a given point of time.
    @leftDropdown.didActivate = => @rightDropdown.deactivate()
    @rightDropdown.didActivate = => @leftDropdown.deactivate()

    # Handle selection changes.
    # TODO: Communicate new publication to associated screenshot pane.
    # TODO: Communicate new publication to screenshot slider. (or... just get new increments here in this controller)
    @leftDropdown.didSelect = (publication) => console.log publication
    @rightDropdown.didSelect = (publication) => console.log publication

    # Load data
    @getPublicationData()
    @getScreenshotData()

  ##
  # Retrieve the screenshot payload to reduce
  # redundant requests.
  getScreenshotData: ->
    $.getJSON("/screenshots.json").done (data) =>
      @screenshots = data

  ##
  # Retrieve the screenshot payload to reduce
  # redundant requests.
  getPublicationData: ->
    $.getJSON("/publications.json").done (data) =>
      @publications = _.sortBy(data, (publication) -> publication.name)
      @leftDropdown.renderPublications(@publications)
      @rightDropdown.renderPublications(@publications)