class User < ActiveRecord::Base
  attr_accessible :email, :name, :wins, :losses

  has_many :teams
  has_many :games, :through => :teams

scope :todays_top_points, lambda { |input| joins(:teams).where("teams.date  = ?", input).order("teams.points desc").uniq } #SCOTT TEST THIS PLEASE
  

  
  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.image_url = auth.info.image
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
  
  def facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)
  end
  
  def add_win
    self.wins += 1
    self.save
  end
  
  def add_loss
    self.losses += 1
    self.save
  end
end
