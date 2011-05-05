require 'rubygems'
require 'bundler'
begin
	Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
	$stderr.puts e.message
	$stderr.puts "Run `bundle install` to install missing gems"
	exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
	# gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
	gem.name = "threatexpert"
	gem.homepage = "http://github.com/chrislee35/threatexpert"
	gem.license = "MIT"
	gem.summary = %Q{Allows for malware name and md5 hash searching of, and malware submission to ThreatExpert.com.}
	gem.description = %Q{Provides a simple API to query ThreatExpert by malware name (to receive a list of matching hashes) or hash (to receive a malware report).  This also provides a simple upload feature.}
	gem.email = "rubygems@chrislee.dhs.org"
	gem.authors = ["Chris Lee"]
	gem.add_runtime_dependency "nokogiri", ">= 1.4.4"
	gem.add_runtime_dependency "multipart-post", ">= 1.1.0"
	gem.add_runtime_dependency "crack", ">= 0.1.8"
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
	test.libs << 'lib' << 'test'
	test.pattern = 'test/**/test_*.rb'
	test.verbose = true
end

require 'rcov/rcovtask'
Rcov::RcovTask.new do |test|
	test.libs << 'test'
	test.pattern = 'test/**/test_*.rb'
	test.verbose = true
end

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
	version = File.exist?('VERSION') ? File.read('VERSION') : ""

	rdoc.rdoc_dir = 'rdoc'
	rdoc.title = "threatexpert #{version}"
	rdoc.rdoc_files.include('README*')
	rdoc.rdoc_files.include('lib/**/*.rb')
end
