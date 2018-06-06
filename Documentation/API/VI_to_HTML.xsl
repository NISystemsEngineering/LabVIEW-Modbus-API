<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:import href="parametersToHTML.xsl"/>
<xsl:import href="VIXMLtoHTMLCore.xsl"/>

<xsl:param name="owningPalette" />
 
<xsl:output method="html" encoding="ISO-8859-1" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"/>

<!-- [KS] Linking to the Javascript Disabled topic in lvhelp won't work for everyone. -->
<xsl:template name="javascriptDisabledMessage">JavaScript is disabled. <a href="lvhelp.chm::/JavaScript_Disabled.html">Details</a></xsl:template>
<xsl:template name="selectInstanceOption">Select an instance</xsl:template>
<xsl:template name="usePullDownStatemant">Use the pull-down menu to select an instance of this VI.</xsl:template>
<xsl:template name="paletteObjectHeading">Palette Object</xsl:template>
<xsl:template name="subpaletteHeading">Subpalette</xsl:template>
<xsl:template name="descriptionHeading">Description</xsl:template>
<xsl:template name="owningPaletteHeading"><strong>Owning Palette:</strong></xsl:template>
<xsl:template name="installedWithHeading"><strong>Installed With:</strong></xsl:template>
<xsl:template name="helpType">STD_ENG</xsl:template>
<xsl:template name="allRightsReserved">All Rights Reserved.</xsl:template>
<xsl:template name="month1">January</xsl:template>
<xsl:template name="month2">February</xsl:template>
<xsl:template name="month3">March</xsl:template>
<xsl:template name="month4">April</xsl:template>
<xsl:template name="month5">May</xsl:template>
<xsl:template name="month6">June</xsl:template>
<xsl:template name="month7">July</xsl:template>
<xsl:template name="month8">August</xsl:template>
<xsl:template name="month9">September</xsl:template>
<xsl:template name="month10">October</xsl:template>
<xsl:template name="month11">November</xsl:template>
<xsl:template name="month12">December</xsl:template>
<xsl:template name="outputEditionDateAndPartNum">
<xsl:param name="month" />
<xsl:value-of select="$month" /><xsl:text> </xsl:text><xsl:value-of select="@year" />, <xsl:apply-templates />
</xsl:template>

<xsl:template match="vi">
	<html>
		<head>
			<script type="text/javascript">
			         var L_helpType = "<xsl:call-template name="helpType" />";
      			</script>
			<link rel="STYLESHEET" type="text/css" href="minimal.css"/>	
			<xsl:call-template name="javascripts" />
			<script src="cssframes.js" type="text/javascript" />
			<meta name="department" content="Engineering"/>
			<xsl:apply-templates select="name" mode="vititle"/>
			<link media="print" rel="stylesheet" type="text/css" href="print.css"/>
			<xsl:apply-templates select="document('options.xml',.)/options/addJavaScript | options/addJavaScript" />
		</head>
		<body>
			<noscript>
				<p class="Body"><xsl:call-template name="javascriptDisabledMessage" /></p>
				<hr width="100%"/>
			</noscript>
			<div id="styleDivTitle">
				<xsl:apply-templates select="name" mode="viheading"/>
				<xsl:call-template name="owningPalette" />
				<xsl:call-template name="installedWith" />
				<xsl:apply-templates select="shortDescription | longDescription"/>
				<xsl:call-template name="detailsExamplesLinks" />
				<xsl:apply-templates select="visionImageInfo"/>
				<xsl:call-template name="connectorPane"/>
				<xsl:apply-templates select="name[not(../buttons)]" mode="placeFind" />
				<xsl:apply-templates select="buttons"/>
			</div>
			<div id="styleDivScrolling">
				<xsl:apply-templates select="parameters"/>
				<xsl:apply-templates select="details"/>
				<xsl:apply-templates select="examples"/>
				
			</div>
		</body>
	</html>
</xsl:template>

<xsl:template name="javascripts">
	<xsl:apply-templates select="document('options.xml',.)/options/JSVar" />
	<xsl:if test="not(document('options.xml',.)/options/showFeedbackLink)">
		<script type="text/javascript">var nofeedbacklink = true;</script>
	</xsl:if>
	<script src="common.js" type="text/javascript" />
</xsl:template>

