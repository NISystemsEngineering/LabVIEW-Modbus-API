<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="examplesLinkText">Examples</xsl:template>
<xsl:template name="detailsLinkText">Details</xsl:template>
<xsl:template name="instanceDetailsLinkText">Instance Details</xsl:template>
<xsl:template name="helpType">STD_ENG</xsl:template>
<xsl:template name="appendVItotitleheading"> VI</xsl:template>
<xsl:template name="showFeedbackLink"/>

<xsl:template match="visionImageInfo">
	<p class="anchor">
		<xsl:if test="VisionU8">
			<img src="Vision_U8.gif"/>
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:if test="VisionU16">
			<img src="Vision_U16.gif"/>
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:if test="VisionRGBU32">
			<img src="Vision_RGBU32.gif"/>
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:if test="VisionI16">
			<img src="Vision_I16.gif"/>
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:if test="VisionRGBU64">
			<img src="Vision_RGBU64.gif"/>
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:if test="VisionSGL">
			<img src="Vision_SGL.gif"/>
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:if test="VisionCSG">
			<img src="Vision_CSG.gif"/>
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:if test="VisionHSLU32">
			<img src="Vision_HSLU32.gif"/>
			<xsl:text> </xsl:text>
		</xsl:if>
	</p>
</xsl:template>

<xsl:template match="examples">
	<a name="Examples"/>
	<h2>Examples</h2>
	<xsl:apply-templates select="para"/>
	<ul>
		<xsl:apply-templates select="example"/>
	</ul>
</xsl:template>

<xsl:template match="example">
	<xsl:apply-templates select="para"/>
	<li>
		<span class="monospace">
			<xsl:value-of select="path"/>
		</span>
		<br/>
		<br/>
		<xsl:apply-templates select="openExample"/>
		<xsl:apply-templates select="browseExample"/>
	</li>
</xsl:template>

<xsl:template match="details">
	<xsl:param name="strippedVIFileName" />
	<xsl:param name="instanceTitle" />
	<xsl:variable name="instanceTitleWithSpace">
		<xsl:value-of select="$instanceTitle" /><xsl:if test="$instanceTitle != ''"><xsl:text> </xsl:text></xsl:if>
	</xsl:variable>
	<xsl:variable name="detailsHeadingTagName">
		<xsl:choose>
			<xsl:when test="$instanceTitle != ''">h3</xsl:when>
			<xsl:otherwise>h2</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>		
	<a>
	<xsl:attribute name="name"><xsl:value-of select="translate($strippedVIFileName, ' ', '')" />Details</xsl:attribute>
	</a>
	<xsl:element name="{$detailsHeadingTagName}"><xsl:value-of select="$instanceTitleWithSpace" /><xsl:call-template name="detailsLinkText" /></xsl:element>
	<xsl:apply-templates/>
</xsl:template>

<xsl:template name="detailsExamplesLinks">
	<xsl:param name="strippedVIFileName" />
	<xsl:param name="instanceTitle" />
	<xsl:variable name="instanceTitleWithSpace">
		<xsl:value-of select="$instanceTitle" /><xsl:if test="$instanceTitle != ''"><xsl:text> </xsl:text></xsl:if>
	</xsl:variable>
	<xsl:if test="details | examples">
		<p class="Body">
			<xsl:if test="details">
				<a>
					<xsl:attribute name="href">#<xsl:value-of select="translate($strippedVIFileName, ' ', '')" />Details</xsl:attribute>
					<xsl:choose>
						<xsl:when test="$instanceTitle != ''"><xsl:call-template name="instanceDetailsLinkText" /></xsl:when>
						<xsl:otherwise><xsl:call-template name="detailsLinkText" /></xsl:otherwise>
					</xsl:choose>
				</a>
				<xsl:text> </xsl:text>
			</xsl:if>
			
			<xsl:if test="examples">
				<a href="#Examples"><xsl:call-template name="examplesLinkText" /></a>
			</xsl:if>
		</p>
	</xsl:if>
</xsl:template>

<xsl:template match="append">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="/*/shortDescription | /*/longDescription"><xsl:apply-templates select="*"/></xsl:template>

