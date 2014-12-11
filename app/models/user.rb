class User < ActiveRecord::Base
  has_many :tweets

  validates :username, uniqueness: true
  validates :email, uniqueness: true
  validates :username, :password, :email, presence: true

  include BCrypt

  def following
    followings = Following.where(follower_id: self.id)
    followed_ids = followings.pluck(:user_id)
    followed_ids.map do |followed_id|
      User.find(followed_id)
    end
  end

  def follow(user)
    unless self.following.include? user
      Following.create(user_id: user.id, follower_id: self.id)
    end
  end

  def followers
    followings = Following.where(user_id: self.id)
    follower_ids = followings.pluck(:follower_id)
    follower_ids.map do |follower_id|
      User.find(follower_id)
    end
  end

  def add_follower(user)
    unless self.followers.include? user
      Following.create(user_id: self.id, follower_id: user.id)
    end
  end

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
