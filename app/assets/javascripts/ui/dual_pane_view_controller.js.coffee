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
        @sectionName = @sectionSelect.current
        source = _.find @screenshots, (el) -> el.publication_id == publication.id && el.section_name == @sectionName
        @leftPane.render(source)
        @leftPublicationId = publication.id
        @leftPublicationSlug = publication.slug
        @setSliderIntervals()
        @updatePageTitle()


    @rightDropdown.didSelect =
      (publication) =>
        @sectionName = @sectionSelect.current
        source = _.find @screenshots, (el) -> el.publication_id == publication.id && el.section_name == @sectionName
        @rightPane.render(source)
        @rightPublicationId = publication.id
        @rightPublicationSlug = publication.slug
        @setSliderIntervals()
        @updatePageTitle()
        @pushHistory()

    # Handle time slider changes.
    @slider.didChange = () =>
      @updatePanes()

    @sectionSelect.didSelect = () =>
      @updatePanes()

    # HTML5 History
    window.addEventListener "popstate", (event) =>
      console.log location.toString()

    # Load data
    @getPublicationData(@finishInitialize)
    @getScreenshotData(@finishInitialize)

  finishInitialize: () =>
    if (typeof @screenhots == "object") and (typeof @publications == "object")
      routeConfig = @parseRoute(location.toString())
      @sectionName = routeConfig.section || "home"
      @setSliderIntervals()
      @updatePanes()

  ##
  # Parses a route.
  parseRoute: (route) ->
    route = route.split("/")
    parsed =
      section: route[0]
      leftPublication: _.findWhere(@publications, {slug: route[1]})
      rightPublication: _.findWhere(@publications, {slug: route[2]})
      timestamp: parseInt route[3]

  ##
  # Updated the history with a route for the specific sources
  # at a selected timestamp.
  pushHistory: ->
    route = "/#{@sectionName}/#{@leftPublicationSlug}/#{@rightPublicationSlug}/#{@timestamp}"
    if Modernizr.history
      history.pushState(null, null, route)

  ##
  # Retrieves the screenshot for a specific publication
  # at a specific timestamp and section.
  screenForPub: (publicationId) ->
    @sectionName = @sectionSelect.current
    timestamp   = @slider.timestamp
    screens     = _.filter @screenshots, (el) -> el.publication_id == publicationId && el.section_name == @sectionName
    _.find screens, (el) ->
      parseInt(el.timestamp) == parseInt(timestamp)

  updatePanes: ->
    @displayTimeStamp()
    @leftPane.render @screenForPub(@leftPublicationId)
    @rightPane.render @screenForPub(@rightPublicationId)
    @updatePageTitle()

  ##
  # Formats a timestamp to something more user friendly.
  formatTimestamp: (timestamp) ->
    moment(timestamp*1000).format('MMM Do YYYY, h:mm a')

  ##
  # Displays a niceles formatted time to the user in
  # addition to updating the panes.
  displayTimeStamp: () ->
    @timestamp = @slider.timestamp
    @timeDisplay.html(@formatTimestamp @timestamp)
    @timeDisplay.addClass("active")
    clearTimeout(@hudTimeout) if @hudTimeout
    @hudTimeout = setTimeout =>
      @timeDisplay.removeClass("active")
    , 1500
    @pushHistory()

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
      @leftPublicationSlug = _.findWhere(@publications, {id: @leftPublicationId}).slug
      @rightPublicationSlug = _.findWhere(@publications, {id: @rightPublicationId}).slug
      callback() if typeof callback == "function"

  updatePageTitle: () ->
    document.title = $('#left-source').html() + ' vs. ' + $('#right-source').html() + ' | ' + @sectionSelect.selected().html() + ' | ' + @formatTimestamp(@slider.timestamp) + ' | All The News'
