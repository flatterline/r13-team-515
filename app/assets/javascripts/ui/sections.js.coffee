class app.ui.SectionSelect
  constructor: (element) ->
    @element = element
    @setCurrent()

    @element.on 'change', =>
      @setCurrent()
      @didSelect() if typeof @didSelect == "function"

  current: ->
    @current

  selected: ->
    @selectedOption = @element.find('> option:selected')

  setCurrent: =>
    @current = @selected().val()
