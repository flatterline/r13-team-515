tour =
  id: "hello-hopscotch",
  steps: [
    {
      title: "Dude!"
      content: "Welcome to the Wyld Stallyns Rails Rumble App. We believe we've brought forth to you a most excellent <span id='adventure'>adventure</span>... submission. <br/><br/> <img src='http://userserve-ak.last.fm/serve/_/41172767/Wyld+Stallyns+wyldstallyns.jpg'/> "
      target: "#center-anchor"
      placement: "bottom"
      width: 500
      xOffset: -250
    },
    {
      title: "What is this awesome idea?"
      content: "Do you like news?  Do you like unbiased news?  <br/><br/>&#34;I sure do Bill&#34;<br/>&#34;I know, me too Ted&#34;<br/><br/>So, how do you know if your favorite news organization is smearing the top headlines?  Or maybe they're not showing you the biggest story?  We're making it easy to compare the headlines different organizations are presenting you."
      target: "#right-source"
      placement: "bottom"
      width: 400
    },
    {
      title: "Select Your Source"
      content: "Select your two favorite (or least favorite) news organizations here and compare what they believe are the top stories at the moment."
      target: "#right-source"
      placement: "bottom"
    },
    {
      title: "A Time Machine? Gnarly!"
      content: "We take screenshots throughout the day of each organization's site.  Here you can select from previous captures using our time machine slider.<br/><br/>&#34;Rufus would be proud&#34;"
      target: ".slider-control"
      placement: "top"
      xOffset: -125
    },
    {
      title: "Righteous"
      content: "We hope this is a useful tool for you to see the news from all angles, so remember. Be excellent to each other. And... PARTY ON, DUDES!<br/><br/><br/><img src='http://30.media.tumblr.com/tumblr_lq6a5gy56k1qdaho1o1_r1_500.gif'/>"
      target: "#right-source"
      placement: "bottom"
      width: 575
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