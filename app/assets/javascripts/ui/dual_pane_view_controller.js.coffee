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
    @sectionSelect        = new app.ui.SectionSelect(config.sectionSelect)
    @leftPublicationId    = config.leftPublicationId
    @rightPublicationId   = config.rightPublicationId
    @timeDisplay          = config.timeDisplay

    # Callbacks

    # Only allow one dropdown active at a given point of time.
    @leftDropdown.didActivate  = => @rightDropdown.deactivate()
    @rightDropdown.didActivate = => @leftDropdown.deactivate()

    # Handle selection changes.
    @leftDropdown.didSelect  =
      (publication) =>
        sectionName = @sectionSelect.current
        source = _.find @screenshots, (el) -> el.publication_id == publication.id && el.section_name == sectionName
        @leftPane.render(source)
        @leftPublicationId = publication.id
        @setSliderIntervals()

    @rightDropdown.didSelect =
      (publication) =>
        sectionName = @sectionSelect.current
        source = _.find @screenshots, (el) -> el.publication_id == publication.id && el.section_name == sectionName
        @rightPane.render(source)
        @rightPublicationId = publication.id
        @setSliderIntervals()

    # Handle time slider changes.
    @slider.didChange = () =>
      @updatePanes()

    @sectionSelect.didSelect = () =>
      @updatePanes()

    # Load data
    @getPublicationData()
    @getScreenshotData(@finishInitialize)

  finishInitialize: () =>
    @setSliderIntervals()
    @updatePanes()


  ##
  # Retrieves the screenshot for a specific publication
  # at a specific timestamp and section.
  screenForPub: (publicationId) ->
    sectionName = @sectionSelect.current
    timestamp   = @slider.timestamp
    screens     = _.filter @screenshots, (el) -> el.publication_id == publicationId && el.section_name == sectionName
    _.find screens, (el) ->
      parseInt(el.timestamp) == parseInt(timestamp)

  updatePanes: ->
    @leftPane.render @screenForPub(@leftPublicationId)
    @rightPane.render @screenForPub(@rightPublicationId)
    @displayTimeStamp()

  ##
  # Formats a timestamp to something more user friendly.
  formatTimestamp: (timestamp) ->
    moment(timestamp*1000).format('MMMM Do YYYY, h:mm a')

  displayTimeStamp: () ->
    timestamp = @slider.timestamp
    @timeDisplay.html(@formatTimestamp timestamp)
    @timeDisplay.addClass("active")
    clearTimeout(@hudTimeout) if @hudTimeout
    @hudTimeout = setTimeout =>
      @timeDisplay.removeClass("active")
    , 1500

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
