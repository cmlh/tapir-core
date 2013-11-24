# Rails Environment

require 'environment'
require 'test/unit'

class TestBingSearchService < Test::Unit::TestCase

  def test_bing_scrape_acme
    x = Client::Bing::SearchScraper.new
    results = x.search "acme"

    assert results.count == 5, "Wrong count, should be 5, is #{results.count} #{results}"
    
    assert results.first.include? "Wile E. Coyote"
    assert results.first.include? "Road Runner"

    assert !(results.last.include?("thisstringcouldnotbethere"))
  end


end
