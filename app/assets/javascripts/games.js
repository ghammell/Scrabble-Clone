$(document).ready(function(){
  BindSeeRulesButton()
  BindShuffleButtons()
})

var BindSeeRulesButton = function() {
  $('#rules_button').click( function() {
    $('#instructions').slideToggle()
  })
}

var BindShuffleButtons = function() {
  $('body').on('click', '.shuffle_button', function() {
    parent = $(this).parent().siblings('.hand_letters')
    divs = parent.children()
    parent.fadeOut(100, function() {
      while (divs.length) {
          parent.append(divs.splice(Math.floor(Math.random() * divs.length), 1)[0]);
      }
    })
    parent.fadeIn(100)
  })
}

var alphabet = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']

var calcPointsForLetter = function(letter) {
  difficult = ['X','Y','Z','Q']
  easy = ['A', 'E', 'I', 'O', 'U', 'Y']
  moderate = $(difficult).not(easy).get()
  if ( $.inArray(letter, difficult) > -1 ) {
    return 3
  } else if ( $.inArray(letter, easy) > -1) {
    return 1
  } else {
    return 2
  }
}

var BindDraggable = function(selector) {
  $(selector).draggable({
    scroll: true,
    cursor: 'pointer',
    revert: 'invalid',
    snap: false,
    opacity: 0.9,
    start: function() {
      $('.ui-droppable:not(.ui-droppable-disabled)').css('background-color', '#8998BB')
      $('.ui-droppable:not(.ui-droppable-disabled) span').css('color', '#8998BB')
    },
    stop: function() {
      $('.ui-droppable:not(.taken, .multiple_div)').css('background-color', '#FFE1AA')
      $('.multiple_div:not(.taken)').css('background-color', '#95c2a6')
      $('.ui-droppable:not(.taken) span').css('color', '#FFE1AA')
    }
  })
}

var BindDroppable = function(selector) {
  $(selector).droppable({
    drop: function(event, ui) {
      new_text = ui.draggable.text()
      $(ui.draggable).remove()
      $(this).droppable('disable')
      $(this).find('.multiple_info, span').hide()
      $(this).append("<span class='taken_letter'>" + new_text + "</span>")
      $(this).css('background-color', '#9A2525')
      $(this).effect('highlight', {color: 'black'}, 1000)
      $(this).addClass('taken')
      coord_id = $(this).attr('id').split("_")[1]
      UpdateCoordinate(coord_id, new_text)
    },
    accept: '.draggable',
    over: function() {
      $(this).css('background-color', 'black')
    },
    out: function() {
      $(this).css('background-color', '#8998BB')
    }
  })
}

var UpdateCoordinate = function(id, value) {
  $.ajax({
    method: 'GET',
    url: '/games/' + gameId + '/coordinates/' + id + '/update_letter',
    data: {value: value}
  })
  .done(function() {
    console.log('success')
  })
}