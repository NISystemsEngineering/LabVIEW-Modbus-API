/**************************************************************
*
* Include common javascript files
* (the document.writeln method works on all supported browsers)
*
***************************************************************/

document.writeln("<script src=variables.js type=text/javascript></script>");
document.writeln("<script src=domtools.js type=text/javascript></script>");
document.writeln("<script src=arraytools.js type=text/javascript></script>");
document.writeln("<script src=osbrowser.js type=text/javascript></script>");
document.writeln("<script src=initpagedyn.js type=text/javascript></script>");
document.writeln("<script src=checkinstalled.js type=text/javascript></script>");
document.writeln("<script src=dynamiccontent.js type=text/javascript></script>");
document.writeln("<script src=dynamiclinks.js type=text/javascript></script>");
document.writeln("<script src=stylesheets.js type=text/javascript></script>");
document.writeln("<script src=feedbacklink.js type=text/javascript></script>");
document.writeln("<script src=web.js type=text/javascript></script>");
document.writeln("<script src=pdf.js type=text/javascript></script>");
document.writeln("<script src=expandable_sections.js type=text/javascript></script>");
document.writeln("<script src=MS-ITS:glang.chm::/helpserver.js type=text/javascript></script>");

/**************************************************************
*
* Include a javascript file in an HTML file
* (This method does not work on Safari for JS files that need to be available before the page renders)
*
***************************************************************/

function include_js(js_file) {
	var doc_head = document.getElementsByTagName('head').item(0);
	var jsNode = document.createElement('script');
	jsNode.setAttribute('language', 'javascript');
	jsNode.setAttribute('type', 'text/javascript');
	jsNode.setAttribute('src', js_file);
	doc_head.appendChild(jsNode);
	return false;
}
