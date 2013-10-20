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
    url = if source then source.image_url else 'http://placehold.it/1024&text=No+Image+Available'
    @element.attr 'src', url
