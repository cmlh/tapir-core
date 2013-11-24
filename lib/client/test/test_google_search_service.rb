# Rails Environment
require 'environment'
require 'test/unit'

class TestGoogleSearchService < Test::Unit::TestCase

  def test_google_search_acme
    x = Client::Google::SearchService.new
    results = x.search "acme"
    assert results.count == 4, "Wrong count, should be 4, is #{results.count}"
  end

  def test_google_search_test
    x = Client::Google::SearchService.new
    results = x.search "test"
    assert results.count == 4, "Wrong count, should be 4, is #{results.count}"
  end

end
