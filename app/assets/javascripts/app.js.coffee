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

  # Set the target elements for the view controller.
  config =
    leftDropdown: $("#left-source")
    rightDropdown: $("#right-source")
    slider: $("#date-select-slider")
    leftPane: $('#left-panel img')
    rightPane: $('#right-panel img')

  # Initialize the view:
  new app.ui.DualPaneViewController(config)