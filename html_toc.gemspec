Gem::Specification.new do |s|
	s.name			= 'html_toc'
	s.version		= '1.0.0'
	s.date			= '2014-12-09'
	s.summary		= "Generate and Insert a Table of Contents into a HTML Document"
	s.description	= "Do a case-insensitive search on an HTML document for the token [[toc]]. If present, scan the document for header tags in a given range, verify that they have an id attribute and give them one if needed, then generate a group of links pointing to those headers with the header text used as the link text. This group of links then replaces the token."
	s.authors		= ["Gregory Gadow"]
	s.email			= 'gpg@gregory-gadow.net'
	s.homepage	= 'http://rubygems.org/gems/html_toc'
	s.files			= ["lib/html_toc.rb"]
  s.licenses  = ['MIT']
end
