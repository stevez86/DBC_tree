require 'faker'

cohorts = []
students = []

50.times do
  students << User.create(name: Faker::Name.name)
end

5.times do
  cohorts << Cohort.create(name: Faker::App.name)
end

students.each do |student|
  student.cohort = cohorts.sample
  # student.mentor = students.sample if rand(3) < 2
  student.save!
end

students = User.all
cohorts = Cohort.all
puts "TESTTESTETTSGDJSHGKJFKJSHFKSHFKSJDFHHJ!!!!!!!!!!!!!!"

cohorts.each_with_index do |cohort, i|
  if i < cohorts.length - 1
    cohort.users.each do |student|
      student.mentor = cohorts[i+1].users.sample
      student.save!
    end
  end
end

# students = User.all

# students.each do |student|
#   highest_mentor = student

#   while highest_mentor.mentor != nil
#     puts highest_mentor.mentor
#     highest_mentor = highest_mentor.mentor
#   end

#   student.lineage_id = highest_mentor.id
#   student.save!
# end