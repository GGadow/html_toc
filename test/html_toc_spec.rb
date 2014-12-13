require_relative '../lib/html_toc.rb'

include HtmlToc

describe HtmlToc do
  
  context "The source does not have a token" do
    it "should return the unmodified source" do
      before = File.read("NoToken.html")
      after = HtmlToc.process(source: before)
      expect(after).to eq(before)
    end
  end

  context "The source has a token and was called with default range to index" do
    after = HtmlToc.process(source: File.read("WithToken.html"))
 
    it "should not generate a TOC entry for H1" do
      expect(after).not_to include("<a href='#this_is_one'>Header One</a>")
    end

    it "should generate a TOC entry for H2" do
      expect(after).to include("<a href='#this_is_two'>Header Two</a>")
    end

    it "should generate a TOC entry for H3" do
      expect(after).to include("<a href='#this_is_three'>Header Three</a>")
    end

    it "should generate a TOC entry for H4" do
      expect(after).to include("<a href='#this_is_four'>Header Four</a>")
    end

    it "should generate a TOC entry for H5" do
      expect(after).to include("<a href='#this_is_five'>Header Five</a>")
    end

    it "should generate a TOC entry for H6" do
      expect(after).to include("<a href='#this_is_six'>Header Six</a>")
    end
  end

  context "The source has a token and was given a specific range to index" do
    after = HtmlToc.process(source: File.read("WithToken.html"), h_tags: (3..5))
 
    it "should not generate a TOC entry for H1" do
      expect(after).not_to include("<a href='#this_is_one'>Header One</a>")
    end

    it "should not generate a TOC entry for H2" do
      expect(after).not_to include("<a href='#this_is_two'>Header Two</a>")
    end

    it "should generate a TOC entry for H3" do
      expect(after).to include("<a href='#this_is_three'>Header Three</a>")
    end

    it "should generate a TOC entry for H4" do
      expect(after).to include("<a href='#this_is_four'>Header Four</a>")
    end

    it "should generate a TOC entry for H5" do
      expect(after).to include("<a href='#this_is_five'>Header Five</a>")
    end

    it "should not generate a TOC entry for H6" do
      expect(after).not_to include("<a href='#this_is_six'>Header Six</a>")
    end
  end
  
  context "The source has a token and was given an array to index" do
    after = HtmlToc.process(source: File.read("WithToken.html"), h_tags: [2, 4, 6])
 
    it "should not generate a TOC entry for H1" do
      expect(after).not_to include("<a href='#this_is_one'>Header One</a>")
    end

    it "should generate a TOC entry for H2" do
      expect(after).to include("<a href='#this_is_two'>Header Two</a>")
    end

    it "should not generate a TOC entry for H3" do
      expect(after).not_to include("<a href='#this_is_three'>Header Three</a>")
    end

    it "should generate a TOC entry for H4" do
      expect(after).to include("<a href='#this_is_four'>Header Four</a>")
    end

    it "should not generate a TOC entry for H5" do
      expect(after).not_to include("<a href='#this_is_five'>Header Five</a>")
    end

    it "should generate a TOC entry for H6" do
      expect(after).to include("<a href='#this_is_six'>Header Six</a>")
    end
  end

  context "The source has a token and is using default args for the hide button and number use" do
    after = HtmlToc.process(source: File.read("WithToken.html"))
      
    it "should not have a Hide button" do
      expect(after).not_to include("[<span id='__toc_toggle' onclick='ShowHideToc();'>Hide</span>]")
    end

    it "should not have numbers on the links" do
      expect(after).to include("<a href='#this_is_two'>Header Two</a>")
      expect(after).to include("<a href='#this_is_three'>Header Three</a>")
    end
  end  

  context "The source has a token and is using non-default args for the hide button and number use" do
    after = HtmlToc.process(source: File.read("WithToken.html"), h_tags: (2..6), show_toggle: true, use_numbers: true)
     
    it "should not have a Hide button" do
      expect(after).to include("[<span id='__toc_toggle' onclick='ShowHideToc();'>Hide</span>]")
    end

    it "should numbers on the links" do
      expect(after).to include("<a href='#this_is_two'>1 Header Two</a>")
      expect(after).to include("<a href='#this_is_three'>1.1 Header Three</a>")
    end
  end

  context "The source has a token and the headers do not have id attributes" do
    after = HtmlToc.process(source: File.read("NoIds.html"))
 
    it "should generate an ID for H2" do
      expect(after).to include("<a href='#_id__1'>Header Two</a>")
    end

    it "should generate an ID for H3" do
      expect(after).to include("<a href='#_id__2'>Header Three</a>")
    end

    it "should generate an ID for H4" do
      expect(after).to include("<a href='#_id__3'>Header Four</a>")
    end

    it "should generate an ID for H5" do
      expect(after).to include("<a href='#_id__4'>Header Five</a>")
    end

    it "should generate an ID for H6" do
      expect(after).to include("<a href='#_id__5'>Header Six</a>")
    end
  end

  context "The source has a token and the headers already have id attributes" do
    after = HtmlToc.process(source: File.read("Ids.html"))

    it "should use the given ID for H2" do
      expect(after).to include("<a href='#header_2'>Header Two</a>")
    end

    it "should use the given ID for H3" do
      expect(after).to include("<a href='#header_3'>Header Three</a>")
    end

    it "should use the given ID for H4" do
      expect(after).to include("<a href='#header_4'>Header Four</a>")
    end

    it "should use the given ID for H5" do
      expect(after).to include("<a href='#header_5'>Header Five</a>")
    end

    it "should use the given ID for H6" do
      expect(after).to include("<a href='#header_6'>Header Six</a>")
    end
  end

end
