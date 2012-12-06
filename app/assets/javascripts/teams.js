var Team = {
  init: function() {
    $('#position_list').on('change', Team.showByPosition);
    $('.athletes').on('ajax:success', 'a.remove-athlete', Team.removeAthlete);
    $('.athletes-list').on('ajax:success', 'a.add-athlete', Team.addAthlete);
    $('.player_table tr td').popover({
      trigger: 'hover'
    });
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
    var position = $(this).parent().attr('class').split(' ')[1].split('-')[1];
    var play_id = $card.attr("id");
    $card.remove();
    $('#' + play_id + '_tr').show();
  },

  addAthlete: function(event, data) {
    var new_position = data.player_card.split('delete_button ')[1].split("\'")[0];
    if ( $('div').hasClass(new_position)) {
      old_player_card = $('div.' + new_position).closest('.player_card');
      new_player_card = $(data.player_card).hide();
      old_player_card.replaceWith(new_player_card);
      new_player_card.fadeIn("slow");
      $('#' + old_player_card.attr("id") + "_tr").show();
    }
    else {
      $('.athletes').append(data.player_card);
    }
    var position = $(this).parent().parent().attr('class').split(' ')[0];
    $(this).closest('tr').hide();
  },
};

$(document).ready(function() { Team.init(); });

