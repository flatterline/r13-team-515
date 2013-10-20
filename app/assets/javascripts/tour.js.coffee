tour =
  id: "hello-hopscotch",
  steps: [
    {
      title: "Dude!"
      content: "Welcome to the Wyld Stallyns Rails Rumble. We believe we've brought forth to you a most excellent <span id='adventure'>adventure</span>... submission.  "
      target: "#left-source"
      placement: "bottom"
      width: 500
    },
    {
      title: "What is this awesome idea?"
      content: "Do you like news?  Do you like unbiased news?  How do you know if your favorite news organization is being fair in what they're reporting?  We're making it easy to compare the messages different organizations are trying to sell you."
      target: "#right-source"
      placement: "bottom"
      width: 400
    },
    {
      title: "Select Your News"
      content: "Select your two favorite (or least favorite) news organizations here and compare what they believe are the top stories at the moment."
      target: "#right-source"
      placement: "bottom"
    },
    {
      title: "A Time Machine? Gnarly!"
      content: "We take screenshots throughout the day of each organization's site.  Here you can select from previous captures."
      target: ".time-machine"
      placement: "top"
    },
    {
      title: "Righteous"
      content: "We hope this is a useful tool for you, so remember. Be excellent to each other. And... PARTY ON, DUDES!"
      target: "#right-source"
      placement: "bottom"
    }
  ],
  onEnd: ->
    $.cookie('tour', 'taken')
  onClose: ->
    $.cookie('tour', 'taken')


$(document).ready ->
  if $.cookie('tour') != 'taken'
    hopscotch.startTour(tour)

  $('#help').click (evt) ->
    hopscotch.startTour(tour)
    false