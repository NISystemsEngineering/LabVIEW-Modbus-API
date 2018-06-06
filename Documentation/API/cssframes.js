/******************************************************************************
cssframes.js
Version 0.01
Feb. 13, 2006
Original author: unknown
Revision author: Greg Bueno, Kyle Schwankrug
National Instruments, Technical Communications

cssframes.js uses CSS and JavaScript to create the same effect as frames.

[Usage]
<head>
...
<script type="text/javascript" src="osbrowser.js"></script>
<script type="text/javascript" src="cssframes.js"></script>
</head>
<body onLoad="adjustScroll();">
<div id="styleDivTitle">
...
</div>
<div id="styleDivScrolling">
...
</div>
</body>

[Requirements]
osbrowser.js -- for browser sniffing.

[Revision notes]
-- osbrowser.js must be called before nonscroll.js.
-- This version of cssframes.js is a rewrite of nonscroll.js.
-- Variable names have been changed to be more descriptive of the data they hold.
-- Browser checking was moved to the AdjustScroll() function to allow removal of browser check in HTML file.
-- Initialization values and adjustScroll() have been mapped to new values and functions to allow backward compatibility.
-- Mozilla-based browsers such as Firefox are now supported.
******************************************************************************/

/*** Initialize variables ***/
//Width of the scrolling region
var scrollRegionWidth = 0;
//Minimum height of the scrolling region
var scrollRegionHeightMin = 1;
//Height of the scrolling region
var scrollRegionHeight = scrollRegionHeightMin;
//Timeout initialization
var resizeTimeout;
var scrollBarWidth;
var statusBarHeight;
var divScrolling = null;
var divTitle = null;
// Aliases for browsers
var browserIE = "Microsoft Internet Explorer";
var browserNN = "Netscape Navigator";
var browserFF = "Mozilla Firefox";
var browserSO = "StarOffice";
var browserSafari = "Safari";
var browserUnknown = "Unknown";
//Check browser support.
var browserName = CheckBrowserInfo("name");
var browserVersion = Number(CheckBrowserInfo("version"));

//When the window resizes, readjust the scroll.
window.onresize = ResizeScrollRegion;

/*
FUNCTION:
AdjustScroll()

USAGE:
<body onLoad="AdjustScroll();">

DESCRIPTION:
Determines the height of the non-scrolling region, then sets the top coordinate
of the scrolling region to that height. Also sets the width of the scrolling region,
minus the width of the scrollbar.
*/
function AdjustScroll()
{
	var windowHeight, windowWidth;
	//Place <div> elements in a placeholder
	if (document.getElementById)
	{
		//Mozilla and IE 5+ support getElementById function.
		divScrolling = document.getElementById("styleDivScrolling");
		divTitle = document.getElementById("styleDivTitle");
	}
	else if (document.all)
	{
		//IE 4 does not support getElementById, so use document.all instead.
		divScrolling = document.all["styleDivScrolling"];
		divTitle = document.all["styleDivTitle"];
	}
	
	//Retrieve height and width of window and non-scroll region depending upon browser name.
	if (document.body.offsetHeight)
	{
		windowHeight = document.body.offsetHeight;
		windowWidth = document.body.offsetWidth;
	}
	else if (window.innerHeight)
	{
		windowHeight = window.innerHeight;
		windowWidth = window.innerWidth;
	}
	
	//Determine the offsets for the scrollbar and status bar.
	switch (browserName)
	{
		case browserIE:
			//Set size of IE scroll bar and status bar.
			scrollBarWidth = 4;
			statusBarHeight = 4;
			//Scroll bar in IE4 does not go away, so the offset must be bigger
			if (browserVersion < 5) {scrollBarWidth = 20;}
			break;
		case browserSafari:
			//Set size of Safari scroll bar and status bar.
			scrollBarWidth = 10;
			statusBarHeight = 10;
			break;
		case browserFF:
		case browserNN:
		
			//Exit if browser version is less than 5.
			//if (is_nav && is_nav4up) {return;}
			//Set size of NN scroll bar and status bar.
			scrollBarWidth = 10;
			statusBarHeight = 10;
			break;
		default:
			return;
	}
	
	//Calculate height of non-scroll region and scroll region
		//Subtract non-scroll height from window height, then subtract height of status bar
	if (windowHeight > divTitle.offsetHeight)
	{
	scrollRegionHeight = (windowHeight - divTitle.offsetHeight) - statusBarHeight;
	}
		//Subtract scroll bar width from window width
	scrollRegionWidth = windowWidth - scrollBarWidth;
	//Set style attributes of <div> elements to new calculations
	divScrolling.style.top = divTitle.offsetHeight;
	divScrolling.style.height = scrollRegionHeight;
	//divScrolling.style.width = scrollRegionWidth;
}

