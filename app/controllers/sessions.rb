get '/login' do
  p params[:state]
  p params[:code]

  if params[:state] == "DCEEFWF45453sdffef424"

    code = params[:code]
    client_id = ENV['API_KEY']
    secret_key = ENV['SECRET_KEY']
    redirect_url = "http://localhost:9393/login-redirect-auth"

    url = "https://www.linkedin.com/uas/oauth2/accessToken?grant_type=authorization_code&code=#{code}&redirect_uri=#{redirect_url}&client_id=#{client_id}&client_secret=#{secret_key}"

    response = HTTParty.post(url).parsed_response
    p response

    redirect '/'
  end


  erb :login
end

get '/login-redirect' do

  client_id = ENV['API_KEY']
  scope = "r_fullprofile%20r_emailaddress%20r_basicprofile%20r_contactinfo"
  state = "DCEEFWF45453sdffef424"
  redirect_url = "http://localhost:9393/login-redirect-auth"

  redirect "https://www.linkedin.com/uas/oauth2/authorization?response_type=code&client_id=#{client_id}&scope=#{scope}&state=#{state}&redirect_uri=#{redirect_url}"

end

get '/login-redirect-auth' do
  params["code"]
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
