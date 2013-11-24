module Tapir
module Client
module Twitter
  class WebClient
    include Client::Social

    attr_accessor :service_name

    def initialize
      @service_name = "twitter"
      @account_missing_strings = ["Sorry, that page"]
    end
    
    def web_account_uri_for(account_name)
      "https://twitter.com/#{account_name}"
    end

    def check_account_uri_for(account_name)
      "https://twitter.com/#{account_name}"
    end

  end

  class ApiClient

    def query(username)
      get_request "http://api.twitter.com/1/users/show/#{username}.json"
    end

  end

end
end
end