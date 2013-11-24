source 'http://rubygems.org'

gem 'sinatra'
gem 'sinatra-contrib'

gem 'snapi',  :path => "/Users/jcran/intrigue/projects/snapi", :branch => "arguments" #:git => 'git@github.com:pentestify/snapi.git', :branch => "arguments"

gem 'pry'

######################
#  Data manipulation #
######################
gem 'fastercsv'
gem 'librex'
gem 'nmap-parser'
gem 'json'

# Data Formats
gem 'exifr'

# Network Services
gem 'dnsruby'
gem 'geoip'
gem 'whois'
#gem 'packetfu'
#gem 'pcaprub'

# Web Servicess
gem 'linkedin'
gem 'flickr'
gem 'shodan'

# Web Spider
gem 'anemone'

# Scraping
gem 'mechanize'
gem 'nokogiri'
gem 'googleajax'
gem 'open_uri_redirections'

# Heavy-duty javascript scraping
gem 'selenium-webdriver' # browser based scraping with capybara
gem 'capybara'

# Infrastructure
gem 'fog'

#group :pain do
  # 
  # Capybara-Webkit requires QT-webkit
  #
  # The reason this gem is useful is for simple scraping of google. Several tasks 
  # use it to hit google. 
  #
  # https://github.com/thoughtbot/capybara-webkit#readme
  #
  # If you're on ubuntu, you'll need to run: 
  #   apt-get install libqt4-dev
  # Assuming you're on homebrew: 
  #   brew update
  #   brew install qt
  #gem 'capybara-webkit'
#end

group :test do
  # Pretty printed test output
  gem 'turn', '0.8.2', :require => false
  gem 'rspec'
end
