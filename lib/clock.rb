require File.expand_path('../../config/boot',        __FILE__)
require File.expand_path('../../config/environment', __FILE__)
require 'clockwork'

# include Clockwork

module Clockwork
  
  every(1.day, 'reset nba schedule', :at => '9:55') { 
    'rake db:reset_nba_schedule'
  }
  
  every(1.day, 'set play for the day', :at => '10:00') { 
    'rake db:set_play_today'
  }
  
  every(1.day, 'set play for the day', :at => '23:45') { 
    'rake db:set_results'
  }

  every(10.minutes, 'update live scores') { 
    'rake db:update_live_players'
  }
  
end
