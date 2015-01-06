require 'faker'

cohorts = []
students = []

500.times do
  students << User.create(name: Faker::Name.name, email: Faker::Name.name)
end

12.times do
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