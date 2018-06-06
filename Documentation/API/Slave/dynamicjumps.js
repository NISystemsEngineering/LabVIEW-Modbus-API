function Call_Variables () {
document.write("<scr"+"ipt src=\"Variables.js\"></"+"script>");
}

/**************************************
*
*				createjumps.js
*
***************************************/

function Func_Do_Not_Print_Dynamic_Table() {
   if(typeof(Do_Not_Print_Dynamic_Table) == "string") {
      Do_Not_Print_Dynamic_Table = Do_Not_Print_Dynamic_Table.toUpperCase();
         if (Do_Not_Print_Dynamic_Table == "TRUE") {
         return true;
      }
   }
   return false;
}

  

function createjumps()
{
		var documentElements = new Array;
		var BodyElements = new Array;
		var HtagArray = new Array;
		var count = 0;

		documentElements = document.getElementsByTagName("body").item(0);
		BodyElements = documentElements.getElementsByTagName("H2");
	
	if (BodyElements.length > 0) {
		for(i = 0; i < BodyElements.length; i++) {
        	H2TopicObject = BodyElements.item(i).previousSibling;
			if(H2TopicObject != null) {
        		if (H2TopicObject.tagName == "A")
        		{	NameString = H2TopicObject.getAttribute("name");
					if(NameString != null) {
						HtagArray[count] = H2TopicObject.name;
						h2text = getText(BodyElements.item(i)).replace(/\u00A0+/g,' ');			
						HtagArray[count + 1] = h2text;
						count += 2;
					}
				}
			}
		}
	}

    if(HtagArray.length != 0) {
          createTopJumps(BodyElements);
    }

		return HtagArray;
}


