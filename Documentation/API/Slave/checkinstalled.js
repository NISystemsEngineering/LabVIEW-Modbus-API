/*************************************************************
*
*     Registers files as clients for dynamic content. To register a file as a dynamic content client, 
*		add the name of your CHM file to the alldynamicclients array on a new line, followed by a comma.
*		However, the last file in the list should NOT be followed by a comma.
*				  
*************************************************************/
var alldynamicclients = new Array(
	"criodevicehelp",
	"embtimevi",
	"inlinecnode",
	"internethelp",
	"lvarmhelp",
	"lvblackfin",
	"lvblackfinhelp",
	"lvcdsimshrd",
	"lvctrldsgn",
	"lvdfdtconcepts",
	"lvdsc",
	"lvdschelp",
	"lvdsphelp",
	"lvfpga",
	"lvfpgahelp",
	"lvoatmain",
	"lvpdadialog",
	"lvpdagsm",
	"lvpdahelp",
	"lvpid",
	"lvpid",
	"lvrgthelp",
	"lvrthelp",
	"lvscconcepts",
	"lvsim",
	"lvsimconcepts",
	"lvsimtkconcepts",
	"lvsitconcepts",
	"lvspt",
	"lvsysid",
	"lvtimefreqtk",
	"lvtimeseriestk",
	"lvtpcdialog",
	"lvtpcgsm",
	"lvtpchelp",
	"lvtrace",
	"lvtracehelp",
	"lvwavelettk",
	"sndvibtk",
	"target2devicehelp"
	);

for (i = 0; i < alldynamicclients.length; i++) {
	var client = alldynamicclients[i];
	var chm_js = "ms-its:" + client + ".chm::/" + client + ".js";
	include_js(chm_js);
}


