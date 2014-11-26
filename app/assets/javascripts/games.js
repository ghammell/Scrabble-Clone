$(document).ready(function(){
})

var BindDraggable = function(selector) {
  $(selector).draggable({
    scroll: true,
    cursor: 'pointer',
    helper: 'clone',
    revert: true,
    snap: false,
    opacity: 0.9
  })
}

var BindDroppable = function(selector) {
  $(selector).droppable({
    drop: function(event, ui) {
      $(this).find('span').text( ui.draggable.text() )
    },
    accept: '.letter',
    hoverClass: "ui-state-hover"
  })
}