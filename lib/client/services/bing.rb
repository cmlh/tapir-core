module Tapir
module Client
module Bing
  
  class SearchScraper

    def search(search_string,pages=5)
      first_item = 1
      responses = []

      pages.times do |x|
        uri = URI.parse("http://www.bing.com/search?q=#{search_string}&first=#{first_item}")
        begin
          response = Net::HTTP.get_response(uri)
          responses << response.body
        rescue Exception => e
          # Just silently catch them for now
        end
        # iterate through results
        first_item += 10
      end
    responses
    end

  end


  # This class wraps the Bing API
  class SearchService

    # 
    # Takes: a search string
    # 
    # Ruturns: An array of search results 
    #
    def search(search_string)

      # Convert to a get-paramenter
      search_string = CGI.escapeHTML search_string
      search_string.gsub!(" ", "&nbsp;")
    
      results = []

      api_path = "http://api.bing.net/xml.aspx"
      search_data = "?AppId=#{Setting.where({:name => 'bing_api_key'}).first.value}" +
        "?Query=#{search_string}&Sources=Web&Version=2.0&Market=en-us&" +
        "Adult=Moderate&Options=EnableHighlighting&Web.Count=50&Web.Offset=0" + 
        "&Web.Options=DisableQueryAlterations"
      
      request_uri = "#{api_path}#{search_data}"
      
      # Open page & parse
      request_options = {"User-Agent" => "Intrigue.io", "Referer" => "http://www.intrigue.io"}
      doc = Nokogiri::XML(open(request_uri, request_options)) do |config|
          config.noblanks
      end

      # Check for successful result
      return false unless doc

      #each result, create a SearchResult
      result_xml = doc.xpath("//web:Results", 
       "web" => "http://schemas.microsoft.com/LiveSearch/2008/04/XML/web")
      result_xml.children.each do |child|
        x = SearchResult.new
        x.parse_xml(child)
        results << x
      end

    results
    end
  end

  # This class represents a corporation as returned by the Corpwatch service. 
  class SearchResult

    attr_accessor :title
    attr_accessor :description
    attr_accessor :url
    attr_accessor :display_url
    attr_accessor :date_time

    def initialize
    end

    # 
    #  Takes: A search result
    #
    #  Returns: Nothing
    #
    def parse_xml(result)
      #puts "getting title #{result['title']}"
      @title = result['title']
      @description = result['description']
      @url = result['url']
      @display_url = result['display_url']
      @date_time = result['date_time']
    end
  
    def to_s
      "#{@title} #{@description} #{@url} #{@date_time}"
    end

  end

end
end
end