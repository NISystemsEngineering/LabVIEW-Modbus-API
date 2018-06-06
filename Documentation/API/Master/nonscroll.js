var iebrowser = false;
var nsbrowser = false;
var vScrollWidth = 0;
var cDivScrollingHeightMin = 1;
var cHeightError = -4;
var cWidthError = -4;
var vScrollHeight = cDivScrollingHeightMin;
var vDivTitleHeightError = 0;
var vResizeTimeout;
var vResizeForceTimeout;
// FOR BROWSER INFORMATION GATHERING
var cBrowserName = 0;
var cBrowserVersion = 1;
// BROWSER NAMES
var cBrowserIE = "Microsoft Internet Explorer";
var cBrowserNN = "Netscape Navigator";
var cBrowserSO = "StarOffice";
var cBrowserUnknown = "Unknown";
var fcBrowserName = fBrowser( cBrowserName );
var fcBrowserVersion = fBrowser( cBrowserVersion );
// FOR NON-SCROLLING REGION
window.onresize = fResize;


// "vBrowserInfo" DETERMINES WHAT TYPE OF INFORMATION IS REQUESTED
// (e.g., BROWSER NAME OR VERSION NUMBER)
function fBrowser( vBrowserInfo )

{
	var vBrowserInfoName = "";
	var vBrowserInfoVersion = "";
	var vReturnValue;

	if( vBrowserInfo == cBrowserName )
	{
		if( navigator.appName )
		{
			vBrowserInfoName = navigator.appName;
		}
		else
		// IE 3 DOES NOT ALWAYS RECOGNIZE THE "navigator" OBJECT
		{
			vBrowserInfoName = cBrowserIE;
		}

		if( vBrowserInfoName.indexOf( "Netscape" ) >= 0 )
		{
			vBrowserInfoName = cBrowserNN;
			// STAR OFFICE (3.0) INCORRECTLY REPORTS ITSELF AS NN IN "appName"
			// CHECK "appVersion" INSTEAD AND CHANGE IF NECESSARY
			if( navigator.appVersion )
			{
				if( navigator.appVersion.indexOf( "StarView" ) >= 0 )
				{
					vBrowserInfoName = cBrowserSO;
				}
			}
		}
		else if( vBrowserInfoName.indexOf( "Microsoft" ) >= 0 )
		{
			vBrowserInfoName = cBrowserIE;
		}
		else
		{
			vBrowserInfoName = cBrowserUnknown;
		}

		vReturnValue = vBrowserInfoName;
	}


	else if( vBrowserInfo == cBrowserVersion )
	{

		if( ( navigator.appName ) && ( navigator.appVersion ) )
		{
			if( navigator.appName.indexOf( "Netscape" ) >= 0 )
			{
				vBrowserInfoVersion = parseFloat( navigator.appVersion.substring( 0, navigator.appVersion.indexOf( "(" ) ) );
			}
			else if( navigator.appName.indexOf( "Microsoft" ) >= 0 )
			{
				vBrowserInfoVersion = parseFloat( navigator.appVersion.substring( navigator.appVersion.indexOf( "MSIE " ) + 5, navigator.appVersion.indexOf( ";", navigator.appVersion.indexOf( "MSIE " ) ) ) );
			}
			else if( navigator.appVersion.indexOf( "StarView" ) >= 0 )
			{
				vBrowserInfoVersion = parseFloat( navigator.appVersion.substring( 0, navigator.appVersion.indexOf( "(" ) ) );
			}
		}

		else
		{
			// IE 3 DOES NOT ALWAYS RECOGNIZE THE "navigator" OBJECT
			// OF THE IE 3 BROWSER SET, ONLY THE LATEST (3.02) RECOGNIZES INCLUDED SCRIPTS
			// BUT EVEN IE 3.02 DOESN'T FIND THEM WITHIN AN HTML HELP FILE
			if( vFlagHeader )
			{
				vBrowserInfoVersion = 3.02;
			}
			else
			{
				vBrowserInfoVersion = 3;
			}
		}

		vReturnValue = vBrowserInfoVersion;
	}


	else
	{
		vReturnValue = 0;
	}


	return vReturnValue;


}


//////////////////////////////////////////////////

//Get a reference to the div ID.

