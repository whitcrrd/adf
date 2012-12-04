var Team = {
  init: function() {
    $('#position_list').on('change', Team.showByPosition);
    $('.athletes').on('ajax:success', 'a.remove-athlete', Team.removeAthlete);
    $('.athletes-list').on('ajax:success', 'a.add-athlete', Team.addAthlete);
  },

  showByPosition: function(){
    if (event.target.value === "ALL") {
      $('[class^=position_]').show();
    } else {
      $('.position_PG, .position_C, .position_SG, .position_SF, .position_PF').hide();
      $('.position_' + event.target.value).show();
    }
  },

  removeAthlete: function(event, data) {
    var play_id = $(this).closest('.player_card').attr("id");
    $(this).closest('.player_card').remove();
    $('#' + play_id + '_tr').show();

  },

  addAthlete: function(event, data) {
    $('.athletes').append(data.player_card);
    $(this).closest('tr').hide();
  }

};

$(document).ready(function() { Team.init(); });

jQuery.fn.sortElements = (function(){

    var sort = [].sort;

    return function(comparator, getSortable) {

        getSortable = getSortable || function(){return this;};

        var placements = this.map(function(){

            var sortElement = getSortable.call(this),
                parentNode = sortElement.parentNode,
                nextSibling = parentNode.insertBefore(
                    document.createTextNode(''),
                    sortElement.nextSibling
                );

            return function() {

                if (parentNode === this) {
                    throw new Error(
                        "You can't sort elements if any one is a descendant of another."
                    );
                }
                parentNode.insertBefore(this, nextSibling);
                parentNode.removeChild(nextSibling);
            };

        });
        return sort.call(this, comparator).each(function(i){
            placements[i].call(getSortable.call(this));
        });
    };

})();

// $document.ready(function(){


// });

// $('.player_table #players').sortElements(function(a, b){
//     return $(a).text() > $(b).text() ? 1 : -1;
// });
