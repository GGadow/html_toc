require "../lib/html_toc.rb"

before = File.read("start.html")
after = HtmlToc.process(before, (3..5), true, true)
File.open("end.html", "w") {|f| f.write(after)}
