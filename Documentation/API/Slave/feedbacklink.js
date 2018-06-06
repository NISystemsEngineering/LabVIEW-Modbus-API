//Check the LV Version
<!--
document.write("<scr"+"ipt src=\"ms-its:glang.chm::/lvversion.js\"></"+"script>");
document.write("<scr"+"ipt src=\"Variables.js\"></"+"script>");
// -->
//***************************************
// Need to think about how we send version info. lvversion doesn't make sense for all products.
// In addition, it might be worth it to just track CHM version, maybe with partnum.
// Or, should we hit a URL like somehandler.php?product=someDNAForNI-DAQ&version=7.0.0
//****************************************

//if lvversion is something wonky, then the string is blank
if(typeof(lvversion)!="string") {
   var lvversion="";
}

//use the noFeedbackLink variable to disable the feedback link. If the variable is undefined, it initializes to false
if (typeof nofeedbacklink == "undefined") {
	var nofeedbacklink = false;
}

//determines if the help file is localized
function NeedLink() {
   if (nofeedbacklink) {
	  return false;
   }
   if(typeof(L_helpType) == "string") {
      L_helpType = L_helpType.toUpperCase();
      var index = L_helpType.indexOf("_");
      var type = L_helpType.substring(0, index);
      var lang = L_helpType.substring(index+1);
      if (lang=="ENG") {
         return true;
      }
   }
   return false;
}

//parses the entire path name down into the chm and filename or html file name (html filename for linux and mac)
function ParsePath()
{
   var EntireURL=location.pathname;
      
   var temp = new Array();
     
   var DotCHMPos=EntireURL.lastIndexOf(".chm");
   var helpPath;
   
   if(DotCHMPos>=0) {
      var CHMFileName;
      var BeforeDotCHM = EntireURL.substr(0,DotCHMPos);
      var DotCHMAndAfter = EntireURL.substr(DotCHMPos);
      
      if(FBL_isCHM(EntireURL)) {
	       //Check to see if IE 7; if so, we don't use the "escape" function. For all other browsers, we do.
           if (is_ie7up==true) {
		     CHMFileName = BeforeDotCHM.substr(BeforeDotCHM.lastIndexOf("\\"));
		   }
		   else {
		 
		   //if we're in a CHM, the backslash is escaped to %5C, so we need an offset of 3.
           CHMFileName = BeforeDotCHM.substr(BeforeDotCHM.lastIndexOf(escape("\\"))+3);
            }
		   }
           else {
           CHMFileName = BeforeDotCHM.substr(BeforeDotCHM.lastIndexOf("/")+1);
           }
           //Note from Kyle-This maybe needs to be made consistent some.chm::/topic.html
          helpPath = CHMFileName+DotCHMAndAfter;      
      }
     else {
      helpPath=EntireURL;
     }
    return helpPath;
    
}

//determines if the file comes from a chm or an html file (mac and linux operate off of html files)
function FBL_isCHM(EntireURL) {
   return (EntireURL.indexOf("::/") >= 0);
}

//opens a new window
function WWW(url) 
	{
	var urlWindow;
	urlWindow = window.open(url, "New", "directories=yes,location=yes,menubar=yes,resizable=yes,scrollbars=yes,status=yes,toolbar=yes");
	}
//Builds the feedback link and escapes it using the URLencode funtion.
//handlerURL is what the ni info code will need to be.
function BuildFeedbackURL() {	
   var FileName=ParsePath();
   var handlerURL = "http://digital.ni.com/applications/psc.nsf/docdetails?OpenForm&node=seminar_US"
   var ProductDNA="productline=28";
   var VersionDNA=lvversion;
   
   var link_string = handlerURL + "&" + ProductDNA + "&" + "version="+URLencode(VersionDNA) + "&" + "file="+URLencode(FileName);
   return link_string;
}

function URLencode(string) {
   //Need a homegrown simple replace() function because regular expressions don't work in IE 5.
   //Both IE and Firefox escape() take care of " and ', so we probably don't need them done explicitly
   return escape(string).
             replace(/\+/g, '%2B').
                replace(/\"/g,'%22').
                   replace(/\'/g, '%27').
				   	replace(/\\/g, '%5C').
                     replace(/\//g,'%2F');
}

var WWW_Doc_Feedback = BuildFeedbackURL();



//Prints the link on the page; if the link is in a localized help file and/or the boolean is false, the link does not print.
function appendFeedbackLink() {
	var link_href = 'javascript:WWW("' + WWW_Doc_Feedback + '")';
	var pnode = document.createElement('p');
	var anode = document.createElement('a');
	var txtnode = document.createTextNode(L_submitFeedbackBlurb);
	var bottombar = document.createElement('hr');

	anode.setAttribute('href', link_href);
	anode.appendChild(txtnode);
	pnode.appendChild(anode);
	
	var theBody = document.getElementsByTagName("BODY")[0];
	
	//Check for DIVs. If found, add feedback link as child of styleDivScrolling
	var scrollDiv = document.getElementById("styleDivScrolling");
	if (scrollDiv != null) {
		scrollDiv.appendChild(bottombar);
		scrollDiv.appendChild(pnode);
	}
	else {
		theBody.appendChild(bottombar);
		theBody.appendChild(pnode);
	}
}

if (typeof(registerForInitPage) == "function") {
	if (NeedLink()) {
		registerForInitPage(appendFeedbackLink);
	}
}
