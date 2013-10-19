# Namespace
@app.namespace "ui"

# Auto initialize
$(document).ready ->
  $(".#{app.ui.Slider.CSS_CLASS}").each (index,sliderElement) ->
    new app.ui.Slider(sliderElement)

##
# Slider
# ------
# Basic UI widget which expects to receive an
# `input` element with the `range` type. In modern
# browsers this will default to a slider but this
# component will wrap it in a simple HTML template
# so that we can customize the behavior and
# appearance.
class app.ui.Slider
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
    @template = $("##{app.ui.Slider.TEMPLATE_ID}").html()

    if typeof @$element.attr("id") == "string"
      @id = "#{@$element.attr("id")}-abstract"

    html = Mustache.to_html(@template, {id: @id})

    @$element.after(html)
    @$element.hide()













