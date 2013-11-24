module Tapir
  module Tasks

    class CreateNoteTask < BaseTask
      
      # Public: run  
      #   Every task has a run method which returns a TaskResult
      #
      # args: a hash of arguments, as defined in the cooresponding class 
      #
      # Returns a json hash
      def self.run(args)
        super # always call super
      
        # This will add an entity to the result
        @result.add_entity( "Entities::Note", { :content => args[:content]} )

        # TODO - Note that this can lead to XSS and you should never trust user input!
        @result.raw("Stored content: #{args[:content]}")
        

      return @result # always return the result
      end # end run 

    end # end CreateNoteTask

    class CreateNote
      include Snapi::Capability
      function :run do |fn|
        fn.argument :content do |arg|
          arg.type :string
          arg.required true
        end
        fn.return :structured
      end

      library Tapir::Tasks::CreateNoteTask 
    end # end CreateNote

  end # end Tasks
end # end Tapir