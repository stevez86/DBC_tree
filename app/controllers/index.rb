get '/' do
  @current_user = User.find_by(email: "szman86@gmail.com")
  login(@current_user)
  @current_user_cohort = @current_user.cohort
  @cohorts = Cohort.all.sort_by {|cohort| cohort.graduation_date}
  erb :grid
end

get '/users/:id' do
  user = User.find(params[:id])

  content_type :json
  user.to_json
end

get '/users/:id/mentor' do
  user = User.find(params[:id])

  content_type :json
  user.mentor.to_json
end

get '/current_user' do
  @current_user = User.find_by(email: "szman86@gmail.com")
  content_type :json
  @current_user.to_json
end






