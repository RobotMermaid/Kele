require 'httparty'
require 'json'
require_relative 'kele/roadmap'

class Kele
  include HTTParty
  include Roadmap

  base_uri 'https://www.bloc.io/api/v1'

  def initialize(email, password)
      response = self.class.post('/sessions',
         :query => { :email => email, :password => password })
      #puts response
      @auth_token = response["auth_token"]
      raise "this is an invalid email/password" if response.code != 200
  end

   def get_me
      #url= 'https://www.bloc.io/api/v1/users/me'
      response = self.class.get('/users/me',
      headers: { "authorization" => @auth_token })
      #puts response["bio"]
      JSON.parse(response.body)
      #puts JSON.pretty_generate(response)
   end

   def get_mentor_availability(mentor_id)
     response = self.class.get("/mentors/#{mentor_id}/student_availability",
     headers: { "authorization" => @auth_token })
     JSON.parse(response.body)
   end

   def get_messages
     response = self.class.get('/message_threads',
     headers: { "authorization" => @auth_token })
     JSON.parse(response.body)
   end

   def create_message(sender, recipient_id, token, subject, stripped_text)
     response = self.class.post('/messages',
     headers: { "authorization" => @auth_token },
     body: {
             "sender"=> sender,
             "recipient_id"=> recipient_id,
             "token"=> token,
             "subject"=> subject,
             "stripped-text"=> stripped_text})
    # result shows up at https://www.bloc.io/api/v1/message_threads
     #puts response.body
     #JSON.parse(response.body)
     #response
   end
   
end
