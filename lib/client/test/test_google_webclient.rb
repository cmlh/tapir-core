# Rails Environment
require 'environment'
require 'test/unit'

class TestGoogleWebClient < Test::Unit::TestCase

  def test_valid_account
    x = Client::Google::WebClient.new
    assert(x.check_account_exists("jrcran"), "hmm, valid account didn't exist")
  end

  def test_invalid_account
    x = Client::Google::WebClient.new
    assert(!(x.check_account_exists "thiscouldnotpossiblyexist#{rand(10000000)}"), "Weird, invalid account appears to exist")
  end

end
