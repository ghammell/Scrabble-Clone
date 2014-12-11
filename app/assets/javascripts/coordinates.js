var DropResetter = function( coords ) {
  this.coords = coords
  this.reset = function() {
    $('.coordinate').droppable('disable')
    for (i=0; i < this.coords.length; i++) {
      coordinate_div = '#coordinate_' + this.coords[i].id
      $(coordinate_div).droppable('enable')
    }
  }
}