<xsl:template match="constant">
	<html>
		<head>
			<script type="text/javascript">
			         var L_helpType = "<xsl:call-template name="helpType" />";
      			</script>
			<link rel="STYLESHEET" type="text/css" href="minimal.css"/>
			<xsl:call-template name="javascripts" />
			<meta name="department" content="Engineering"/>
			<xsl:apply-templates select="name" mode="title"/>
			<link media="print" rel="stylesheet" type="text/css" href="print.css"/>
			<xsl:apply-templates select="document('options.xml',.)/options/addJavaScript | options/addJavaScript" />
		</head>
		<body>
			
			<noscript>
				<p class="Body"><xsl:call-template name="javascriptDisabledMessage" /></p>
				<hr width="100%"/>
			</noscript>
			
			<xsl:apply-templates select="name" mode="heading"/>
			<xsl:call-template name="owningPalette" />
			<xsl:call-template name="installedWith" />
			<xsl:apply-templates select="shortDescription | longDescription"/>
			<!-- [KS] The links down to details and examples should go here, right? 
			[KS 6-12] Don't need them. Deleting for now.
			-->
			<xsl:apply-templates select="visionImageInfo"/>
			<xsl:call-template name="connectorPane"/>
			<xsl:apply-templates select="name[not(../buttons)]" mode="placeFind" />
			<xsl:apply-templates select="buttons"/>
		</body>
	</html>
</xsl:template>

<xsl:template match="/polyvi">
	<html>
		<head>
			<script type="text/javascript">
			         var L_helpType = "<xsl:call-template name="helpType" />";
      			</script>
			<link rel="STYLESHEET" type="text/css" href="minimal.css"/>
			<xsl:call-template name="javascripts" />
			<script src="cssframes.js" type="text/javascript"/>
			<script src="polyviselect.js" type="text/javascript"/>
			<meta name="department" content="Engineering"/>
			<xsl:apply-templates select="name" mode="vititle"/>
			<link media="print" rel="stylesheet" type="text/css" href="print.css"/>
			<xsl:apply-templates select="document('options.xml',.)/options/addJavaScript | options/addJavaScript" />
		</head>
		<body>
			
			<noscript>
				<p class="Body"><xsl:call-template name="javascriptDisabledMessage" /></p>
				<hr width="100%"/>
			</noscript>
			<div id="styleDivTitle">
				<xsl:apply-templates select="name" mode="viheading"/>
				<xsl:call-template name="owningPalette" />
				<xsl:call-template name="installedWith" />
				<xsl:apply-templates select="shortDescription | longDescription"/>
				<xsl:apply-templates select="instances" mode="selector"/>
				<xsl:apply-templates select="name[not(../buttons)]" mode="placeFind" />
				<xsl:apply-templates select="buttons"/>
				<xsl:call-template name="detailsExamplesLinks" />
			</div>
			<div id="styleDivScrolling">
				<xsl:apply-templates select="instances" mode="content"/>
				<xsl:apply-templates select="parameters"/>
				<xsl:apply-templates select="details"/>
				<xsl:apply-templates select="examples"/>
			</div>
		</body>
	</html>
</xsl:template>

<xsl:template match="instances" mode="selector" xml:space="preserve">
	<p class="Body"><xsl:call-template name="usePullDownStatemant" /></p>
	<table class="Borderless">
		<tr>
	   	<td>
		<select name="site" size="1" onchange="polyVISelectHandler(this)">
			<option value=""><xsl:call-template name="selectInstanceOption" /></option>
			<xsl:apply-templates mode="selector" />
		</select>
		</td>
		</tr>
	</table>
</xsl:template>

<xsl:template match="refVI" mode="selector">
	<!--<xsl:variable name="viDocPath" select="concat($viDocPathBase, '/', @fileName)"/>
	<xsl:variable name="viNode" select="document($viDocPath)/vi"/>-->
	<xsl:variable name="viNode" select="document(@fileName)/vi"/>
	<xsl:variable name="strippedVIFileName">
	      <xsl:call-template name="removeVIExt">
		      <xsl:with-param name="string" select="$viNode/@name"/>
	      </xsl:call-template>
   	</xsl:variable>
   	<option>
		<xsl:attribute name="value">#<xsl:value-of select="translate($strippedVIFileName, ' ', '')" /></xsl:attribute>
		<xsl:call-template name="getInstanceTitle" />
	</option>
</xsl:template>

<xsl:template match="instances" mode="content">
	<xsl:apply-templates mode="content"/>
</xsl:template>

<xsl:template match="refVI" mode="content">
	<xsl:variable name="viNode" select="document(@fileName)/vi"/>
	<xsl:variable name="strippedVIFileName">
	      <xsl:call-template name="removeVIExt">
		      <xsl:with-param name="string" select="$viNode/@name"/>
	      </xsl:call-template>
   	</xsl:variable>
	
	<xsl:apply-templates select="$viNode" mode="instance">
		<xsl:with-param name="strippedVIFileName"  select="$strippedVIFileName" />
		<xsl:with-param name="instanceTitle"><xsl:call-template name="getInstanceTitle" /></xsl:with-param>
	</xsl:apply-templates>
</xsl:template>

