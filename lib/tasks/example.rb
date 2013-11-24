module Tapir
  module Tasks

    class ExampleTask < BaseTask
      
      # Public: run  
      #   Every task has a run method which returns a TaskResult
      #
      # args: a hash of arguments, as defined in the cooresponding class 
      #
      # Returns a json hash
      def self.run(args)
        super # always call super
      
        # This will add an entity to the result
        @result.log("Performing task.")

        #@result.log("Creating an entity.")
        #@result.add_entity( "Entities::TestEntity", { :test_attribute => "test"} )

        # This will set the raw task output and echo the parameter specified by 'echo' 
        # TODO - Note that this can lead to XSS and you should never trust user input!        
        @result.raw("Hey it's a test of raw output: #{args[:echo]}")

        # More logging...
        @result.log("All done with task run.", :good)

      return @result # always return the result

      end # end run
    end # end ExampleTask

    class Example
      include Snapi::Capability
      function :run do |fn|
        fn.argument :echo do |arg|
          arg.type :string
          arg.required false
        end
        fn.return :structured
      end

      library Tapir::Tasks::ExampleTask 
    end # end Example

  end # end Tasks
end # end Tapir