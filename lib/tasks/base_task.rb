module Tapir
module Tasks

  ### 
  ### All tasks inherit from BaseTask 
  ###
  class BaseTask
    def self.run(args)
      @result = Result.new
    end
  end

  ###
  ### All tasks will have a result object
  ###
  class Result
    def initialize 
      @result = {
        :entities => [], 
        :raw => ""
      }
    end

    def raw(output)
      @result[:raw] = output
    end

    def add_entity(type, attrs)
      @result[:entities] << { :type => type, :attrs => attrs }
    end

    def to_json(args={})
      @result.to_json
    end
  end

end
end