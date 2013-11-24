module Tapir
module Client
module Corpwatch

  # This class wraps the corpwatch Api
  class CorpwatchService

    # 
    # Takes: Nothing
    # 
    # Ruturns: An array of corpwatch corps from the search 
    #
    def search(search_string)
      # Convert to a get-paramenter
      search_string = CGI.escapeHTML search_string.strip
      search_string.gsub!(" ", "%20")
    
      # initialize an array of corps to return 
      corps = []

      begin
        search_uri = get_service_endpoint(search_string)
        # Open page & parse
        doc = Nokogiri::XML(open(search_uri, {"User-Agent" => "tapir"}))
        
        # Check the doc metadata
        metadata = {}
        doc.xpath("/corpwatch/meta").map do |m|
          metadata = {"status" => m.xpath("status").text, "total_results" => m.xpath("total_results").text.to_i}
        end

        # Check for successful result
        return false unless metadata["status"].to_i == 200

        # For each result, create a corp
        doc.xpath("/corpwatch/result/companies").children.each do |child|
          x = Corpwatch::Corporation.new
          x.parse_xml(child)
          corps << x
        end
        
      end
    corps
    end

    def get_service_endpoint(company_name)
      key = Setting.where(:name => "corpwatch_api").first.value
    "http://api.corpwatch.org/companies.xml?company_name=#{company_name}&key=#{key}"
    end
  end

  # This class represents a corporation as returned by the Corpwatch service. 
  class Corporation
    attr_accessor :raw_xml
    attr_accessor :cw_id
    attr_accessor :cik
    attr_accessor :name
    attr_accessor :irs_number
    attr_accessor :sic_code
    attr_accessor :industry_name
    attr_accessor :sic_sector
    attr_accessor :sector_name
    attr_accessor :source_type
    attr_accessor :address
    attr_accessor :country
    attr_accessor :state
    attr_accessor :top_parent_id
    attr_accessor :num_parents
    attr_accessor :num_children
    attr_accessor :max_year
    attr_accessor :min_year

    # 
    #  Takes: An xml doc representing a corpwatch corporation
    #
    #  Returns: Nothing
    #
    def parse_xml(xml_doc)
      @raw_xml = xml_doc
    
      @raw_xml.xpath(".").map do |x|
        @cw_id = x.xpath("cw_id").text
        @cik = x.xpath("cik").text
        @name = x.xpath("company_name").text
        @irs_number = x.xpath("irs_number").text
        @sic_code = x.xpath("sic_code").text
        @industry = x.xpath("industry_name").text
        @sic_sector = x.xpath("sic_sector").text
        @sector_name = x.xpath("sector_name").text
        @source_type = x.xpath("source_type").text
        @address = x.xpath("raw_address").text
        @country = x.xpath("country_code").text
        @state = x.xpath("subdiv_code").text
        @top_parent_id = x.xpath("top_parent_id").text
        @num_parents = x.xpath("num_parents").text
        @num_children = x.xpath("num_children").text
        @max_year = x.xpath("max_year").text
        @min_year = x.xpath("min_year").text
      end
    end

    def to_s
      "#{@company_name}: #{@address} #{@state} #{@country}"
    end

  end
end
end
end