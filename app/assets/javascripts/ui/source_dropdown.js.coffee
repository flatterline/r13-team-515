# Namespace
@app.namespace "ui"

##
# SourceDropdown
# ------
# Generates a list of sources and handles basic
# behavior for changing the current publication
# for a given panel. The target element
class app.ui.SourceDropdown
  @TEMPLATE_LIST = $("#template-source-list").html()
  @TEMPLATE_ITEM = $("#template-source-item").html()
  @ACTIVE_CLASS = "active"

  constructor: (element) ->
    @$element = $(element)
    @$element.click(@toggleActive)
    listId = "#{@$element.attr("id")}-list"
    @$list = $(Mustache.to_html(app.ui.SourceDropdown.TEMPLATE_LIST, id: listId))
    $("body").append(@$list)

  toggleActive: (event) =>
    event.preventDefault()
    if @$element.hasClass(app.ui.SourceDropdown.ACTIVE_CLASS)
      @deactivate()
    else
      @activate()

  deactivate: ->
    @$element.removeClass(app.ui.SourceDropdown.ACTIVE_CLASS)
    @$list.removeClass(app.ui.SourceDropdown.ACTIVE_CLASS)

  activate: ->
    @$element.addClass(app.ui.SourceDropdown.ACTIVE_CLASS)
    @$list.addClass(app.ui.SourceDropdown.ACTIVE_CLASS)
    @$list.scrollTop(0)
    @didActivate() if typeof @didActivate == "function"

  renderPublications: (publications) ->
    @$list.html("")
    for publication in publications
      item = Mustache.to_html(app.ui.SourceDropdown.TEMPLATE_ITEM, name: publication.name)
      @$list.append(item)