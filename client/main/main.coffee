Template.Main.onCreated ->
  @throwHeight = new ReactiveVar 0

Template.Main.helpers
  throwHeight: ->
    Template.instance().throwHeight.get()

Template.Main.events
  'change #height-range-input': (event, tmpl) ->
    tmpl.throwHeight.set tmpl.$(event.target).val()
    tmpl.$('#ball').css 'bottom', (tmpl.throwHeight.get() * 5 - 25) + 'px'


Template.Main.onRendered ->
  ball = @$('#ball')
  positionX = 0
  positionY = @throwHeight.get()
#  Meteor.setInterval ->
#    ball.css('right', positionX++)
#    if positionX % 3 is 0
#      ball.css('top', positionY++)
#  , 10