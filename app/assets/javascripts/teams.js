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

$(document).ready(function() { Team.init() })