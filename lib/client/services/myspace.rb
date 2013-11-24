module Tapir
module Client
module Myspace
  class WebClient
    include Client::Social

    attr_accessor :service_name

    def initialize
      @service_name = "myspace"
      @account_missing_strings =["we can't find the page you're looking for."]
    end
    
    def web_account_uri_for(account_name)
      "https://myspace.com/#{account_name}"
    end
    
    def check_account_uri_for(account_name)
      "https://myspace.com/#{account_name}"
    end
  
  end
end
end
end