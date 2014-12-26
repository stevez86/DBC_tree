class User < ActiveRecord::Base

  # follower_follows "names" the Follow join table for accessing through the follower association
  has_many :mentor_ments, foreign_key: :mentee_id, class_name: "Mentor"
  # source: :follower matches with the belong_to :follower identification in the Follow model
  has_many :mentors, through: :mentor_ments, source: :mentor

  # mentee_follows "names" the Follow join table for accessing through the mentee association
  has_many :mentee_follows, foreign_key: :mentor_id, class_name: "Mentor"
  # source: :mentee matches with the belong_to :mentee identification in the Follow model
  has_many :mentees, through: :mentee_ments, source: :mentee

  include BCrypt

  validates :username, uniqueness: true
  validates :email, uniqueness: true
  validates :username, :password, :email, presence: true

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