<xsl:template name="getInstanceTitle">
	<xsl:variable name="viNode" select="document(@fileName)/vi"/>
	<xsl:choose>
		<xsl:when test="text()">
			<xsl:value-of select="." />
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="removeVIExt">
				<xsl:with-param name="string" select="$viNode/name"/>
			</xsl:call-template>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="vi" mode="instance">
	<xsl:param name="strippedVIFileName" />
	<xsl:param name="instanceTitle" />
	<a>
		<xsl:attribute name="name">
			<xsl:value-of select="translate($strippedVIFileName, ' ', '')"/>
		</xsl:attribute>
	</a>
	<h2><xsl:value-of select="$instanceTitle" /></h2>
	<xsl:apply-templates select="shortDescription | longDescription"/>
	<xsl:call-template name="detailsExamplesLinks">
		<xsl:with-param name="strippedVIFileName"  select="$strippedVIFileName" />
		<xsl:with-param name="instanceTitle" select="$instanceTitle" />
	</xsl:call-template>
	<xsl:call-template name="connectorPane" />
	<xsl:apply-templates select="parameters" />
	<xsl:apply-templates select="details">
		<xsl:with-param name="strippedVIFileName"  select="$strippedVIFileName" />
		<xsl:with-param name="instanceTitle" select="$instanceTitle" />
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="palette">
	<html>
		<head>
			<link rel="STYLESHEET" type="text/css" href="minimal.css"/>
			<xsl:call-template name="javascripts"/>
			<meta name="department" content="Engineering"/>
			<xsl:apply-templates select="name" mode="title"/>
			<link media="print" rel="stylesheet" type="text/css" href="print.css"/>
			<xsl:apply-templates select="document('options.xml',.)/options/addJavaScript | options/addJavaScript"/>
		</head>
		<body>
			
			<noscript>
				<p class="Body">
					<xsl:call-template name="javascriptDisabledMessage"/>
				</p>
				<hr width="100%"/>
			</noscript>
			
			<xsl:apply-templates select="name" mode="heading"/>
			<xsl:call-template name="owningPalette" />
			<xsl:call-template name="installedWith" />
			<xsl:apply-templates select="editionInfo" />
			<xsl:apply-templates select="shortDescription | longDescription"/>
			<xsl:call-template name="detailsExamplesLinks"/>
			<xsl:apply-templates select="objects"/>
			<xsl:apply-templates select="subPalettes"/>
			<xsl:apply-templates select="details"/>
			<xsl:apply-templates select="examples"/>
			<xsl:apply-templates select="docCommentStatement"/>
			<xsl:apply-templates select="copyrightStatement"/>
		</body>
	</html>
</xsl:template>

<xsl:template name="owningPalette">
	<xsl:if test="$owningPalette">
		<xsl:call-template name="owningPaletteHeading" /><xsl:text> </xsl:text> 
		<a>
			<xsl:attribute name="href">
				<xsl:call-template name="removeFileExt">
					<xsl:with-param name="string" select="$owningPalette" />
					<xsl:with-param name="ext" select="'xml'" />
				</xsl:call-template>.html</xsl:attribute>
			<xsl:value-of select="document($owningPalette, .)/*/name" />
		</a>
		<br/>
	</xsl:if>
</xsl:template>

<xsl:template name="installedWith">
	<xsl:choose>
		<xsl:when test="document('options.xml',.)/options/disableInstalledWith"/>		
		<xsl:when test="@installedWith">
			<xsl:call-template name="installedWithHeading" /><xsl:text> </xsl:text> 		
			<xsl:variable name="productName">
				<xsl:value-of select="@installedWith"/>
			</xsl:variable>
			<xsl:for-each select="document('options.xml',.)/options/products/product/@id">
				<xsl:if test=".=$productName">
					<xsl:value-of select="document('options.xml',.)/options/products/product"/>
				</xsl:if>
			</xsl:for-each>
	    </xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="installedWithHeading" /><xsl:text> </xsl:text> 		
		    <xsl:apply-templates select="document('options.xml',.)/options/products/product"/>
		</xsl:otherwise>
    </xsl:choose>
</xsl:template>

<xsl:template match="product">
	<xsl:if test="@default='yes'">
		<xsl:value-of select="."/>
	</xsl:if>	
</xsl:template>

<xsl:template match="objects">
	<table class="Bordered">
		<tr>
			<th class="Bordered"><xsl:call-template name="paletteObjectHeading" /></th>
			<th class="Bordered"><xsl:call-template name="descriptionHeading" /></th>
		</tr>
		<xsl:apply-templates mode="paletteObjects"/>
	</table>
	<br/>
	<br/>
</xsl:template>

<xsl:template match="subPalettes">
	<table class="Bordered">
		<tr>
			<th class="Bordered"><xsl:call-template name="subpaletteHeading" /></th>
			<th class="Bordered"><xsl:call-template name="descriptionHeading" /></th>
		</tr>
		<xsl:apply-templates mode="paletteObjects"/>
	</table>
	
