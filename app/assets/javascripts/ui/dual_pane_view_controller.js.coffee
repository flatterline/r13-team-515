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
    @leftDropdown         = new app.ui.SourceDropdown(config.leftDropdown)
    @rightDropdown        = new app.ui.SourceDropdown(config.rightDropdown)
    @slider               = new app.ui.ScreenshotSlider(config.slider)
    @leftPane             = new app.ui.Pane(config.leftPane)
    @rightPane            = new app.ui.Pane(config.rightPane)
    @leftPublicationId    = config.leftPublicationId
    @rightPublicationId   = config.rightPublicationId

    # Callbacks

    # Only allow one dropdown active at a given point of time.
    @leftDropdown.didActivate  = => @rightDropdown.deactivate()
    @rightDropdown.didActivate = => @leftDropdown.deactivate()

    # Handle selection changes.
    @leftDropdown.didSelect  =
      (publication) =>
        source = _.find @screenshots, (el) -> el.publication_id == publication.id
        @leftPane.render(source)
        @leftPublicationId = publication.id
        @setSliderIntervals()

    @rightDropdown.didSelect =
      (publication) =>
        source = _.find @screenshots, (el) -> el.publication_id == publication.id
        @rightPane.render(source)
        @rightPublicationId = publication.id
        @setSliderIntervals()

    # Handle time slider changes.
    @slider.didChange = (timestamp) =>
      @updateTimestamp(timestamp)

    # Load data
    @getPublicationData()
    @getScreenshotData(@setSliderIntervals)

  screenForPubAtTime: (publicationId, timestamp) ->
    screens = _.filter @screenshots, (el) -> el.publication_id == publicationId
    _.find screens, (el) ->
      parseInt(el.timestamp) == parseInt(timestamp)

  updateTimestamp: (timestamp) ->
    @leftPane.render @screenForPubAtTime(@leftPublicationId,timestamp)
    @rightPane.render @screenForPubAtTime(@rightPublicationId,timestamp)

  ##
  # Set the publications for the slider.
  setSliderIntervals: =>
    sourceResults = _.filter @screenshots, (screen) =>
      (screen.publication_id == @leftPublicationId || screen.publication_id == @rightPublicationId)
    orderedResults = _.sortBy sourceResults, (screen) ->
      screen.timestamp
    screens = _.groupBy orderedResults, (screen) ->
      screen.timestamp
    @slider.setIntervals(_.keys(screens))

  ##
  # Retrieve the screenshot payload to reduce
  # redundant requests.
  getScreenshotData: (callback) ->
    $.getJSON("/screenshots.json").done (data) =>
      @screenshots = data
      callback() if typeof callback == "function"

  ##
  # Retrieve the screenshot payload to reduce
  # redundant requests.
  getPublicationData: (callback) ->
    $.getJSON("/publications.json").done (data) =>
      @publications = _.sortBy(data, (publication) -> publication.name)
      @leftDropdown.renderPublications(@publications)
      @rightDropdown.renderPublications(@publications)
      callback() if typeof callback == "function"