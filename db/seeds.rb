require 'faker'
require 'open-uri'
# require 'dbc-ruby'
require 'date'

def get_sample_cohorts
  DBC::Cohort.all.select{|cohort| cohort.location == 'San Francisco' && is_sample_cohort(cohort) }.sort_by{|cohort| Date.parse(cohort.start_date)}
end

def is_sample_cohort(cohort)
  Date.parse(cohort.start_date) > Date.parse("2013-10-01") &&
    Date.parse(cohort.start_date) < Date.parse("2015-1-31")
end

get_sample_cohorts.each do |cohort|
  new_cohort = Cohort.create(name: cohort.name, location: cohort.location, start_date: cohort.start_date)

  cohort.students.each do |student|
    new_user = User.create(name: student.name, email: student.email, hometown:student.profile[:hometown])
    new_cohort.users << new_user
    #puts student.name.to_s + student.email.to_s + student.profile[:hometown].to_s + student.profile[:current_location].to_s + student.profile[:about].to_s
  end
end

me = User.find_by(email: "szman86@gmail.com")
me.email = "szimmerman@alumni.purdue.edu"
me.save

cohorts = Cohort.all.sort_by {|cohort| cohort.start_date}

to_delete = ["2013 Melt",
"2014 Melt - SF",
"SF - On Hold",
"Staff Phase 0",
"Test cohort"]

to_delete.each do |name|
  cohort = Cohort.find_by(name: name)
  cohort.users.each do |user|
    user.destroy
  end
  cohort.destroy
end

cohorts.reverse.each_with_index do |cohort, i|
  if i < cohorts.length - 2
    student_sample = cohorts[i+1].users.shuffle
    student_sample.concat( cohorts[i+2].users.shuffle )

    cohort.users.each do |student|
      student.mentor = student_sample.pop
      student.save
    end
  end
end

__END__

cohorts = []
students = []

400.times do
  sex = ["men","women"].shuffle.first
  profile_img = "https://randomuser.me/api/portraits/" + sex.to_s + "/" + rand(96).to_s + ".jpg"
  students << User.new(name: Faker::Name.name, email: Faker::Internet.email, profile_url: profile_img.to_s)
end

graduation_date = Date.new(2015,1,9)
12.times do
  cohorts << Cohort.create(name: "The " + (Faker::App.name).pluralize, graduation_date: graduation_date)
  graduation_date -= 21
end

graduation_date = Date.new(2015,1,30) + 21
5.times do
  cohorts << Cohort.create(name: "The " + (Faker::App.name).pluralize, graduation_date: graduation_date)
  graduation_date += 21
end

students.each do |student|
  student.cohort = cohorts.sample
  # student.mentor = students.sample if rand(3) < 2
  student.save!
end

raccoon_cohort = Cohort.create(name: "The Racoons", graduation_date: Date.new(2015,1,30))
cohorts << raccoon_cohort

raccoons_students = [
{ name: "Steve Zimmerman", email: "szimmerman@alumni.purdue.edu" },
{ name: "Stephen Clem", email: "stevebclem@gmail.com" },
{ name: "Anna Wu", email: "shinshinwu@gmail.com" },
{ name: "Valerie Smith", email: "valeriesmithdbc@gmail.com" },
{ name: "Michelle Park", email: "mepark86@gmail.com" },
{ name: "Karen Lo", email: "just.karenlo@gmail.com" },
{ name: "Vincent Colavin", email: "vcolavin@gmail.com" },
{ name: "Kevin Maze", email: "rhoxiodbc@gmail.com" },
{ name: "Rich McCluskey", email: "rjmccluskey@gmail.com" },
{ name: "Tina Tien", email: "tinatien28@gmail.com" },
{ name: "Brittney Hodson", email: "thebriemarie@gmail.com" },
{ name: "Devin Liu", email: "devin.r.liu@gmail.com" },
{ name: "CJ Johnson", email: "vitamincjj@gmail.com" },
{ name: "Devon Estes", email: "devon.c.estes@gmail.com" },
{ name: "David Kim", email: "davidckim320@gmail.com" },
{ name: "Gaille Chua", email: "gvictachua@gmail.com" },
{ name: "Leonard Bui", email: "leonardbui@gmail.com" },
{ name: "Kevin Xu", email: "xuboxes@gmail.com" },
{ name: "CM Liotta", email: "cmliotta@msn.com" },
{ name: "Phil Riley", email: "hiriley510@gmail.com" },
{ name: "Amir Beheshtaein", email: "beheshtaein.a@gmail.com" },
{ name: "Mark Reid", email: "mark.francis.reid@gmail.com" },
{ name: "Mark Pfeffer", email: "pfeffer629@gmail.com" },
{ name: "Paul Yu", email: "paulyu292@gmail.com" },
{ name: "Anthony Ng", email: "thomsonng123@gmail.com" },
{ name: "Jesse Germinario", email: "jgerminario@gmail.com" },
{ name: "Juan Gomez", email: "j.gomez267@gmail.com" },
{ name: "Quynh Chen", email: "quynh.chen@gmail.com" },
{ name: "Alfred Calayag", email: "rapadura05@gmail.com" }]


def gravatar_image(email,size = 180)
  hash = Digest::MD5.hexdigest(email)
  default = "&d=" + URI::encode('http://www.crown-church.org.uk/images/member_photos/default_user.jpg')
  "http://www.gravatar.com/avatar/" + hash + "?s=#{size}" + default
end

raccoons_students.each do |raccoon_param|
  students << User.create(name: raccoon_param[:name], email: raccoon_param[:email], cohort: raccoon_cohort, profile_url: gravatar_image(raccoon_param[:email]))
end

cohorts = Cohort.all.sort_by {|cohort| cohort.graduation_date}.reverse
# puts "TESTTESTETTSGDJSHGKJFKJSHFKSHFKSJDFHHJ!!!!!!!!!!!!!!"

cohorts.each_with_index do |cohort, i|
  if i < cohorts.length - 1
    cohort.users.each do |student|
      student.mentees << cohorts[i+1].users.sample
      student.save
    end
  end
end


