# Rails Environment
require 'environment'
require 'test/unit'

class TestFacebookWebClient < Test::Unit::TestCase

  def test_valid_account
    x = Client::Facebook::WebClient.new
    assert(x.check_account_exists("jonathan.cran"), "hmm, valid account didn't exist")
  end

  def test_invalid_account
    x = Client::Facebook::WebClient.new
    assert(!(x.check_account_exists "thiscouldnotpossiblyexist#{rand(100000000)}"),
           "Weird, invalid account appears to exist")
  end

end
