require 'open-uri'
require 'nokogiri'

# This module exists for common web functionality
module Tapir
module Client
  module Web

    # This request should be used to make web requests
    def get_request(uri)
      begin

        # Request the data and return it
        doc = Nokogiri::HTML(open(uri, :allow_redirections => :safe))
        return doc.text
      #
      # Rescue in the case of a 404 or a redirect
      #  
      # TODO - this should really log into the task?
      rescue OpenURI::HTTPError => e 
        TapirLogger.instance.log "Error, couldn't open #{uri} with error #{e}"
      rescue Timeout::Error => e
        TapirLogger.instance.log "Timeout! #{e}"
      rescue OpenSSL::SSL::SSLError => e
        TapirLogger.instance.log "Unable to connect: #{e}"
      rescue Net::HTTPBadResponse => e
        TapirLogger.instance.log "Unable to connect: #{e}"
      rescue EOFError => e
        TapirLogger.instance.log "Unable to connect: #{e}"
      rescue SocketError => e
        TapirLogger.instance.log "Unable to connect: #{e}"
      rescue SystemCallError => e
        TapirLogger.instance.log "Unable to connect: #{e}"
      rescue ArgumentError => e
        TapirLogger.instance.log "Argument Error #{e}"
      rescue Encoding::InvalidByteSequenceError => e
        TapirLogger.instance.log "Encoding error: #{e}"
      rescue Encoding::UndefinedConversionError => e
        TapirLogger.instance.log "Encoding error: #{e}"
      #rescue RuntimeError => e
      #  TapirLogger.instance.log "Unknown Error: #{e}"
      end
    # Default to sending nothing 
    false
    end


    # This request should be used to make web requests
    def post_request(uri, params)
      begin
        
        # Request the data and return it
        doc = Nokogiri::HTML(open(uri, params.merge(:allow_redirections => :safe)))
        return doc.text
      #
      # Rescue in the case of a 404 or a redirect
      #  
      # TODO - this should really log into the task?
      rescue OpenURI::HTTPError => e 
        TapirLogger.instance.log "Error, couldn't open #{uri} with error #{e}"
      rescue Timeout::Error => e
        TapirLogger.instance.log "Timeout! #{e}"
      rescue OpenSSL::SSL::SSLError => e
        TapirLogger.instance.log "Unable to connect: #{e}"
      rescue Net::HTTPBadResponse => e
        TapirLogger.instance.log "Unable to connect: #{e}"
      rescue EOFError => e
        TapirLogger.instance.log "Unable to connect: #{e}"
      rescue SocketError => e
        TapirLogger.instance.log "Unable to connect: #{e}"
      rescue SystemCallError => e
        TapirLogger.instance.log "Unable to connect: #{e}"
      rescue ArgumentError => e
        TapirLogger.instance.log "Argument Error #{e}"
      rescue Encoding::InvalidByteSequenceError => e
        TapirLogger.instance.log "Encoding error: #{e}"
      rescue Encoding::UndefinedConversionError => e
        TapirLogger.instance.log "Encoding error: #{e}"
      #rescue RuntimeError => e
      #  TapirLogger.instance.log "Unknown Error: #{e}"
      end
    # Default to sending nothing 
    false
    end

  end
end
end