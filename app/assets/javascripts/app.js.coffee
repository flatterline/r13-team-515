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
    leftPane: $('#left-panel img').not('.img-loader')
    rightPane: $('#right-panel img').not('.img-loader')
    leftPublicationId: parseInt $("#left-source").data('publication-id')
    rightPublicationId: parseInt $("#right-source").data('publication-id')
    sectionSelect: $('#section-form select')
    slider: $("#date-select-slider")
    timeDisplay: $("#time-display");

  # Initialize the view:
  new app.ui.DualPaneViewController(config)

  # Rails rumble banner...
  $("#rumbleCloseButton").click -> $("body").removeClass "rumble"
