class User < ActiveRecord::Base
  attr_accessible :email, :name, :wins, :losses

  has_many :teams
  has_many :games, :through => :teams
  has_many :friends

scope :yesterdays_top_points, lambda { |input| joins(:teams).where("teams.date  = ?", input).order("teams.points desc").limit(15).uniq } #SCOTT TEST THIS PLEASE



  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.image_url = auth.info.image
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save
    end
  end

  def add_friends
    self.facebook.get_connection("me","friends").each do |hash|
      self.friends.where(:name => hash['name'], :uid => hash['id']).first_or_create
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

  def last_five_teams
    @teams = teams.order('id desc').limit(5)
  end
end
