/*************************************************************
*     Check for Dynamic Links
*************************************************************/

function checkHelpFileLinks() {
   var index=0;
   var linksToTest = new Array;
   linksToTest= getElementsByClass("checkLink");
   for(index=0;index<linksToTest.length;index++) {
      var classes= new Array;
      classes=getClasses(linksToTest[index]);
      if (is_win)
      {
		  if(classes[1]) {
          	 var helpFile = classes[1];
          	 if (!searchArray(availableFiles, helpFile)) {
          	    removeLink(linksToTest[index]);
    	     }
    	  }
    	  else {
    	     removeLink(linksToTest[index]);
	      }
      }
      else {
      	  removeLink(linksToTest[index]);
      }
   }
}

function removeLink(node) {
   node.removeAttribute("href");
   node.style.color="#000000";
}

if (typeof(registerForInitPage) == "function")
{
	registerForInitPage(checkHelpFileLinks);
}