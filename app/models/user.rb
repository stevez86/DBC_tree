class User < ActiveRecord::Base

  include BCrypt

  belongs_to :cohort

  has_many :mentees, class_name: "User", foreign_key: "mentor_id"
  belongs_to :mentor, class_name: "User", inverse_of: :mentees

  # validates :email, uniqueness: true
  # validates :password, :email, presence: true

  after_initialize :defaults

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
    self.mentor_id = new_mentor.id
    self.lineage_id = new_mentor.lineage_id
    set_lineage
    self.save!
  end

  def set_lineage
    # User.reload
    all_mentees = self.mentees
    new_mentees = all_mentees
    puts "SELF: #{self.name}, #{self.id}"

    puts new_mentees.length

    while new_mentees.length > 0
      to_add = []
      new_mentees.each do |new_mentee|
        puts "NEW MENTEE: #{new_mentee.name}, #{new_mentee.id}"
        all_mentees << new_mentee
        to_add << new_mentee.mentees.to_a
      end
      new_mentees = to_add.flatten
      all_mentees << to_add.flatten




    end

    all_mentees.each do |mentee|
      mentee.lineage_id = self.lineage_id
      mentee.save!
    end
  end

  def graduation_date
    # TODO
  end
end
