require 'nokogiri'
require 'open-uri'

module ThreatExpert
	class Search
		@@baseurl = 'http://www.threatexpert.com'
		def initialize
		end
		
		def md5(hash)
			url = @@baseurl+"/report.aspx?md5=#{hash}"
			_parse_report(url)
		end
		
		def name(mwname)
			url = @@baseurl+"/reports.aspx?find=#{mwname}"
			_parse_list(url)
		end
		
		def _parse_list(nextpage)
			hashes = []
			while nextpage
				page = open(nextpage).read
				nextpage = nil
				n = Nokogiri::HTML.parse(page)
				n.xpath('//a').each do |a|
					if a['href'] =~ /report\.aspx\?md5=([0-9a-fA-F]{32,128})/
						hashes << $1
					elsif a.text == 'Next'
						nextpage = "http://www.threatexpert.com/"+a['href']
					end
				end
			end
			hashes
		end
		
		def _parse_report(page)
			page = open(page).read
			return nil unless page =~ /Submission Summary:/
			n = Nokogiri::HTML.parse(page)
			ul = n.xpath('//ul')
			t = ul.to_s.gsub(/<img.*?>/,'')
		end
	end
end
