require 'rubygems'
require 'sinatra'
require 'sinatra/contrib'
require 'snapi'

module Tasks
  class ExampleTask
    def self.run(args={})
      "just an example."
    end
  end

  class Example
    include Snapi::Capability

    function :run do |fn|
      fn.argument :blah do |arg|
        arg.required false
        arg.type :string
      end

      fn.return :structured
    end

    library ExampleTask
  end
end

class Tapir < Sinatra::Base
  register Sinatra::Namespace

  get '/' do
    redirect 'http://www.youtube.com/watch?v=StChuTW268k'
  end

  namespace Snapi.capability_root do
    register Snapi::SinatraExtension
  end

  run! if app_file == $0
end
