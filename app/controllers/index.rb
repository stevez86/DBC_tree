get '/' do
  if !authorized?
    redirect '/login'
  end

  @current_user = User.find(session[:user_id])
  # @current_user_cohort = @current_user.cohort
  @cohorts = Cohort.all.sort_by {|cohort| cohort.graduation_date}
  erb :grid
end

get '/users/current_user' do
  if session[:user_id]
    current_user = User.find(session[:user_id])
    content_type :json
    current_user.to_json
  end
end

get '/users/:id' do

  user = User.find(params[:id])

  user_xfer = {
    mentor_id: user.mentor_id,
    mentor_name: user.mentor.name,
    cohort: user.cohort.name
  }
  # user_xfer[:mentor_id] = user.mentor_id
  # user_xfer[:mentor_name] = user.mentor.name
  # user_xfer[:cohort] = user.cohort.name

  if user.liprofile
    user_xfer[:location] = user.liprofile.location
    user_xfer[:headline] = user.liprofile.headline
  end

  puts "XFER"
  ap user_xfer

  content_type :json
  user_xfer.to_json
end

get '/users/:id/mentor' do
  user = User.find(params[:id])

  content_type :json
  user.mentor.to_json
end








