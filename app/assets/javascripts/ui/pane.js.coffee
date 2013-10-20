# Namespace
@app.namespace "ui"

##
# Pane (Left/Right)
# ------
# Holds state of the left/right side screenshot
# panes from a source, and handles the swapping

class app.ui.Pane
  # {"timestamp":1382229888,"publication_section_id":1,"publication_id":1,"image_url":"/media/W1siZiIsIjIwMTMvMTAvMTkvMTdfNDVfMDVfNzdfZmlsZSJdXQ"}
  constructor: (element) ->
    @element = element

  render: (source) ->
    @element.hide()
    # $('.img-loader').show()

    @element.load( ->
      # $('.img-loader').hide()
      $(@).show()
    ).attr 'src', source.image_url