require 'open-uri'

module Tapir
  module Tasks

    class BuiltWithTask < BaseTask
      
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

        ##### NEVER NEVER NEVER ALLOW THIS IN PRODUCTION CODE #####
        x = JSON.load "{\"type\":\"Tapir::Entities::Host\",\"attrs\":{\"name\":\"1.1.1.1\"}}"
        entity = eval(x['type']).new(x['attrs'])
        puts x.inspect
        ###########################################################

        if entity.kind_of? Tapir::Entities::Host
          url = "http://#{entity.name}"
        elsif entity.kind_of? Tapir::Entities::DnsRecord
          url = "http://#{entity.name}"
        else
          url = "#{entity.name}"
        end

        @result.log "Connecting to #{url} for #{entity}" 

        begin

          status = Timeout.timeout(30) do
            # Prevent encoding errors
            contents = open("#{url}").read #, :allow_redirections => :safe).read #.force_encoding('UTF-8')

            contents.encode!('UTF-8', 'UTF-8', :invalid => :replace)

            target_strings = [

              ### Marketing / Tracking
              {:regex => /urchin.js/, :finding => "Google Analytics"},
              {:regex => /optimizely/, :finding => "Optimizely"},
              {:regex => /trackalyze/, :finding => "Trackalyze"},
              {:regex => /doubleclick.net|googleadservices/, :finding => "Google Ads"},
              {:regex => /munchkin.js/, :finding => "Marketo"},
              {:regex => /Olark live chat software/, :finding => "Olark"},

              ### External accounts
              {:regex => /http:\/\/www.twitter.com\/.*?/, :finding => "Twitter Account"},
              {:regex => /http:\/\/www.facebook.com\/.*?/, :finding => "Facebook Account"},

              ### Technologies
              #{:regex => /javascript/, :finding => "Javascript"},
              {:regex => /jquery.js/, :finding => "JQuery"},
              {:regex => /bootstrap.css/, :finding => "Twitter Bootstrap"},

              ### Platform
              {:regex => /[W|w]ordpress/, :finding => "Wordpress"},
              {:regex => /[D|d]rupal/, :finding => "Drupal"},

              ### Provider
              {:regex => /Content Delivery Network via Amazon Web Services/, :finding => "Amazon Cloudfront"},

              ### Wordpress Plugins
              { :regex => /wp-content\/plugins\/.*?\//, :finding => "Wordpress Plugin"},
              { :regex => /xmlrpc.php/, :finding => "Wordpress API"},
              #{:regex => /Yoast WordPress SEO plugin/, :finding => "Yoast Wordress SEO Plugin"},
              #{:regex => /PowerPressPlayer/, :finding => "Powerpress Wordpress Plugin"},
            ]

            target_strings.each do |target|
              matches = contents.scan(target[:regex]) #.map{Regexp.last_match}
              matches.each do |match|
                @result.add_entity(Entities::Finding,
                  { :name => "#{entity.name} - #{target[:finding]}",
                    :content => "Found #{match} on #{entity.name}",
                    :details => contents 
                  })
              end if matches
            end
          end

        rescue Timeout::Error => e
          @result.log "Timeout!", :error
        rescue OpenSSL::SSL::SSLError => e
          @result.log "Unable to connect: #{e}", :error
        rescue OpenURI::HTTPError => e
          @result.log "Unable to connect: #{e}", :error
        rescue Net::HTTPBadResponse => e
          @result.log "Unable to connect: #{e}", :error
        rescue EOFError => e
          @result.log "Unable to connect: #{e}", :error
        rescue SocketError => e
          @result.log "Unable to connect: #{e}", :error
        rescue RuntimeError => e
          @result.log "Unable to connect: #{e}", :error
        rescue SystemCallError => e
          @result.log "Unable to connect: #{e}", :error
        rescue ArgumentError => e
          @result.log "Argument Error #{e}", :error
        rescue Encoding::InvalidByteSequenceError => e
          @result.log "Encoding error: #{e}", :error
        rescue Encoding::UndefinedConversionError => e
          @result.log "Encoding error: #{e}", :error
        end

        # More logging...
        @result.log("All done with task run.", :good)

      return @result # always return the result

      end # end run
    end # end BuiltWithTask

    class BuiltWith
      include Snapi::Capability
      function :run do |fn|
        fn.argument :entity do |arg|
          arg.type :string
          arg.required true
        end
        fn.return :structured
      end

      library Tapir::Tasks::BuiltWithTask 
    end # end BuiltWith

  end # end Tasks
end # end Tapir