/*
FUNCTION:
CheckBrowserInfo()

USAGE:
string CheckBrowserInfo(string infoType)

PARAMETERS:
infoType - Quoted string indicating what browser information to return
* "name" - Browser application name
* "version" - Browser version

DESCRIPTION:
Returns the user's browser or version.
This function uses boolean variables defined in osbrowser.js.
*/
function CheckBrowserInfo(infoType)
{
	var vBrowserInfoName, vReturnValue, vBrowserInfoVersion
	//Determine what kind of browser information to return.
	switch (infoType)
	{
		case "name":
			if (is_gecko)
			{
				// Star Office (3.0) incorrectly reports itself as nn in "appName"
				// Check "appversion" instead and change if necessary
				vBrowserInfoName = (navigator.appVersion && navigator.appVersion.indexOf("StarView") >= 0) ? browserSO : browserNN;
				vBrowserInfoName = is_fx ? browserFF : browserNN;
			}
			//Check to see if "appName" contains "Microsoft".
			else if (is_ie)
			{
				vBrowserInfoName = browserIE;
			}
			//Return "Unknown" if "appName" matches neither "Netscape" nor "Microsoft" match.
			else if (is_safari)
			{
				vBrowserInfoName = browserSafari;
			}
			else
			{
				vBrowserInfoName = browserUnknown;
			}
			//Return the browser name.
			vReturnValue = vBrowserInfoName;
			break;
		case "version":
			//Return the browser version.
			vBrowserInfoVersion = is_major;
			vReturnValue = vBrowserInfoVersion;
			break;
		default:
			//Return nothing if "infoType" is not specified.
			vReturnValue = 0;
	}
	//Return the requested browser information.
	return vReturnValue;
}

/*
FUNCTION:
ResizeScrollRegion()

USAGE:
window.onresize = ResizeScrollRegion;

DESCRIPTION:
Resizes scroll region when window is resized.
This function is hold-over from the previous version of nonscroll.js.
*/
function ResizeScrollRegion()
{
	// For IE 4, just adjust the <div> elements once.
	// The timeout logic in the "else" case causes an infinite loop
	if ((browserName == browserSafari) || ((browserName == browserIE) && (parseInt(browserVersion) == 4)))
	{
		AdjustScroll();
	}
	else
	{
		// During a resize, the resize event fires many times.
		// The timeout reduces the flicker on the screen by waiting a moment to adjust the <div> sizes.
		clearTimeout(resizeTimeout);
		resizeTimeout = setTimeout("AdjustScroll();", 5);
	}
	return;
}

/*
FUNCTION:
WriteNonscrollCSS()

USAGE:
string WriteNonscrollCSS();

DESCRIPTION:
Returns a string containing CSS rules for Gecko-based browsers.
*/
function WriteNonscrollCSS()
{
	var str = '';
	str += "body\n";
	str += "{\n";
	str += "	margin: 0px;\n";
	str += "	padding: 0px;\n";
	str += "}\n";
	str += "\n";
	str += "#styleDivTitle\n";
	str += "{\n";
	str += "	background: #FFFFFF top left fixed;\n";
	str += "	border-bottom: solid #000000 5px;\n";
	str += "	position: fixed;\n";
	str += "	width: 100%;\n";
	str += "	z-index: 1;\n";
	str += "	padding: .25em 5px .25em 5px;\n";
	str += "}\n";
	str += "\n";
	str += "#styleDivScrolling\n";
	str += "{\n";
	str += "	background-color: #FFFFFF;\n";
	str += "	position: absolute;\n";
	str += "	width: auto;\n";
	str += "	z-index: 0;\n";
	str += "	padding: 5px;\n";
	str += "	overflow: auto;\n";
	str += "}\n";
	return str;
}

