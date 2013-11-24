#!/usr/bin/env ruby

###
### Gem Dependencies
###
require 'rubygems'
require 'sinatra'
require 'sinatra/contrib'
require 'snapi'

###
### Tapir-Specific Dependencies
###
$:.unshift(File.join(File.expand_path(File.dirname(__FILE__))))
#require 'lib/core'
require 'lib/tasks'
require 'lib/client'
require 'lib/entities'

class TapirWeb < Sinatra::Base
  register Sinatra::Namespace

  get '/' do
    "Hey it works!"
  end

  get '/admin' do
    redirect 'http://www.youtube.com/watch?v=StChuTW268k'
  end

  namespace Snapi.capability_root do
    register Snapi::SinatraExtension
  end

  run! if app_file == $0
end