/**********************************************************
expandable_section.js										
Version 1.1								
May 06, 2002								
Mitch Wilson								

[Usage]
- <script src="expandable_section.js" type="text/javascript"></script>
- onclick="expand('CHANGE_TO_NAME_OF_SECTION')" style="cursor:hand"
- <img src="arrow_close.gif" id="CHANGE_TO_NAME_OF_SECTION_arrow" /> 
- <div id="CHANGE_TO_NAME_OF_SECTION_section" style="display:none">

  </div>
		
[Required Files]								
- arrow_close.gif
- arrow_open.gif

[Notes]
- HomeSite snippets available
- Be sure to append "_section" at the end of the id attributes in your div tags.
  e.g. foo_bar_section, fooBar_section, Foo_bar_section.
- Similarly, be sure to append "_arrow" at the end the id attributes in your img tags.
  e.g. foo_bar_arrow, fooBar_arrow, Foo_bar_arrow.

[History]
- Version 1.1 May 06, 2003 - Reduced arguments from two to one
- Version 1.0 February 18, 2003 - Released
***********************************************************/

function expand(section){
	// get references to current section section style and read/close arrow graphic
	var current_section = document.getElementById(section + "_section").style;
	var a = document.getElementById(section + "_arrow");

	//determine whether section is open or closed
	//check if display is equal to 'none'
	//if it is, the section is closed
	//if it is not, the section is already open
	
	if(current_section.display=='none')
	{
		//if the section is closed, open it by setting display equal to 'block'
		current_section.display='block';
		//and change the arrow graphic to the close version
		a.src = 'arrow_open.gif';
	}
	//if the section was open, close it
	else
	{
		//hide the section section by setting the display to 'none'
		current_section.display='none';
		//chagne the arrow graphic to read
		a.src = 'arrow_close.gif';
	}
	//The following line fixes a behavior in internet explorer
	//When you click a graphic in internet explorer, it becomes highlighted
	//by a dotted line because it has 'focus.' to get rid of this, set the focus
	//to another element on the page. I set the focus to the body of the document,
	//which is just the page in general. Otherwise, the read and close graphics
	//will have a dotted line around them after the user clicks them
	document.body.focus();
}
