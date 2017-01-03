require 'httparty'
require 'json'

class Kele
  include HTTParty
  base_uri 'https://www.bloc.io/api/v1'

  def initialize(email, password)
      response = self.class.post('/sessions',
         :query => { :email => email, :password => password })
      #puts response
      @auth_token = response["auth_token"]
      raise "this is an invalid email/password" if response.code != 200
  end

   def get_me
      url= 'https://www.bloc.io/api/v1/users/me'
      response = self.class.get(url, headers: { "authorization" => @auth_token })
      #puts response["bio"]
      JSON.parse(response.body)
      #puts JSON.pretty_generate(response)
   end
end
