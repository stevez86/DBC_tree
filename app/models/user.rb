class User < ActiveRecord::Base

  include BCrypt

  belongs_to :cohort

  has_many :mentees, class_name: "User", foreign_key: "mentor_id"
  belongs_to :mentor, class_name: "User", inverse_of: :mentees

  has_one :liprofile

  # validates :email, uniqueness: true
  # validates :password, :email, presence: true

  after_initialize :defaults, :set_profile_url

  def defaults
    self.lineage_id ||= self.id
    self.save!
  end

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def mentor=(new_mentor)
    if new_mentor
      self.mentor_id = new_mentor.id
      self.lineage_id = new_mentor.lineage_id
      set_children
      self.save!
    end
  end

  # def lineage_id=(new_lineage_id)
  #   self.lineage_id = new_lineage_id
  #   save!
  #   self.mentees.each do |mentee|
  #     mentee.lineage_id = new_lineage_id if mentee.lineage_id != new_lineage_id
  #     mentee.save!
  #   end
  # end

  def set_children
    all_mentees = self.mentees
    new_mentees = all_mentees

    while new_mentees.length > 0
      to_add = []
      new_mentees.each do |new_mentee|
        to_add << new_mentee.mentees.to_a
      end
      new_mentees = to_add.flatten!
      all_mentees << to_add
    end

    all_mentees.each do |mentee|
      mentee.lineage_id = self.lineage_id
      mentee.save
    end
  end

  def set_profile_url
    hash = Digest::MD5.hexdigest(self.email)
    default = "&d=" + URI::encode('http://static.sepakbola.com/images/pemain/143823.jpg')
    self.profile_url = "http://www.gravatar.com/avatar/" + hash + "?s=200" + default
    self.save
  end
end
