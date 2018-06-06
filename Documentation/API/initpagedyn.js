//this file registers functions to load when the html file loads; if you use this JS file, do not include a separate body onload="" handler in the HTML.

if (typeof(initPageFunctions) == "undefined")
	var initPageFunctions = new Array();

function registerForInitPage(functionToRegister, addToFront) {
   if (typeof(functionToRegister) == "function") {
	if (addToFront) {
		initPageFunctions = addFirstElement(initPageFunctions, functionToRegister);
	}
	else {
		initPageFunctions[initPageFunctions.length] = functionToRegister;
	}
	
   }
   else if (window.initPageDebugAlerts) {
      window.alert("Cannot register a non-function.");
   }
}

function initPageDyn() {
   for (initpgindx = 0; initpgindx < initPageFunctions.length; initpgindx++) {      
   	initPageFunctions[initpgindx]();
   }
}

window.onload = initPageDyn;