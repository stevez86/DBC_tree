class User < ActiveRecord::Base

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
end
