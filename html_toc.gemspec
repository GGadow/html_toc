Gem::Specification.new do |s|
	s.name			= 'html_toc'
	s.version		= '1.1.0'
	s.date			= '2014-12-12' 
	s.summary		= "Generate and insert a table of contents into a HTML document"
	s.authors		= ["Gregory Gadow"]
	s.email			= 'gpg@gregory-gadow.net'
  s.homepage  = 'https://github.com/GGadow/html_toc'
	s.files			= ["lib/html_toc.rb"]
  s.licenses  = ['MIT']
  s.required_ruby_version = '>= 2.0'
  s.extra_rdoc_files = ['README.md', 'sample/html_toc.css', 'sample/html_toc.js']
  s.description = <<-EOF
This gem is intended to be used in Rails pre-processing, after the page has been generated but before it is delivered to the requestor. 

It does a case-insensitive search in the source text for [[toc]], which marks where the table of contents will be placed. If the token is not found, the unmodified source is returned.

If the token is found, it searches the text for header tags in a given range, and add an id attribute if the header does not already have one. If no headers were found, it will remove the token and return the modified source. 

If there are headers, a link is generated for each one, using the header's text and id for the link's text and href. The links are wrapped in some divs, with classes and ids added so the table of contents can be styled. The token is then replaced with the table of contents, and the the modified source is returned.
  EOF
end
