# Rails Environment
require 'environment'
require 'test/unit'

class TestTwitPicScraper < Test::Unit::TestCase

  def test_twitpic_search_jcran
    x = Client::TwitPic::TwitPicScraper.new
    results = x.search_by_user "jcran"
    assert results.count == 20, "Expected 20 results, got #{results.count}"

    results.each do |result|
      assert result.remote_path =~ /cloudfront/
    end

  end

end
