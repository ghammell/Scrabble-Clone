$(document).ready(function(){
})

var alphabet = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']

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
      $('.multiple_div').css('background-color', '#95c2a6')
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