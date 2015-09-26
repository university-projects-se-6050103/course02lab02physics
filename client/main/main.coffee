Template.Main.onCreated ->
  @throwHeight = new ReactiveVar 225

Template.Main.helpers
  throwHeight: ->
    (Template.instance().throwHeight.get() + 25) / 5

Template.Main.events
  'change #height-range-input': (event, tmpl) ->
    tmpl.throwHeight.set (tmpl.$(event.target).val() * 5 - 25)
    tmpl.$('#ball').css 'bottom', tmpl.throwHeight.get() + 'px'
  'click #throw': (event, tmpl) ->
    ball = tmpl.$('#ball')
    ruler = tmpl.$('#ruler')
    positionX = 0
    positionY = tmpl.throwHeight.get()
    ballFly = Meteor.setInterval ->
      ball.css('right', positionX++)
      if positionX % 3 is 0
        ball.css('bottom', positionY--)
      if overlaps ball[0], ruler[0]
        Meteor.clearInterval ballFly
    , 1
