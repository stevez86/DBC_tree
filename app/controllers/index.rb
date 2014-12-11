get '/' do
  erb :login
end

get '/user/:id' do
  @user = User.find(id)
  @tweets = @user.tweets
  erb :'user/profile'
end

post '/user/:id' do
  @tweet = Tweet.create!(params)
  redirect "/user/#{@user.id}"
end

delete '/user/:id' do
  @exploded_tweet = Tweet.destroy()
  redirect "/user/#{@user.id}"
end

get '/user/:id/edit' do
  erb :'user/edit'
end

post '/user/:id/edit' do
  @edited_user = User.update(params[:user])
  redirect "/user/#{@edited_user.id}"
end

get '/user/:id/followers' do
  erb :'user/followers'
end

get '/user/:id/following' do
  erb :'user/following'
end

get '/user/:id/timeline' do
  erb :timeline
end

delete 'tweet/:id' do
  redirect ("user/#{tweet.user_id}")
end

get 'tweet/:id/edit' do
  erb :'tweet/edit'
end

put 'tweet/:id/edit' do
  redirect ("user/#{tweet.user_id}")
end









