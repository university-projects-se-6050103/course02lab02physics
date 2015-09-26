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
    positionX = 0
    positionY = tmpl.throwHeight.get()
    Meteor.setInterval ->
      ball.css('right', positionX++)
      if positionX % 3 is 0
        ball.css('bottom', positionY--)
    , 10


Template.Main.onRendered ->
