var Team = {
  init: function() {
    $('#position_list').on('change', Team.showByPosition);
    $('.athletes').on('ajax:success', 'a.remove-athlete', Team.removeAthlete);
    $('.athletes-list').on('ajax:success', 'a.add-athlete', Team.addAthlete);
  },

  showByPosition: function(event){
    var filter = event.target.value;

    if (filter === "ALL") {
      $('[class^=position_]').show();
    } else {
      $('.position_PG, .position_C, .position_SG, .position_SF, .position_PF').hide();
      $('.position_' + filter).show();
    }
  },

  removeAthlete: function(event, data) {
    var $card = $(this).closest('.player_card');
    var play_id = $card.attr("id");
    // var play_id = $(this).closest('.player_card').attr("id");
    $card.remove();
    $('#' + play_id + '_tr').show();

  },

  addAthlete: function(event, data) {
    $('.athletes').append(data.player_card);
    $(this).closest('tr').hide();
  }

};

$(document).ready(function() { Team.init(); });