Template.Main.onCreated ->
  @throwHeight = new ReactiveVar 225
  @v0 = new ReactiveVar 0

Template.Main.helpers
  throwHeight: ->
    (Template.instance().throwHeight.get() + 25) / 5

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
    ballFly = Meteor.setInterval ->
      ball.css('right', positionX += v0)
      ball.css('bottom', positionY -= 0.5)
      if overlaps ball[0], ruler[0]
        Meteor.clearInterval ballFly
    , 1
