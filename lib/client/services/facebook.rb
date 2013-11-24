module Tapir
module Client
module Facebook
  
  class WebClient
    include Client::Social
    
    attr_accessor :service_name

    def initialize
      @service_name = "facebook"
      @account_missing_strings = ["The link you followed may be broken, or the page may have been removed",
                                  "Sorry, this page isn't available"]
    end

    def web_account_uri_for(account_name)
        "https://www.facebook.com/#{account_name}"
    end

    def check_account_uri_for(account_name)    
      "https://www.facebook.com/#{account_name}"
    end
    
  end
  
end
end
end