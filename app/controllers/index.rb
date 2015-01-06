get '/cohorts' do
  # @signup = false;
  @cohorts = Cohort.all
  erb :grid
end








