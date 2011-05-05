require 'helper'
require 'pp'
class TestThreatexpert < Test::Unit::TestCase
	should "parse the page for 70cf23409191820593022ca797fbcbd0" do
		t = ThreatExpert::Search.new
		data = t.md5("70cf23409191820593022ca797fbcbd0")
		assert_not_nil(data)
		assert_equal("ThreatExpert Report", data['report']['title'])
		assert_not_nil(data['report']['subreports'])
		assert_not_nil(data['report']['subreports']['subreport'])
		assert_not_nil(data['report']['subreports']['subreport']['technical_details'])
		assert_not_nil(data['report']['subreports']['subreport']['technical_details']['known_threat_category_collection'])
		assert_not_nil(data['report']['subreports']['subreport']['technical_details']['known_threat_category_collection']['known_threat_category'])
		assert_not_nil(data['report']['subreports']['subreport']['technical_details']['known_threat_category_collection']['known_threat_category'][0])
		assert_equal("Backdoor", data['report']['subreports']['subreport']['technical_details']['known_threat_category_collection']['known_threat_category'][0]['name'])
	end
	
	should "return nil for 70cf23409191820593022ca797fbcbd1" do
		t = ThreatExpert::Search.new
		html = t.md5("70cf23409191820593022ca797fbcbd1")
		assert_nil(html)
	end
	
	should "parse the list for Worm.Hamweg.Gen" do
		t = ThreatExpert::Search.new
		hashes = t.name("Worm.Hamweg.Gen")
		assert_equal(159, hashes.length)
	end

	should "return no results for Worm.Hamwex.Gen" do
		t = ThreatExpert::Search.new
		hashes = t.name("Worm.Hamwex.Gen")
		assert_equal(0, hashes.length)
	end
end
