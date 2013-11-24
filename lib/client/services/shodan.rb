require 'shodan'

module Tapir
module Client
module Shodan
  class ApiClient
    include Client::Web

    attr_accessor :service_name
    
    def initialize
      @service_name = "shodan"
      @api = ::Shodan::WebAPI.new(_api_key)
    end

    def search(search_string)
      begin
        response = @api.search(search_string)
      rescue Timeout::Error => e
        response = nil
      rescue JSON::ParserError => e
        # Unable to parse, likely we have the wrong key. return false. 
        response = nil
      end
    response
    end

    private

    def _api_key 
      Setting.where({:name=>"shodan_api"}).first.value 
    end

  end
end
end
end