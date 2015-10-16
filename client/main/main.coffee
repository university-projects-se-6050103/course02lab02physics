Template.Main.onCreated ->
  @throwHeight = new ReactiveVar 225
  @v0 = new ReactiveVar 1
  @throwDistance = new ReactiveVar -25

Template.Main.helpers
  throwHeight: ->
    (Template.instance().throwHeight.get() + 25) / 5
  throwDistance: ->
    (Template.instance().throwDistance.get() + 25) / 10

Template.Main.events
  'change #height-range-input': (event, tmpl) ->
    tmpl.throwHeight.set (tmpl.$(event.target).val() * 5 - 25)
    tmpl.$('#ball').css 'bottom', tmpl.throwHeight.get() + 'px'
  'change #v0': (event, tmpl) ->
    tmpl.v0.set parseFloat tmpl.$(event.target).val()
  'click #throw': (event, tmpl) ->
    ball = tmpl.$('#ball')
    ruler = tmpl.$('#ruler')
    positionX = 0
    positionY = tmpl.throwHeight.get()
    v0 = tmpl.v0.get()
    h = tmpl.throwHeight.get()
    s = (v0 * Math.sqrt((2 * (h * 0.01) / 9.8)) / 18) * 0.01
    step = 0
    ballFly = Meteor.setInterval ->
      ball.css('right', positionX += v0 * 2)
      ball.css('bottom', positionY -= Math.sqrt(step++))
      if overlaps ball[0], ruler[0]
        Meteor.clearInterval ballFly
        tmpl.throwDistance.set s
    , 1
