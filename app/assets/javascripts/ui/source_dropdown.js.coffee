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
  @ACTIVE_CLASS  = "active"

  constructor: (element) ->
    @publicationId = 0
    @$element      = $(element)
    @$element.click(@toggleActive)
    listId         = "#{@$element.attr("id")}-list"
    @$list         = $(Mustache.to_html(app.ui.SourceDropdown.TEMPLATE_LIST, id: listId))
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

  setPublication: (@currentPublication) ->
    @didSelect(@currentPublication) if typeof @didSelect == "function"
    @$element.html @currentPublication.name
    @$element.data('publication-id', @currentPublication.id)

  renderPublications: (@publications) ->
    @$list.html("")
    for publication in @publications
      $item = $(Mustache.to_html(app.ui.SourceDropdown.TEMPLATE_ITEM, {name: publication.name, id: publication.id}))
      $item.click(@handleSelection)
      @$list.append($item)

  handleSelection: (event) =>
    $item         = $(event.currentTarget)
    publicationId = parseInt $item.attr("data-publication-id")
    @setPublication _.findWhere(@publications, { id: publicationId })
    @deactivate()
