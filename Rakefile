task :default => :run_test

task :run_test do
	src = './test/start.html'
	dest = './test/end.html'
	require './lib/html_toc.rb'
	
	before = File.read(src)
	after = HtmlToc.process(before, (3..5), true, true)
	File.open(dest, "w") {|f| f.write(after)}
end