/***************************************
*
*				Generate Subtopic Table
*
***************************************/
function createSubs(tagArray)
{
	var TopicBody = document.getElementsByTagName("BODY").item(0);
	var TopicChilds = TopicBody.childNodes;
	var TopTag = TopicChilds.item(0);
		
	TopicJump_div = document.createElement("DIV");
	TopicJump_div.style.styleFloat = "right";
	TopicJump_div.style.cssFloat = "right";

	  Main_table = document.createElement("TABLE");
    Main_table.setAttribute("width", "170");
    Main_table.setAttribute("borderTop", "4px solid white");
		Main_table.setAttribute("cellPadding", "0");
		Main_table.setAttribute("cellSpacing", "0");
		Main_table.setAttribute("border", "0");
			Main_table_body = document.createElement("TBODY");
				Current_main_row = document.createElement("TR");

					Current_main_cell = document.createElement("TD");
          Current_main_cell.style.backgroundColor = "#6699cc";
          Current_main_cell.style.color = "#ffffff";
          Current_main_cell.style.padding = "0px";
					Current_main_cell.setAttribute("align", "left");
					Current_main_cell.setAttribute("height", "19");
					Current_main_cell.setAttribute("width", "15");
						TD_HeaderLeft = document.createElement("IMG");
						TD_HeaderLeft.setAttribute("src", "blueleft.gif");
						TD_HeaderLeft.setAttribute("height", "19");
						TD_HeaderLeft.setAttribute("width", "15");
            TD_HeaderLeft.style.backgroundColor = "#6699cc";
            TD_HeaderLeft.style.color = "#ffffff";
            TD_HeaderLeft.style.padding = "0px";
					Current_main_cell.appendChild(TD_HeaderLeft);
					Current_main_row.appendChild(Current_main_cell);

					Current_main_cell = document.createElement("TD");
          Current_main_cell.style.backgroundColor = "#6699cc";
          Current_main_cell.style.color = "#ffffff";
          Current_main_cell.style.padding = "2px";
          Current_main_cell.style.fontSize = "98%";
          Current_main_cell.style.fontFamily = "verdana, arial, helvetica";
					Current_main_cell.setAttribute("align", "center");
					Current_main_cell.setAttribute("height", "19");
					Current_main_cell.setAttribute("width", "140");
						TD_HeaderMid = document.createElement("STRONG");
            TD_HeaderMid.style.backgroundColor = "#6699cc";
            TD_HeaderMid.style.color = "#ffffff";
            TD_HeaderMid.style.padding = "2px";
						Strong_text = document.createTextNode(L_table_title_string);
						TD_HeaderMid.appendChild(Strong_text);
						Current_main_cell.appendChild(TD_HeaderMid);
					Current_main_row.appendChild(Current_main_cell);

					Current_main_cell = document.createElement("TD");
          Current_main_cell.style.backgroundColor = "#6699cc";
          Current_main_cell.style.color = "#ffffff";
          Current_main_cell.style.padding = "0px";
					Current_main_cell.setAttribute("align", "right");
					Current_main_cell.setAttribute("height", "19");
					Current_main_cell.setAttribute("width", "15");
						TD_HeaderRight = document.createElement("IMG");
						TD_HeaderRight.setAttribute("src", "blueright.gif");
						TD_HeaderRight.setAttribute("height", "19");
						TD_HeaderRight.setAttribute("width", "15");
						TD_HeaderRight.style.backgroundColor = "#6699cc";
						TD_HeaderRight.style.color = "#ffffff";
						TD_HeaderRight.style.padding = "0px";
						Current_main_cell.appendChild(TD_HeaderRight);
					Current_main_row.appendChild(Current_main_cell);

				Main_table_body.appendChild(Current_main_row);

				Current_main_row = document.createElement("TR");
					Current_main_cell = document.createElement("TD");
					Current_main_cell.style.padding = "0px";
					Current_main_cell.colSpan = "3";

						Mid_table = document.createElement("TABLE");
						Mid_table.setAttribute("bgColor", "#ffffff");
						Mid_table.style.width = "100%";
						Mid_table.setAttribute("cellPadding", "0");
						Mid_table.setAttribute("cellSpacing", "0");
						Mid_table.setAttribute("border", "0");
							Mid_table_body = document.createElement("TBODY");
								Current_row = document.createElement("TR");

									Current_cell = document.createElement("TD");
									Current_cell.style.backgroundColor = "#6699cc";
									Current_cell.style.verticalAlign = "top";
									Current_cell.style.padding = "0px";
									Current_cell.style.width = "1";
									Current_cell.colSpan = "1";
										Current_cell_DIV = document.createElement("DIV");
                    Current_cell_DIV.style.padding = "0px";
                    Current_cell_DIV.style.margin = "0px";
										Current_cell.appendChild(Current_cell_DIV);
									Current_row.appendChild(Current_cell);

									Current_cell = document.createElement("TD");
									Current_cell.style.backgroundColor = "#f1f1f1";
									Current_cell.style.verticalAlign = "top";
									Current_cell.style.padding = "0px";
									Current_cell.style.width = "168";
									Current_cell.colSpan = "1";

										Jump_table = document.createElement("TABLE");
										Jump_table.setAttribute("cellSpacing", "4");
										Jump_table.setAttribute("cellPadding", "0");
										Jump_table.setAttribute("border", "0");
										Jump_table.setAttribute("width", "100%");
										Jump_table.setAttribute("height", "98%");
										Jump_table.style.fontSize = "8pt";
										Jump_table.style.marginLeft = "2px";
										Jump_table.style.fontSize = "8pt";
										Jump_table.style.backgroundColor = "#f1f1f1";

											Jump_table_body = document.createElement("TBODY");

												for(i = 0; i < tagArray.length; i += 2) {
													Current_jumprow = document.createElement("TR");
													Jump_cell = document.createElement("TD");
                          Jump_cell.style.padding = "3px";
														Jump_image = document.createElement("IMG");
														Jump_image.setAttribute("src", "jump.gif");
													Jump_cell.appendChild(Jump_image);
													Jump_cell2 = document.createElement("TD");
                          Jump_cell2.style.padding = "0px";
													  Jump_link = document.createElement("A");
														Jump_link.setAttribute("href", "#" + tagArray[i]);
														Jump_link_text = document.createTextNode(tagArray[i+1]);
														Jump_link.appendChild(Jump_link_text);
													Jump_cell2.appendChild(Jump_link);
												Current_jumprow.appendChild(Jump_cell);
												Current_jumprow.appendChild(Jump_cell2);
												Jump_table_body.appendChild(Current_jumprow);
											 }

									Jump_table.appendChild(Jump_table_body);
									Current_cell.appendChild(Jump_table);
								Current_row.appendChild(Current_cell);

								Current_cell = document.createElement("TD");
								Current_cell.setAttribute("bgColor", "#6699cc");
								Current_cell.setAttribute("vertical-align", "top");
								Current_cell.style.width = "1";
								Current_cell.style.padding = "0px";
								Current_cell.colSpan = "1";
									Current_cell_DIV = document.createElement("DIV");
                  Current_cell_DIV.style.padding = "0px";
                  Current_cell_DIV.style.margin = "0px";
									Current_cell.appendChild(Current_cell_DIV);
								Current_row.appendChild(Current_cell);

							Mid_table_body.appendChild(Current_row);

							Current_row = document.createElement("TR");
								Current_cell = document.createElement("TD");
									Current_cell.setAttribute("bgColor", "#6699cc");
									Current_cell.setAttribute("vertical-align", "top");
									Current_cell.style.height = "1";
									Current_cell.style.padding = "0px";
									Current_cell.colSpan = "3";
										Current_cell_DIV = document.createElement("DIV");
                    Current_cell_DIV.style.padding = "0px";
                    Current_cell_DIV.style.margin = "0px";
									Current_cell.appendChild(Current_cell_DIV);
								Current_row.appendChild(Current_cell);
							Mid_table_body.appendChild(Current_row);

						Mid_table.appendChild(Mid_table_body);
					Current_main_cell.appendChild(Mid_table);
				Current_main_row.appendChild(Current_main_cell);
			Main_table_body.appendChild(Current_main_row);
		Main_table.appendChild(Main_table_body);

	TopicJump_div.appendChild(Main_table);
	TopicBody.insertBefore(TopicJump_div, TopTag);
}