function checkIn(id) { 

  // Initialize all the variables.
  var theObj,ss,sr,i,j,layers=new Array();
  // This chunk handles the IE portion of the checkIn code.
  if (document.all) {
    // This checks to see if the inline style declaration has 
    // a position property associated with it. If not, it will 
    // scan the global stylesheets for the ID.
    if((document.all[id].style.position != 'absolute') && (document.all[id].style.position != 'relative')){
      // This little loop I'm very proud of, because it's kinda 
      // slick and I wrote it all myself. It loops through all 
      // global stylesheets and all the rules in each stylesheet, 
      // tests for the selected ID, then returns that as the object.
      for (ss=0 ; ss < document.styleSheets.length; ss++) {
        for (sr=0 ; sr < document.styleSheets(ss).rules.length; sr++) { 
          if (document.styleSheets(ss).rules(sr).selectorText == '#' + id) {
            theObj = document.styleSheets(ss).rules(sr).style;
            break;
          }
        }
      }
    } else {
      // This works the same as in the light version, so you can 
      // use inline styles.
      theObj = document.all[id].style;
    }
  } else if(document.layers) {
    // Now we're in Netscapeland. The main problem here 
    // is finding the object in a maze of hierarchy.
    // This works wonderfully and solves the problem.
    layers = new Array();
    with (document) {
      for (i=0; i<layers.length; i++) layers[i]=layers[i]; {
        for (i=0; i<layers.length; i++) {
          if (layers[i].document && layers[i].document.layers) {
            for (j=0; j<layers[i].document.layers.length; j++) {
              layers[layers.length] = layers[i].document.layers[j];
            }
            if(layers[i].name == id){
              // So if the code matches the name of the layer, 
              // return the reference. 
              theObj = layers[i];
            }
          }
        }
      }
    }
  }
  return theObj;
}

//Reposition the second div ID after the first div ID.
function adjustScroll() {
	if( fcBrowserName == cBrowserIE ) {
		checkIn("styleDivTitle");
		checkIn("styleDivScrolling");
		vScrollHeight = document.body.offsetHeight - styleDivTitle.offsetHeight + cHeightError + vDivTitleHeightError;
		vScrollWidth = document.body.offsetWidth + cWidthError;
		styleDivScrolling.style.top = styleDivTitle.offsetHeight;
		styleDivScrolling.style.height = vScrollHeight;
		styleDivScrolling.style.width = vScrollWidth;
	}
	else return;
}

//////////////////////////////////////////////////

function fResize()

// RUNS WHEN THE WINDOW IS RESIZED

{

	// FOR IE 4, JUST ADJUST THE DIVs ONCE
	// THE TIMEOUT LOGIC IN THE "else" CASE CAUSES AN INFINITE LOOP
	if( ( fcBrowserName == cBrowserIE ) && ( parseInt( fcBrowserVersion ) == 4 ) )
	{
		adjustScroll();
	}
	else
	{
		// DURING A RESIZE, THE RESIZE EVENT FIRES MANY TIMES
		// THE TIMEOUT REDUCES THE FLICKER ON THE SCREEN BY WAITING A MOMENT TO ADJUST THE DIV SIZES
		clearTimeout( vResizeTimeout );
		vResizeTimeout = setTimeout( "adjustScroll();", 5 );
	}

	return;

}

// Netscape fix resize bug Ns4
 function WM_netscapeCssFix() {
   if (document.WM.WM_netscapeCssFix.initWindowWidth != window.innerWidth ||
         document.WM.WM_netscapeCssFix.initWindowHeight != window.innerHeight) {
      document.location = document.location;
     }
 }

 function WM_netscapeCssFixCheckIn() {
   if ((navigator.appName == 'Netscape') && (parseInt(navigator.appVersion) == 4)) {
     if (typeof document.WM == 'undefined'){
        document.WM = new Object;
        }
     if (typeof document.WM.WM_scaleFont == 'undefined') {
        document.WM.WM_netscapeCssFix = new Object;
        document.WM.WM_netscapeCssFix.initWindowWidth = window.innerWidth;
        document.WM.WM_netscapeCssFix.initWindowHeight = window.innerHeight;
        }
     window.onresize = WM_netscapeCssFix;
   }
 }

 WM_netscapeCssFixCheckIn();

 // catch all errors...
 function stopError() {return true;}
 window.onerror=stopError;