require 'faker'

cohorts = []
students = []

500.times do
  sex = ["men","women"].shuffle.first
  profile_img = "https://randomuser.me/api/portraits/" + sex.to_s + "/" + rand(96).to_s + ".jpg"
  students << User.new(name: Faker::Name.name, email: Faker::Internet.email, city: Faker::Address.city, profile_image: profile_img.to_s)
end

students << User.create(name: "Steve Zimmerman", email: "szman86@gmail.com")

15.times do
  cohorts << Cohort.create(name: Faker::App.name)
end

students.each do |student|
  student.cohort = cohorts.sample
  # student.mentor = students.sample if rand(3) < 2
  student.save!
end

students = User.all
cohorts = Cohort.all
# puts "TESTTESTETTSGDJSHGKJFKJSHFKSHFKSJDFHHJ!!!!!!!!!!!!!!"

cohorts.each_with_index do |cohort, i|
  if i < cohorts.length - 1
    cohort.users.each do |student|
      student.mentor = cohorts[i+1].users.sample
      student.save!
    end
  end
end