/***************************************
*
*				Generate Top Jump Buttons
*
***************************************/
function createTopJumps(BodyElements)
{
  var TopicBod = document.getElementsByTagName("BODY").item(0);
	var BodyChilds = TopicBod.childNodes;
  var TopicTop = BodyChilds.item(0);
  var count = 0;
  var Top_AJump = null;
	

  try {
        Top_AJump = document.createElement("<A name='topic_top'>");
  } catch (e) {
  }

  if (!Top_AJump || Top_AJump.nodeName != "A") {
        Top_AJump = document.createElement("A");
        Top_AJump.name = "topic_top";
  }
  TopicBod.insertBefore(Top_AJump, TopicTop);

  var H2_count = BodyElements.length;

  for(x = 0; x < H2_count; x++) {
        
        	Jump_div_master = document.createElement("DIV");
			Jump_div_master.style.styleFloat = "right";
			Jump_div_master.style.cssFloat = "right";
			Jump_href = document.createElement("A");
			Jump_href.setAttribute("href", "#topic_top");
			Jump_top_text = document.createTextNode(L_top_text);
			Jump_href.appendChild(Jump_top_text);
			Jump_div_master.appendChild(Jump_href);
			Jump_img = document.createElement("IMG");
			Jump_img.setAttribute("src", "top.gif");
			Jump_img.setAttribute("width", "8");
			Jump_img.setAttribute("height", "8");
			Jump_div_master.appendChild(Jump_img);

			TopicObject = BodyElements.item(x).previousSibling;
			if ( count >= 1 ) {
				if(TopicObject != null) {
        			if (TopicObject.tagName == "A")
        			{	NameString = TopicObject.getAttribute("name");
						if(NameString != null) {
							TopicBod.insertBefore(Jump_div_master, BodyElements.item(x));
						}
					}
				}
			}
			count += 1;
		
  }
  Final_Jump_div = Jump_div_master.cloneNode(true);
  TopicBod.appendChild(Final_Jump_div);
}

/**************************************
*
*    InitJumps (initiate jumps scripts)
*
***************************************/

function initjumps()
{
   if (Func_Do_Not_Print_Dynamic_Table()!=true){
  	Htagelements = createjumps();
    if(Htagelements.length > 0) {
  		createSubs(Htagelements);
		}
    }
}

if (typeof(registerForInitPage) == "function")
{
	registerForInitPage(initjumps, true);
}


