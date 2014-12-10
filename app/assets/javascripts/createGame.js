function GameStarter( startCoordinate, game ) {
  this.startCoordinate = startCoordinate
  this.container = '#game_container'
  this.handOne = '#p1_hand'
  this.handTwo = '#p2_hand'
}

GameStarter.prototype.updateGame = function( gameObject, gameSelector ) {
  gameStarter = this
  $(this.container).empty()
  $(this.container).append( gameObject )
  $( gameSelector ).fadeIn( function(){
    gameStarter.updateHands()
  })
  $( gameSelector ).css('display', 'table')
}

GameStarter.prototype.updateHands = function() {
  gameStarter = this
  $( this.handOne ).slideDown( function(){
      $( gameStarter.handTwo ).slideDown()
    })
  $( this.handOne + ' .word_buttons').fadeIn()
  this.setDragProperties( this.handOne )
}

GameStarter.prototype.setDragProperties = function ( ) {
  $( this.handOne + ' .letter').addClass('draggable')
  BindDraggable('.draggable')
  BindDroppable('.coordinate')
  $('.coordinate').droppable('disable')
  $('#coordinate_' + this.startCoordinate).droppable('enable')
}

GameStarter.prototype.updateMultiples = function () {
  $('.multiple_info').parent().addClass('multiple_div')
  $('.coordinate:not(.multiple_div)').addClass('non_multiple_div')
}

GameStarter.prototype.initiate = function ( gameObject, gameSelector ) {
  $('#instructions').slideUp()
  $('#rules_button').fadeIn().css('display', 'inline-block')
  this.updateGame( gameObject, gameSelector)
  this.updateMultiples()
}