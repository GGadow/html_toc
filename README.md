**Travis CI:** ![Latest test](https://travis-ci.org/GGadow/html_toc.svg?branch=master)

#HtmlToc

HtmlToc is a Ruby module that post-processes an HTML document to built a table of contents and insert it at a specified location. It takes in the source text of the page, and returns the modified text.

##About

The gem consists of a single module, <span style="color:#009900;">HtmlToc</span>, which exposes a single public method, <span style="color:#009900;">process</span>. 

<span style="color:#009900;">#process</span> starts by performing a case-insensitive search for a token, **\[\[toc\]\]**. If no token is found, the unmodified source text is return. 

If the token is found, <span style="color:#009900;">#process</span> scans for header tags falling within a provided range; if the header does not already have an id attribute, one is added. If no matching headers are found, the token is removed and the modified source text is returned.

If headers are found, a link is generated for each matching header. The link text is taken from the header text, and the link's href points to the header's id. Each link wrapped in a div tag; the div is given a class name that matches is level relative to the search range. The link divs are wrapped in a few more divs with unique ids to create the table of contents. Lastly, the table of contents replaces the token and the modified source is returned. The classes and id allow the page to be styled in accordance with the website's design context. The resulting table of contents might look like this:

<div style="border:solid 1px #000000;margin-left:1em;">

&lt;div id='__toc'&gt;<br/>
&nbsp;&nbsp;&lt;div id='__toc_header'&gt;Contents&lt;/div&gt;<br/>
&nbsp;&nbsp;&lt;div id='__toc_content' style='display:block'&gt;<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&lt;div class='__toc_level_1'&gt;&lt;a href='#id__1'&gt;1 First (1<sup>st</sup>) major header&lt;/a&gt;&lt;/div&gt;<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&lt;div class='__toc_level_2'&gt;&lt;a href='#id__5'&gt;1.1 Minor header 1&lt;/a&gt;&lt;/div&gt;<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&lt;div class='__toc_level_3'&gt;&lt;a href='#id__11'&gt;1.1.1 Detail the first&lt;/a&gt;&lt;/div&gt;<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&lt;div class='__toc_level_3'&gt;&lt;a href='#already_here_1'&gt;1.1.2 Detail the second&lt;/a&gt;&lt;/div&gt;<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&lt;div class='__toc_level_2'&gt;&lt;a href='#already_here_2'&gt;1.2 Minor header 2&lt;/a&gt;&lt;/div&gt;<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&lt;div class='__toc_level_1'&gt;&lt;a href='#already_here_3'&gt;2 Second major header&lt;/a&gt;&lt;/div&gt;<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&lt;div class='__toc_level_2'&gt;&lt;a href='#id__2'&gt;2.1 Minor header 3&lt;/a&gt;&lt;/div&gt;<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&lt;div class='__toc_level_3'&gt;&lt;a href='#id__12'&gt;2.1.1 Detail the third&lt;/a&gt;&lt;/div&gt;<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&lt;div class='__toc_level_3'&gt;&lt;a href='#already_here_4'&gt;2.1.2 Detail the fourth&lt;/a&gt;&lt;/div&gt;<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&lt;div class='__toc_level_2'&gt;&lt;a href='#already_here_5'&gt;2.2 Minor header 4&lt;/a&gt;&lt;/div&gt;<br/>
&nbsp;&nbsp;&lt;/div&gt;<br/>
&lt;/div&gt;

</div>

##Use

**<span style="color:#009900;">HtmlToc.process</span> &nbsp;&nbsp; source** &nbsp;&nbsp; *h_tags* &nbsp;&nbsp; *show_toggle* &nbsp;&nbsp; *use_numbers*

>**source** is a string holding the HTML source.

>*h_tags* is an optional range of integers giving the indexes of the header tags that will be used to the table of contents. The method iterates through *h_tags* to build the regular expression <span style="color:#800000;">/&lt;h#{x}(?: .\*?)?&gt;(.\*?)&lt;\/h#{x}&gt;/</span>. If omitted, the range (2..6) is assumed.

>*show_toggle* is an optional boolean. If **true**, the table of contents will include a span coded to call <span style="color:#800000">onclick = 'ShowHideToc();'</span>. This stub can be linked to a Javascript method to toggle the visibility of the table of contents. If omitted, **false** is assumed.

>*use_numbers* is an optional boolean. If **true**, the table of contents entries will have outline index numbers; otherwise, no numbers will be included. If an intervening header is missing &mdash; say, you have an h3 followed by an h5 &mdash; an index of zero will be used to indicate the missing h4. If omitted, **false** is assumed.

##CSS

These classes and ids are used by <span style="color:#009900;">HtmlToc</span> in the table of contents.

>**#__toc** - The outer frame div.

>**#__toc_header** - The header div.

>**#__toc_content** - The contents div.

>**#__toc_toggle** - The span containing the toggle.

>**.__toc_level_x** - Used on the divs holding the links, with x ranging from 1 to 6. These are applied as the header tags are found, so using the default *h_tags*, __toc_level_1 will be associated with h2 tags, __toc_level_2 with h3 tags, and so on.


##Additional files

See **sample/html_toc.css** for an example of how to style the table of contents.<br/>
See **sample/html_toc.js** for the Javascript to toggle visibility of the table of contents.

