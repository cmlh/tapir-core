# Rails Environment
require 'environment'
require 'test/unit'

class TestMyspaceWebClient < Test::Unit::TestCase

  def test_valid_account
    x = Client::Myspace::WebClient.new
    assert(x.check_account_exists("justinbieber"), "valid account didn't exist")
  end

  def test_invalid_account
    x = Client::Myspace::WebClient.new
    assert(!(x.check_account_exists "thiscouldnotpossiblyexist#{rand(10000)}"),"invalid account was found")
  end

end
