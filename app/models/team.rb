class Team < ActiveRecord::Base
  attr_accessible :date, :user_id

  has_and_belongs_to_many :athletes
  belongs_to :user
end
