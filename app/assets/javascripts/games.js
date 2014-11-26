$(document).ready(function(){
  BindDraggable('.letter')
})

var BindDraggable = function(selector) {
  $(selector).draggable()
}