require 'rexml/document'

module HtmlToc

	#Primary method call
	def self.process source, h_tags=Range.new(1, 6), show_label=true, use_numbers=true

		#Search regex for {{toc}}
		token = /\{\{[tT][oO][cC]\}\}/

 		#If there is no token, just return the source
		if source !~ token then 
			return source
		end
		
		#Initialize here for later 
		toc = ""
		refnum = ""
		d1 = 0
		d2 = 0
		d3 = 0
		d4 = 0
		d5 = 0
		d6 = 0	

    #Make a copy of the source, in case we need to preserve the original string
		result = source	

		#Loop through the tags range to get the header tags
		tags_hash = Hash.new

		depth = 0
		h_tags.each do |x|
			#Get the depth
			depth += 1

			#Regex for indexed header tags
			test = /<h#{x}(?: .*?)?>(.*?)<\/h#{x}>/
		
			#Scan, and use the resulting MatchData objects to populate the hash
			result.scan(test) do
				m=Regexp.last_match
				tags_hash[m.begin(0)] = Hx.new(m, depth)
			end #result.scan(test) do
		end #tags.each do

		#Execute this block only if we have indexed headers
		if tags_hash.length > 0 then
			#Sort the hash. tags becomes an array with each element consisting
			#of an array with two objects: the integer key and the Hx value
			tags = tags_hash.sort_by { |k, v| k }

			#Start with the last tag and work towards the front: this way,
			#the begin index of subsequent headers will not be moved.
			tags.reverse.each do |elem|
				#Replace the section in the text with the corresponding d_anchor
				result[elem[1].start_index..elem[1].end_index]=elem[1].text
			end #tags.reverse.each do

			#Now move forward through the array and build the toc itself
			toc = "<div id='__toc'>\n"
			toc += "<div id='__toc_header'>Contents"
			if show_label then
				toc+=" [<span id='__toc_toggle' onclick='ShowHideToc();'>Hide</span>]"
			end
			toc+="</div>\n"
			toc+="<div id='__toc_content' style='display:block'>\n"
			tags.each do |elem|
				if use_numbers
					case elem[1].depth
						when 1 
							d1+=1
							d2 = 0
							d3 = 0
							d4 = 0
							d5 = 0
							d6 = 0		
							refnum = "#{d1} "
						when 2
							d2+=1
							d3 = 0
							d4 = 0
							d5 = 0
							d6 = 0		
							refnum = "#{d1}.#{d2} "
						when 3
							d3+=1
							d4 = 0
							d5 = 0
							d6 = 0		
							refnum = "#{d1}.#{d2}.#{d3} "
						when 4
							d4+=1
							d5 = 0
							d6 = 0		
							refnum = "#{d1}.#{d2}.#{d3}.#{d4} "
						when 5
							d5+=1
							d6 = 0		
							refnum = "#{d1}.#{d2}.#{d3}.#{d4}.#{d5} "
						when 6
							d6+=1
							refnum = "#{d1}.#{d2}.#{d3}.#{d4}.#{d5}.#{d6} "
					end #case elem[1].depth
				end #if use_numbers

				toc+=elem[1].l_anchor refnum
			end
			toc+="</div>\n" #end __toc_content
			toc+="</div>\n" #end __toc
			
		end #if tags_hash.length > 0

		#The location of the toc token may have changed, so get its location
		toc_md = result.match(token)
		result[toc_md.begin(0)..toc_md.end(0)] = toc
		
		result
	end #self.process

private

	class Hx
		attr_reader :depth, :text, :start_index, :end_index

		@@unique_id = 0

		def initialize md, d
			@depth = d
			@text = md.to_s
			@start_index = md.begin(0)
			@end_index = md.end(0)

			#If the tag does not have an ID, give it one
			tag_id = @text.match(/\bid(\s*?)=(\s*?)(["'])(.*?)\3/)
			if tag_id == nil 
				@@unique_id += 1
				id = " id='_id__#{@@unique_id}'"
				snip = @text.index('>') #get the location of the first >
				@text.insert(snip, id)
			end
		end

		def id
			#TODO Allow for undelimited attribute values, as in HTML5
			tag_id = @text.match(/\bid(\s*?)=(\s*?)(["'])(.*?)\3/)

			if tag_id == nil 
				""
			else
				tag_id[0].to_s.match(/(["'])(.*?)\1/)[0].to_s[1..-2]
			end
		end

		def inner_text
			snip_start = @text.to_s.index('>') #Get the index of the first >
			snip_end = @text.to_s.rindex('<') #Get the index of the last <
			@text.to_s[(snip_start+1)..(snip_end-1)] #return everyting in between
		end

		def l_anchor refnum=""
			"<div class='__toc_level_#{@depth}'><a href='##{id}'>#{refnum}#{inner_text}</a></div>\n"
		end

	end
end