</xsl:template>

<xsl:template match="refPalette | refVI | refPolyVI | refConstant | refObject" mode="paletteObjects">
	<tr>
		<td class="Bordered">
			<a>
				<xsl:attribute name="href">
					<xsl:if test="@chm"><xsl:value-of select="@chm"/>::/</xsl:if>
					<xsl:call-template name="removeFileExt">
						<xsl:with-param name="string" select="@fileName" />
						<xsl:with-param name="ext" select="'xml'" />
					</xsl:call-template>.html</xsl:attribute>
				<xsl:call-template name="removeFileExt">
					<xsl:with-param name="string" select="document(@fileName)/*/name" />
					<xsl:with-param name="ext" select="'vi'" />
				</xsl:call-template>
			</a>
		</td>
		<td class="Bordered">
			<xsl:apply-templates select="document(@fileName)/*/shortDescription" mode="paletteObjects"/>
		</td>
	</tr>
</xsl:template>

<xsl:template match="shortDescription" mode="paletteObjects">
	<xsl:apply-templates select="*" mode="paletteObjectBlocks" />
</xsl:template>

<!-- Overriding tableBlocks templates so we don't get the append="true" paras in the palette objects table. -->

<!-- Default to the corresponding tableBlocks template if another doesn't exist. -->
<xsl:template match="*" mode="paletteObjectBlocks">
	<xsl:apply-templates select="." mode="descTableBlocks" />
</xsl:template>

<!-- Overriding templates for the last shortDescription para so it doesn't try to append the first longDescription para -->
<xsl:template match="shortDescription/*[position()=last() and self::para]" mode="paletteObjectBlocks">
	<p>
		<xsl:attribute name="class">noBottomMargin <xsl:apply-templates select="@checkFile" /></xsl:attribute>
		<xsl:apply-templates />
	</p>
</xsl:template>

<xsl:template match="shortDescription/*[position()=1 and position()=last() and self::para]" mode="paletteObjectBlocks">
	<p>
		<xsl:attribute name="class">noTopMargin noBottomMargin <xsl:apply-templates select="@checkFile" /></xsl:attribute>
		<xsl:apply-templates />
	</p>
</xsl:template>

<xsl:template match="object" mode="paletteObjects">
   <tr>
      <td class="Bordered">
         <a>
            <xsl:attribute name="href">
               <xsl:value-of select="@href" />
            </xsl:attribute>
            <xsl:apply-templates select="name" />
         </a>
      </td>
      <td class="Bordered">
         <xsl:apply-templates select="shortDescription" mode="paletteObjects" />
      </td>
   </tr>
</xsl:template>

<xsl:template match="object/name">
   <xsl:apply-templates />
</xsl:template>

<xsl:template match="copyrightStatement">
   <p class="Body">&#169; <xsl:value-of select="@from" /><xsl:apply-templates select="@to" /> National Instruments Corporation. <xsl:call-template name="allRightsReserved" /></p>
</xsl:template>

<xsl:template match="@to">&#8211;<xsl:value-of select="." /></xsl:template>

<xsl:template match="docCommentStatement">
   <p class="Body">To comment on National Instruments documentation, refer to the <a href="javascript:WWW(WWW_Feedback)">National Instruments Web site</a>.</p>
</xsl:template>

<xsl:template match="editionInfo">
   <xsl:variable name="month">
      <xsl:choose>
         <xsl:when test="@month=1"><xsl:call-template name="month1" /></xsl:when>
         <xsl:when test="@month=2"><xsl:call-template name="month2" /></xsl:when>
         <xsl:when test="@month=3"><xsl:call-template name="month3" /></xsl:when>
         <xsl:when test="@month=4"><xsl:call-template name="month4" /></xsl:when>
         <xsl:when test="@month=5"><xsl:call-template name="month5" /></xsl:when>
         <xsl:when test="@month=6"><xsl:call-template name="month6" /></xsl:when>
         <xsl:when test="@month=7"><xsl:call-template name="month7" /></xsl:when>
         <xsl:when test="@month=8"><xsl:call-template name="month8" /></xsl:when>
         <xsl:when test="@month=9"><xsl:call-template name="month9" /></xsl:when>
         <xsl:when test="@month=10"><xsl:call-template name="month10" /></xsl:when>
         <xsl:when test="@month=11"><xsl:call-template name="month11" /></xsl:when>
         <xsl:when test="@month=12"><xsl:call-template name="month12" /></xsl:when>
      </xsl:choose>
   </xsl:variable>
   <p class="Body">
   	<xsl:call-template name="outputEditionDateAndPartNum">
   		<xsl:with-param name="month" select="$month" />
   	</xsl:call-template>
   </p>  
</xsl:template>

</xsl:stylesheet>
