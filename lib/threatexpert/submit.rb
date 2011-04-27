require 'net/http'
require 'net/http/post/multipart'
require 'uri'
require 'nokogiri'
require 'pp'

module ThreatExpert
	class Submit
		@@submiturl = "http://www.threatexpert.com/submit.aspx"

		def submit(filename, email, headers={})
			uri = URI.parse(@@submiturl)
			http = Net::HTTP.new(uri.host, uri.port)
			headers['User-Agent'] ||= "Ruby/#{RUBY_VERSION} threatexpert gem (https://github.com/chrislee35/threatexpert)"
			headers['Referer'] ||= @@submiturl
			resp, data = http.get(uri.path, headers)
			cookie = resp.header["set-cookie"] if resp.header["set-cookie"]
			
			doc = Nokogiri::HTML.parse(data)
			forms = doc.xpath('//form')
			inputs = forms[0].xpath('//input')
			params = {}
			inputs.each do |input|
				name = input['name']
				value = input['value']
				if name =~ /Agree/
					params[name] = 1
				elsif name =~ /Upload/
					file = File.open(filename)
					params[name] = UploadIO.new(file, "application/octet-stream", File.basename(filename))
				elsif name =~ /Email/
					params[name] = email
				elsif name =~ /btnSubmit/
					params[name+".x"] = rand(100)
					params[name+".y"] = rand(27)
				else
					params[name] = value
				end
			end
			
			headers['Referer'] = @@submiturl
			request = Net::HTTP::Post::Multipart.new(uri.path, params)
			headers.each do |name,value|
				request.add_field(name, value)
			end
			response = http.request(request)
			if response.body =~ /The file has been accepted/
				true
			else
				false
			end
		end
	end
end