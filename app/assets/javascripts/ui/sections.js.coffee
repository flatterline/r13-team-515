class app.ui.SectionSelect
  constructor: (element) ->
    @element = element
    @setCurrent()

    @element.on 'change', =>
      @setCurrent()
      @didSelect() if typeof @didSelect == "function"

  current: ->
    @current

  setCurrent: ->
    @current = @element.find('> option:selected').val()
