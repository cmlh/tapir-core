module Tapir
module Client
module YFrog
  class WebClient
    include Client::Social

    attr_accessor :service_name
    
    def initialize
      @service_name = "yfrog"
      @account_missing_strings = ["Something went wrong"]
    end
    
    def web_account_uri_for(account_name)    
      "https://yfrog.com/user/#{account_name}/profile"
    end
    
    def check_account_uri_for(account_name)    
      "https://yfrog.com/user/#{account_name}/profile"
    end
    
  end
end
end
end