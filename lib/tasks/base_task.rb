module Tapir
module Tasks

  ### 
  ### All tasks inherit from BaseTask 
  ###
  class BaseTask
    def self.run(args)
      @result = Result.new
      @result.log("Starting task run.")
    end
  end

  ###
  ### All tasks will have a result object
  ###
  class Result
    def initialize 
      @result = {
        :entities => [], 
        :raw => "",
        :log => ""
      }
    end

    def add_entity(type, attrs)
      @result[:entities] << { :type => type, :attrs => attrs }
    end

    def raw(output)
      @result[:raw] = output
    end

    def log(content,demeanor=:normal)
      case demeanor
        when :normal
          @result[:log] << "[_]" << content << "\n"
        when :good
          @result[:log] << "[+]" << content << "\n"
        when :error
          @result[:log] << "[-]" << content << "\n"
      end
    end

    def to_json(args={})
      @result.to_json
    end
  end

end
end