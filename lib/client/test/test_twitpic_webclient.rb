# Rails Environment
require 'environment'
require 'test/unit'

class TestTwitPicWebClient < Test::Unit::TestCase

  def test_valid_account
    x = Client::TwitPic::WebClient.new
    assert x.check_account_exists "jcran"
  end

  def test_invalid_account
    x = Client::TwitPic::WebClient.new
    assert !(x.check_account_exists "thiscouldnotpossiblyexist#{rand(10000)}")
  end

end
