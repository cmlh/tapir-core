# Rails Environment
require 'environment'
require 'test/unit'

class TestCorpwatchService < Test::Unit::TestCase
  
  def test_corpwatch_search_acme
    x = Client::Corpwatch::CorpwatchService.new
    corps = x.search "acme"
    assert corps.count == 73, "Wrong count, should be 61, is #{corps.count}"
    assert corps.first.company_name == "ACME Aerospace Inc", "Failed: #{corps[0].company_name} was not ACME COMMUNICATIONS INC"
  end

  def test_corpwatch_search_rapid7
    x = Client::Corpwatch::CorpwatchService.new
    corps = x.search "rapid7"    
    assert corps.count == 2, "Wrong count, should be 1, is #{corps.count}"
    assert corps.first.company_name == "Rapid7 Inc", "Failed: #{corps[0].company_name} was not Rapid7 LLC"
  end

  def test_corpwatch_search_tenable
    x = Client::Corpwatch::CorpwatchService.new
    corps = x.search "tenable"
    assert corps.count == 1, "Wrong count, should be 1, is #{corps.count}"
    assert corps.first.company_name == "TENABLE NETWORK SECURITY INC", "Failed: #{corps[0].company_name} was not TENABLE NETWORK SECURITY INC"
  end

end