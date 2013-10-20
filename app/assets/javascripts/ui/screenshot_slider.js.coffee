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
  @TEMPLATE_ID = "template-ui-slider"

  ##
  # Renders the template in place of the native
  # HTML5 range component using its attributes
  # as defaults for the abstract class.
  constructor: (element) ->
    @$element = $(element)
    @min = parseInt @$element.attr("min")
    @max = parseInt @$element.attr("max")
    @value = parseInt @$element.attr("value")
    @template = $("##{app.ui.ScreenshotSlider.TEMPLATE_ID}").html()

    if typeof @$element.attr("id") == "string"
      @id = "#{@$element.attr("id")}-abstract"

    @$element.after(Mustache.to_html(@template, {id: @id}))
    @$element.hide()
    @container = @$element.next()
    @control = @container.find(".slider-control")
    @control.mousedown (e) => @activate(); false

  activate: () =>
    @activated = true
    $(document).bind "mousemove", @translate
    $(document).bind "mouseup", @deactivate

  deactivate: () =>
    $(document).unbind "mousemove", @translate
    $(document).unbind "mouseup", @deactivate

  translate: (e) =>
    x = e.pageX - @container.offset().left
    if x > 0 and x < @container.width() - @control.width()
      app.util.transform(@control[0], x, 0);

  setPublications: (leftPublicationId,rightPublicationId) ->
    sourceResults = _.filter app.SCREENSHOTS, (screen) ->
      (screen.publication_id == leftPublicationId || screen.publication_id == rightPublicationId)

    orderedResults = _.sortBy sourceResults, (screen) ->
      screen.timestamp

    @screens = _.groupBy orderedResults, (screen) ->
      screen.timestamp

    @intervals = _.keys(@screens)
