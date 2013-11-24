module Tapir
module Client
module Pipl
  class ApiClient
    include Client::Web

    attr_accessor :service_name
    
    def initialize
      @service_name = "pipl"  
    end

    def search(search_type, email)
      begin
        search_uri = _get_uri(search_type, email)
        response = get_request(search_uri)
        JSON.parse response if response
      rescue URI::InvalidURIError
        return response['error'] => "Error using search uri: #{search_uri}"
      rescue JSON::ParserError
        return response['error'] => "Invalid JSON returned: #{response}"
      end
    end

    private

    def _get_uri(type, key)
      if type == :email
        "http://api.pipl.com/search/v3/json/?email=#{key}&exact_name=0&query_params_mode=and&key=#{_api_key}"
      elsif type == :phone
        "http://api.pipl.com/search/v3/json/?phone=#{key}&exact_name=0&query_params_mode=and&key=#{_api_key}"
      elsif type == :username
        "http://api.pipl.com/search/v3/json/?username=#{key}&exact_name=0&query_params_mode=and&key=#{_api_key}"
      else
        raise "Unknown search type"
      end
    end

    def _api_key 
      Setting.where({:name=>"pipl_api"}).first.value 
    end

  end
end
end
end