post '/tweets' do
  @user_id = session[:user_id]
  @content = params[:content]
  @tweet = Tweet.create(user_id: @user_id, content: @content)

  redirect "/users/#{@user_id}"
end

delete 'tweets/:tweet_id' do
  @tweet_id = params[:tweet_id]
  @tweet = Tweet.find(@tweet_id)
  @tweet.destroy

  @user_id  = session[:user_id]
  redirect "/users/#{@user_id}"
end
