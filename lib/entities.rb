entities_dir = File.join(File.expand_path(File.dirname(__FILE__)), "entities")
Dir[entities_dir + "/" + "*.rb"].each do |file|
  require file
end

###
### This will serve as the definition of 
### our known types. For now... 
###
module Tapir
  module Entities

    class BaseEntity

      def initialize(attrs)
        @attrs = attrs
      end

      def name
        @attrs['name']
      end

      def to_json
        {:type => self.class, :attrs => @attrs}.to_json
      end

    end

    class Host < BaseEntity
    end

    class DnsRecord < BaseEntity
    end

    class WebApplication < BaseEntity
    end
  end
end