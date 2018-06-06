/******************************************************************************
pdf.js
Version 1.4
See readme for version history.
******************************************************************************/

// -----------------------
// FUNCTION: AcrobatLink
// DESCRIPTION: Opens a local PDF from a CHM HTML page link; opens in a new browser window
// ARGUMENTS:
//  strPath: string (Filename and path to PDF)
//  RETURN: nothing, because this function is called from an HTML anchor href link
// -----------------------
function AcrobatLink() 
{
	var strPath = "";
	strPath = arguments[0];
	strChmPrefix = "mk:@MSITStore:";
	
	strChmPath = document.URL.substring( 0, document.URL.indexOf( "::" ) );
	intFilePosition = ( strChmPath.lastIndexOf( "\\" ) > strChmPath.lastIndexOf( "/" ) ) ? strChmPath.lastIndexOf( "\\" ) : strChmPath.lastIndexOf( "/" );
	strPdfPath = unescape( strChmPath.substring( strChmPrefix.length,intFilePosition ) + "/" + strPath );
	
	objNewWin = window.open(strPdfPath,'objNewWin','resizable=yes,status=yes,toolbar=no');
	
	
return;
}

// -----------------------
// FUNCTION: CheckAcrobatReader
// DESCRIPTION: Check if Acrobat Reader ActiveX plugin is installed
// ARGUMENTS: none
// RETURN: blnResult
// -----------------------
function CheckAcrobatReader() {
	// Initialize result and reader variables
	var blnResult = false;
	var objReader = null;
	// Loop through trying to create an ActiveXObject for versions 1 - 20 of Acrobat Reader
	// I go up to version 20 to build in testing for future versions
	for(i=1;i<21;i++) {
		try {
			objReader = new ActiveXObject("PDF.PdfCtrl." + i);
			// If a reader object was created, the plugin is installed
			// And the next line of code will run setting result to true
			// Otherwise, the script will jump to the catch statement
			blnResult = true;
		} catch(e) {
			// Do nothing on error, just continue the loop to try next version of Acrobat Reader
		}
	}
	// Set reader object to null, to remove it from memory
	objReader = null;
	// Return result, true or false, about whether Acrobat plugin is installed
	return blnResult;
}