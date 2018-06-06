document.write("<scr"+"ipt src=\"Variables.js\"></"+"script>");

var japaneseCSS = "";
japaneseCSS += "body {background-color:#ffffff; font-family:Verdana, \"MS Gothic\"; font-size:10pt; color: #000000; }";
japaneseCSS += "form { margin-bottom:3pt; margin-top:0pt; font-family:Verdana, \"MS Gothic\"; font-size:100%; color:black; }";
japaneseCSS += "select { font-family: font-family:Verdana, \"MS Gothic\"; font-size:100%; color:black; }";

var simpChineseCSS = "";
simpChineseCSS += "body {background-color:#ffffff; font-family:Verdana, SimSun, sans-serif; font-size:9pt; color: #000000; }";
simpChineseCSS += "form { margin-bottom:3pt; margin-top:0pt; font-family:Verdana, SimSun, sans-serif; font-size:100%; color:black; }";
simpChineseCSS += "select { font-family: font-family:Verdana, SimSun, sans-serif; font-size:100%; color:black; }";


var koreanCSS = "";
koreanCSS += "body {background-color:#ffffff; font-family:\"Gulim\", Verdana, sans-serif; font-size:9pt; color: #000000;}";
koreanCSS += "form { margin-bottom:3pt; margin-top:0pt; font-family:\"Gulim\", Verdana, sans-serif; font-size:100%; color:black; }";
koreanCSS += "select { font-family: font-family:\"Gulim\", Verdana, sans-serif; font-size:100%; color:black; }";

var maxEnglishCSS = "";
maxEnglishCSS += "body {background-color:#ffffff; font-family:Verdana, sans-serif; font-size:10px; color: #000000;}\n";
maxEnglishCSS += "H1 { margin-top:3.00pt; margin-bottom:3.00pt; font-size:130%; font-weight:bold;  } /* 130% instead of 150% */\n";
maxEnglishCSS += "H2 { margin-top:9.00pt; margin-bottom:3.00pt; font-size:110%; font-weight:bold;  } /* 110% instead of 125% */\n";

/* French and German MAX CSS rules are identical to English MAX CSS rules. */
var maxGermanCSS = maxEnglishCSS;
var maxFrenchCSS = maxEnglishCSS;

/* Japanese, Korean, and simplified Chinese MAX CSS rules are identical to the non-MAX counterparts. */
var maxJapaneseCSS	= japaneseCSS;
var maxSimpChineseCSS	= simpChineseCSS;
var maxKoreanCSS	= koreanCSS;

function writeStyleSheets() {
   if(typeof(L_helpType) == "string") {
      L_helpType = L_helpType.toUpperCase();
      var index = L_helpType.indexOf("_");
      var type = L_helpType.substring(0, index);
      var lang = L_helpType.substring(index+1);
      if (type =="MAX") {
         if (lang == "ENG") {
            document.write('<style>'+maxEnglishCSS+'</style>');
         }         
         else if (lang == "JPN") {
            document.write('<style>'+maxJapaneseCSS+'</style>');
         }
         else if (lang == "KOR") {
            document.write('<style>'+maxKoreanCSS+'</style>');
         }
         else if (lang == "ZHS") {
	    document.write('<style>'+maxSimpChineseCSS+'</style>');
         }
         else if (lang == "FRA") {
	    document.write('<style>'+maxFrenchCSS+'</style>');
         }
         else if (lang == "DEU") {
	    document.write('<style>'+maxGermanCSS+'</style>');
         }
      }
      else if (type =="STD") {
         if (lang == "JPN") {
            document.write('<style>'+japaneseCSS+'</style>');
         }
         else if (lang == "KOR") {
            document.write('<style>'+koreanCSS+'</style>');
	 }
	 else if (lang == "ZHS") {
	    document.write('<style>'+simpChineseCSS+'</style>');
	 }
      }
   }
}

writeStyleSheets();
   