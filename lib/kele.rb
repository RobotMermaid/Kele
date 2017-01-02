require "httparty"

class Kele
  #include HTTParty

  def initialize(email, password)
      @url= 'https://www.bloc.io/api/v1/sessions'

      response = HTTParty.post(@url,
         :query => { :email => email, :password => password })
      puts response

      raise "invalid email/pass, bud" if response.code != 200

  end
end
