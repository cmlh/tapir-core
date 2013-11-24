module Tapir
module Client
module Rapportive
  class ApiClient
    include Client::Web

    attr_accessor :service_name
    
    def initialize
      @service_name = "rapportive"  
    end

    # This makes a search against the rapportive API. Note that
    # a new session token is currently requested for every call
    def search(email_address)
      # Make the call to rapportive, w/ the session token      
      response = post_request(
        "https://profiles.rapportive.com/contacts/email/#{email_address}",
        {"X-Session-Token" => _session_token } )

      parsed_response = JSON.parse(response) if response
    parsed_response
    end

    private

    # Return a session token that can be used to query rapportive. 
    # see: http://jordan-wright.github.io/blog/2013/10/14/automated-social-engineering-recon-using-rapportive/
    def _session_token

      response = get_request "http://rapportive.com/login_status?user_email=this_doesnt_exist_@gmail.com"
      session_token = JSON.parse(response)['session_token'] if response
    session_token
    end

  end
end
end
end