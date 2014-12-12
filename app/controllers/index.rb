get '/' do
  erb :login
end

get '/user/:id' do
  @user = User.find(params[:id])
  @tweets = @user.tweets.reverse
  erb :'user/profile'
end

post '/tweet/new' do
  @tweet = Tweet.create!(content: params[:content], user_id: params[:id])
  redirect "/user/#{params[:id]}"
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
  @followers = User.find(params[:id]).followers
  erb :'user/followers'
end

get '/user/:id/following' do
  @following = User.find(params[:id]).following
  erb :'user/following'
end

get '/user/:id/timeline' do
  erb :timeline
end

delete '/tweet/:id' do
  @tweet = Tweet.find(params[:id]).destroy
  redirect ("user/#{@tweet.user_id}")
end

get '/tweet/:id/edit' do
  @tweet = Tweet.find(params[:id])
  erb :'tweet/edit'
end

put '/tweet/:id/edit' do
  @tweet_id = Tweet.find(params[:id])
  @tweet = Tweet.find(params[:id]).update(content: params[:new_content])
  redirect ("user/#{@tweet_id.user_id}")
end