<xsl:template name="connectorPane">
	<xsl:if test="not(options/hideConnPane)">
	<p class="Anchor">
	<img>
		<!-- [KS] The VI name needs to be based on the attribute rather than the contents of the name tag.
		Otherwise, you'll need gifs with different filenames when this stuff is localized. Extra note here
		since that's a functionality change.
		-->
		<xsl:variable name="viName">
			<xsl:call-template name="removeVIExt">
				<xsl:with-param name="string" select="@name"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="viNameUnderscored">
			<xsl:call-template name="massReplace">
			      <xsl:with-param name="string" select="translate($viName, ' ', '_')" />
			      <xsl:with-param name="parameterSetsFile">llbchars.xml</xsl:with-param>
   			</xsl:call-template>
		</xsl:variable>	   
		<xsl:attribute name="src">
			<xsl:call-template name="cleanUpPathSlashesForURL">
				<xsl:with-param name="path" select="document('options.xml',.)/options/connPanesSubDir/@path" />
				<xsl:with-param name="addTrailingSlash" select="1" />
			</xsl:call-template>
			<xsl:choose>
			<xsl:when test="@altConnectorPane">
				<xsl:value-of select="@altConnectorPane"/>
			</xsl:when>
				<xsl:otherwise>
			<xsl:value-of select="$viNameUnderscored" />.gif</xsl:otherwise>
			</xsl:choose></xsl:attribute>
		<xsl:attribute name="alt"><xsl:value-of select="$viName" /></xsl:attribute>
	</img>
	</p>
	</xsl:if>
</xsl:template>

<xsl:template match="/*/name" mode="title">
	<title>
		<xsl:call-template name="removeVIExt">
			<xsl:with-param name="string" select="."/>
		</xsl:call-template>
	</title>
</xsl:template>
<xsl:template match="/*/name" mode="vititle">
	<title>
		<xsl:call-template name="removeVIExt">
			<xsl:with-param name="string" select="."/>
		</xsl:call-template>
		<xsl:call-template name="appendVItotitleheading"/>
	</title>
</xsl:template>
<xsl:template match="/*/name" mode="heading">
	<h1>
		<xsl:call-template name="removeVIExt">
			<xsl:with-param name="string" select="."/>
		</xsl:call-template>
		<xsl:text> </xsl:text>
		<xsl:apply-templates select="/*/append"/>
	</h1>
</xsl:template>
<xsl:template match="/*/name" mode="viheading">
	<h1>
		<xsl:call-template name="removeVIExt">
			<xsl:with-param name="string" select="."/>
		</xsl:call-template>
		<xsl:call-template name="appendVItotitleheading"/>
		<xsl:apply-templates select="/*/append"/>
	</h1>
</xsl:template>	

<xsl:template match="/options/addJavaScript">
	<script type="text/javascript">
	<xsl:attribute name="src"><xsl:value-of select="@path" /></xsl:attribute>
	</script>
</xsl:template>

<xsl:template match="/options/JSVar[@type='string']">
	<script type="text/javascript">
	var <xsl:value-of select="@name" /> = "<xsl:value-of select="." />";
	</script>
</xsl:template>

<xsl:template match="/options/JSVar[@type='number']">
	<script type="text/javascript">
	var <xsl:value-of select="@name" /> = <xsl:value-of select="." />;
	</script>
</xsl:template>

<xsl:template match="addJavaScript">
	<xsl:variable name="path" select="@path" />
	<xsl:if test="not(document('options.xml',.)/options/addJavaScript[@path=$path])">
		<script type="text/javascript">
		<xsl:attribute name="src"><xsl:value-of select="@path" /></xsl:attribute>
		</script>
	</xsl:if>
</xsl:template>

<xsl:template match="name" mode="placeFind">
	<xsl:if test="../options/showPlaceFind or 
		       (not(../options/hidePlaceFind) and 
		       document('options.xml',.)/options/showPlaceFind)">
		<xsl:variable name="placeFindString">
			<xsl:call-template name="replaceProblemChars">
				<xsl:with-param name="string">
					<xsl:call-template name="replace">
						<xsl:with-param name="string">
							<xsl:call-template name="escapeForURL"><xsl:with-param name="string" select="." /></xsl:call-template>
						</xsl:with-param>
						<xsl:with-param name="find">'</xsl:with-param>
						<xsl:with-param name="replacewith">\'</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:variable>
		<xsl:call-template name="placeFindButtons">
			<xsl:with-param name="JSParam">'<xsl:value-of select="$placeFindString" />'</xsl:with-param>
		</xsl:call-template>    
	</xsl:if>
</xsl:template>

<xsl:template name="replaceProblemChars">
	<xsl:param name="string" />
	<xsl:variable name="helpType"><xsl:call-template name="helpType" /></xsl:variable>

	<xsl:choose>
		<xsl:when test="substring($helpType,5) = 'JPN' or substring($helpType,5) = 'KOR' or not(document('options.xml',.)/options/convertLigatures)">
			<xsl:value-of select="$string" />
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="massReplace">
				<xsl:with-param name="string" select="$string" />
				<xsl:with-param name="parameterSetsFile">ligatures.xml</xsl:with-param>
			</xsl:call-template>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>
