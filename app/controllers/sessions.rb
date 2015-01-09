get '/login' do
  redirect '/' if authorized?

  erb :login
end

get '/login-redirect' do

  client_id = ENV['LINKEDIN_KEY']
  scope = "r_fullprofile%20r_emailaddress"
  state = "DCEEFWF45453sdffef424"
  redirect_url = "http://localhost:9393/login-redirect-auth"

  redirect "https://www.linkedin.com/uas/oauth2/authorization?response_type=code&client_id=#{client_id}&scope=#{scope}&state=#{state}&redirect_uri=#{redirect_url}"

end

get '/login-redirect-auth' do
  params
end

get '/logout' do
  logout
  redirect '/login'
end

# post '/signup' do

#   begin
#     new_user = User.new(username: params[:username], email: params[:email])
#     new_user.password = params[:password]
#     new_user.save!
#   rescue => error
#   end

#   if error
#     flash[:signup_notice] = "#{error.to_s.sub('Validation failed: ','').sub(',',' and')}"
#     redirect_home
#   else
#     login(new_user)
#     redirect_home
#   end
# end