/*
FUNCTION:
WriteNonscrollIECSS()

USAGE:
string WriteNonscrollIECSS();

DESCRIPTION:
Returns a string containing CSS rules for Internet Explorer.
*/
function WriteNonscrollIECSS()
{
	var str = '';
	str += "body\n";
	str += "{\n";
	str += "	margin: 0px;\n";
	str += "	padding: 0px;\n";
	str += "	overflow: hidden;\n";
	str += "}\n";
	str += "\n";
	str += "#styleDivTitle\n";
	str += "{\n";
	str += "	background: #FFFFFF top left fixed;\n";
	str += "	border-bottom: solid #000000 5px;\n";
	str += "	position: absolute;\n";
	str += "	top: 0px;\n";
	str += "	left: 0px;\n";
	str += "	width: 100%;\n";
	str += "	height: auto;\n";
	str += "	padding: .25em 5px .25em 5px;\n";
	str += "}\n";
	str += "\n";
	str += "#styleDivScrolling\n";
	str += "{\n";
	str += "	background-color: #FFFFFF;\n";
	str += "	position: absolute;\n";
	str += "	width: 100%;\n";
	str += "	overflow: auto;\n";
	str += "	padding: 5px;\n";
	str += "}\n";
	return str;
}

/*
FUNCTION:
WriteEmptyNonscrollCSS()

USAGE:
string WriteEmptyNonscrollCSS();

DESCRIPTION:
Returns a string containing empty CSS rules for non-scrolling block-level elements.
*/
function WriteEmptyNonscrollCSS()
{
	str = '';
	str += "body\n";
	str += "{\n";
	str += "}\n";
	str += "\n";
	str += "#styleDivTitle\n";
	str += "{\n";
	str += "}\n";
	str += "\n";
	str += "#styleDivScrolling\n";
	str += "{\n";
	str += "}\n";
	return str;
}

//Alias AdjustScroll() with previous function name, adjustScroll().
//Perform browser check before creating scroll.
function adjustScroll()
{
	if ((browserName == browserIE) || (browserName == browserFF) || (browserName == browserSafari))
	{
		AdjustScroll();
	}
}

/*** BACKWARD COMPATABILITY ***/
/*
The following initialization values are held over from the previous version of nonscroll.js to allow backward compatibility with existing implementations.
*/

//Map previous initialization values with new initialization values
//Width of the scrolling region
var vScrollWidth = scrollRegionWidth;
//Minimum height of the scrolling region
var cDivScrollingHeightMin = scrollRegionHeightMin;
//Height of the scrolling region
var vScrollHeight = cDivScrollingHeightMin;
//Timeout initialization
var resizeTimeout;
// Aliases for browsers
var cBrowserIE = browserIE;
var cBrowserNN = browserNN;
var cBrowserSO = browserSO;
var cBrowserUnknown = browserUnknown;
var fcBrowserName = browserName;
var fcBrowserVersion = browserVersion;

//The following initialization values were not used in the previous version.
//They are preserved here for posterity.
var vDivTitleHeightError = 0;
var vResizeForceTimeout;

// The following initialization are obsolete.
var cHeightError = -4;
var cWidthError = -4;
var cBrowserName = 0;
var cBrowserVersion = 1;

/*** CSS RULES ***/
/*
Write out all CSS rules.
*/

var cssStr;
switch (browserName)
{
	case browserIE:
		cssStr = WriteNonscrollIECSS();
		break;
	case browserNN:
		cssStr = WriteEmptyNonscrollCSS();
		break;
	default:
		cssStr = WriteNonscrollCSS();
}
document.write('<style type="text/css">');
document.write('<!--');
document.write(cssStr);
document.write('-->');
document.write('</style>');

if (typeof(registerForInitPage) == "function")
{
   registerForInitPage(AdjustScroll);
}

