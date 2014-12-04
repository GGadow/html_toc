**Travis CI:** ![Latest test](https://travis-ci.org/GGadow/html_toc.svg?branch=master)

#HtmlToc

HtmlToc is a Ruby module that post-processes an HTML document to built a table of contents and insert it at a specified location. 

##About

The gem consists of a single module, <span style="color:#009900;">HtmlToc</span>, which exposes a single public method, <span style="color:#009900;">process</span>. 

<span style="color:#009900;">#process</span> starts by performing a case-insensitive search for a token, **{{toc}}**. If found, it then scans for header tags falling within a provided range; the header will be given a unique ID attribute if it does not already have one. If headers are found, the table of contents is generated, which will replace the token; if no matching headers are found, the token is removed. The resulting document is then returned by the method.

The links are constructed so that the inner HTML will be identical to the inner HTML of the corresponding header, and the href will point to the header ID. The resulting table of contents will look similar to this:

<div style="border:solid 1px #000000;margin-left:1em;">

&lt;div id='__toc'&gt;<br/>
&nbsp;&nbsp;&lt;div id='__toc_header'&gt;Contents[&lt;span id='__toc_toggle' onclick='ShowHideToc();'&gt;Hide&lt;/span&gt;]&lt;/div&gt;<br/>
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

The optional span after **Contents** can be wired to a piece of Javascript that will toggle the visibility of the *__toc_content* div: see file **html_toc.js** for my way of implementing that functionality. See file **html_toc.css** for an example of styling the table of contents to provide indenting and other visual details. 

##Use

**<span style="color:#009900;">HtmlToc.process</span> &nbsp;&nbsp; source** &nbsp;&nbsp; *h_tags* &nbsp;&nbsp; *show_label* &nbsp;&nbsp; *use_numbers*

>**source** is a string holding the HTML source.

>*h_tags* is an optional Enumerable giving the integer indexes of the header tags that will be used to the table of contents. The method will iterate through *h_tags* using <span style="color:#009900;">#each</span> to build the regular expression <span style="color:#800000;">/&lt;h#{x}(?: .\*?)?&gt;(.\*?)&lt;\/h#{x}&gt;/</span> that will find the desired header tags. If omitted, the range (3..6) is assumed, which will add all headers in the document to the table of contents.

>*show_label* is an optional boolean. If **true**, the table of contents will include a span coded to call <span style="color:#800000">onclick = 'ShowHideToc();'</span>. This stub can be linked to a Javascript method to toggle the visibility of the table of contents. If omitted, **true** is assumed.

>*use_numbers* is an optional boolean. If **true**, the table of contents entries will have outline index numbers; otherwise, no numbers will be included. If an intervening header is missing &mdash; say, you have an h3 followed by an h5 &mdash; an index of zero will be used to indicate the missing h4.

##Additional files

See **sample/html_toc.css** for an example how to style the table of contents.<br/>
See **sample/html_toc.js** for the Javascript to toggle visibility of the table of contents.

