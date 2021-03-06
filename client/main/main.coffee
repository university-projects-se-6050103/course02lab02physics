Template.Main.onCreated ->
  @throwHeight = new ReactiveVar 225
  @v0 = new ReactiveVar 1
  @throwDistance = new ReactiveVar -25
  @ballFlySound = new Audio('ball-fly-sound.ogg')
  @ballOverlapSound = new Audio('boom.ogg')

Template.Main.helpers
  throwHeight: ->
    (Template.instance().throwHeight.get() + 25) / 5
  throwDistance: ->
    ((Template.instance().throwDistance.get() + 25) / 10).toFixed(2)

Template.Main.events
  'change #height-range-input': (event, tmpl) ->
    tmpl.throwHeight.set (tmpl.$(event.target).val() * 5 - 25)
    tmpl.$('#ball').css('bottom', (tmpl.throwHeight.get() + 50) + 'px').css('right', 0)
    tmpl.throwDistance.set 0
  'change #v0': (event, tmpl) ->
    tmpl.v0.set parseFloat tmpl.$(event.target).val()
  'click #throw': (event, tmpl) ->
    tmpl.ballFlySound.play()
    tmpl.$(event.target).addClass 'pulsate'
    randomTracerColor = randomColor
      luminosity: 'bright'
      format: 'rgb'

    ball = tmpl.$('#ball')
    ruler = tmpl.$('#ruler')
    positionX = 0
    positionY = tmpl.throwHeight.get() + 50
    v0 = tmpl.v0.get()
    h = tmpl.throwHeight.get()
    s = (v0 * Math.sqrt((2 * (h / 0.01) / 9.8)))
    step = 0
    ballFly = Meteor.setInterval ->
      ball.css('right', positionX += v0 * 2)
      ball.css('bottom', positionY -= Math.sqrt(step++))

      ball.after($("<div class=\"trace-dot\" style=\"background: #{randomTracerColor}; right: #{positionX + 20}px; bottom: #{positionY + 15}px\"></div>"))

      if overlaps ball[0], ruler[0]
        tmpl.ballFlySound.pause()
        tmpl.ballOverlapSound.play()
        tmpl.ballFlySound = new Audio('ball-fly-sound.ogg')
        Meteor.clearInterval ballFly
        tmpl.throwDistance.set s
        tmpl.$(event.target).removeClass 'pulsate'
    , 30
