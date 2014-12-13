task :default => :run_test

#Open the src document and load it into before.
#Feed before through HtmlToc.process and put the result into after
#Save after 

task :run_test do
  src = './test/start.html'
	dest = './test/end.html'

	require './lib/html_toc.rb'
	
	before = File.read(src)
	after = HtmlToc.process(source: before, h_tags: (1..6))
	File.open(dest, "w") {|f| f.write(after)}
end
