##
# Application JS is following a single global
# pattern. The root object is @app.
@app = {} if (typeof app != "object")

##
# Convenience method to easily add namespaces to the
# global object.
@app.namespace = (namespace) ->
  app[namespace] = {} if typeof app[namespace] != "object"
  app[namespace]

##
# Adds CSRF protection to a supplied object or generates
# a new object soley with the CSRF parameters.
@app.csrf = (object) ->

  if typeof object != "Object"
    object = {}

  object[app.CSRF_PARAM] = app.CSRF_TOKEN
  object

##
# Bind the CSRF attributes and configure the
# page.
$(document).ready ->
  app.CSRF_PARAM = $("meta[name='csrf-param']").attr("content")
  app.CSRF_TOKEN = $("meta[name='csrf-token']").attr("content")

  # Setup the time slider.
  screenSlider = new app.ui.ScreenshotSlider $("#date-select-slider")

  ##
  # Retrieve the screenshot payload to reduce
  # redundant requests.
  $.getJSON("/screenshots.json").done (data) ->
    app.SCREENSHOTS = data
    screenSlider.setPublications(1,2)


