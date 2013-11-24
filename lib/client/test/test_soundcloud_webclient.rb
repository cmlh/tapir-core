# Rails Environment
require 'environment'
require 'test/unit'

class TestSoundCloudWebClient < Test::Unit::TestCase

  def test_valid_account
    x = Client::SoundCloud::WebClient.new
    assert x.check_account_exists "justinbieber"
  end

  def test_invalid_account
    x = Client::SoundCloud::WebClient.new
    assert !(x.check_account_exists "thiscouldnotpossiblyexistdammit")
  end

end
