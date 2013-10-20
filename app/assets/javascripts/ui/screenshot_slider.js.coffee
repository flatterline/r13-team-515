# Namespace
@app.namespace "ui"

##
# ScreenshotSlider
# ------
# Basic UI widget which expects to receive an
# `input` element with the `range` type. In modern
# browsers this will default to a slider but this
# component will wrap it in a simple HTML template
# so that we can customize the behavior and
# appearance.
class app.ui.ScreenshotSlider
  @CSS_CLASS = "js-ui-slider"
  @TEMPLATE = $("#template-ui-slider").html()

  ##
  # Renders the template in place of the native
  # HTML5 range component using its attributes
  # as defaults for the abstract class.
  constructor: (element) ->
    @$element = $(element)
    @min = parseInt @$element.attr("min")
    @max = parseInt @$element.attr("max")
    @value = parseInt @$element.attr("value")
    @intervals = []

    if typeof @$element.attr("id") == "string"
      @id = "#{@$element.attr("id")}-abstract"

    @$element.after(Mustache.to_html(app.ui.ScreenshotSlider.TEMPLATE, {id: @id}))
    @$element.hide()
    @container = @$element.next()
    @control = @container.find(".slider-control")
    @control.mousedown (e) => @activate(); false

  ##
  # Enables tracking for the slider by listening
  # to mouseevents on the document.
  activate: () =>
    @activated = true
    $(document).bind "mousemove", @handleDrag
    $(document).bind "mouseup", @deactivate

  ##
  # Disables document level mouse event handlers.
  deactivate: () =>
    $(document).unbind "mousemove", @handleDrag
    $(document).unbind "mouseup", @deactivate

  ##
  # Determines the location of the slider control
  # based on a mouse event.
  handleDrag: (e) =>
    x = e.pageX - @container.offset().left

    if @intervals.length > 0
      intervalWidth = @container.width()/(@intervals.length-1)
      interval = Math.round(x/intervalWidth)

      if @interval != interval
        @interval = interval
        @didChange(@intervals[interval]) if typeof @didChange == "function"
        console.log @formatTimestamp @intervals[interval]

    if x > 0 and x < @container.width() - @control.width()
      app.util.transform(@control[0], x, 0);

  ##
  # Formats a timestamp to something more user friendly.
  formatTimestamp: (timestamp) ->
    date = new Date(timestamp*1000)
    months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    "#{months[date.getMonth()]} #{date.getDate()} | #{date.getHours()}:00"

  ##
  # Translates the control to given percentage.
  translateToPercentage: (percent) ->
    percent = percent / 100 if percent > 1
    x = percent * (@container.width() - @control.width())
    app.util.transform(@control[0], x, 0);

  ##
  # Resets the slider position pending new data and updates
  # the local interval object.
  setIntervals: (@intervals) ->
    @translateToPercentage(100)
    @interval = @intervals.length