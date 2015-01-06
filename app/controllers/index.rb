get '/' do
  # @signup = false;
  @cohorts = Cohort.all
  erb :grid
end

get '/users/:id' do
  puts "TEST"
  user = User.find(params[:id])
  mentor =

  content_type :json
  user.to_json
end

get '/mentors/:id' do
  puts "TEST"
  user = User.find(params[:id])

  content_type :json
  user.mentor.to_json
end






