<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:import href="inlineToHTML.xsl" />

<!-- Expose these in a top-level XSL for localization. -->
<xsl:template name="noteHeading">Note</xsl:template>
<xsl:template name="tipHeading">Tip</xsl:template>
<xsl:template name="cautionHeading">Caution</xsl:template>
<xsl:template name="warningHeading">Warning</xsl:template>
<xsl:template name="openExampleHeading">Open example</xsl:template>
<xsl:template name="browseRelatedExamplesHeading">Browse related examples</xsl:template>
<xsl:template name="placeObjectHeading">Place on the block diagram</xsl:template>
<xsl:template name="findObjectHeading">Find on the <strong>Functions</strong> palette</xsl:template>
<xsl:template name="figureHeading">Figure:</xsl:template> 

<xsl:template match="h2">
	<a>
		<xsl:attribute name="name">
			<xsl:call-template name="replace">
				<xsl:with-param name="string" select="."/>
				<xsl:with-param name="find" select="' '"/>
				<xsl:with-param name="replacewith" select="'_'"/>
			</xsl:call-template>
		</xsl:attribute>
	</a>
	<xsl:copy><xsl:apply-templates /></xsl:copy>
</xsl:template>


<!-- This formats the paragraphs. -->

<!-- [KS] The following template is never getting applied because the para template isn't applying templates on @* -->
<xsl:template match="para/@checkFile"> checkFile <xsl:value-of select="."/>&#160;</xsl:template>

<xsl:template match="@checkFile" mode="includeAttribute">
	<xsl:attribute name="class">checkFile <xsl:value-of select="."/></xsl:attribute>
</xsl:template>

<xsl:template match="th | td">
	<xsl:element name="{name()}">
		<xsl:apply-templates select="@*" />
		<xsl:apply-templates mode="tableBlocks" />
	</xsl:element>
</xsl:template>

<xsl:template match="para">
	<p>
		<xsl:apply-templates select="@checkFile" mode="includeAttribute"/>
		<xsl:apply-templates />
	</p>
</xsl:template>

<!-- Block level formatting for tags that end up inside table cells.
     The ordering of these templates is VERY IMPORTANT. -->

<!-- This template is needed to call the corresponding modeless template -->
<xsl:template match="*" mode="tableBlocks">
	<xsl:apply-templates select="." />
</xsl:template>

<xsl:template match="para" mode="tableBlocks">
	<p>
		<xsl:apply-templates select="@checkFile" mode="includeAttribute"/>
		<xsl:apply-templates />
	</p>
</xsl:template>

<!-- Need to look for node() rather than * for these 
     because the first thing in a <td> or <caution>/<note>/etc might not 
     be a tag at all. -->
<xsl:template match="node()[position()=1 and self::para]" mode="tableBlocks">
	<p>
		<xsl:attribute name="class">noTopMargin <xsl:apply-templates select="@checkFile" /></xsl:attribute>
		<xsl:apply-templates />
	</p>
</xsl:template>

<xsl:template match="node()[position()=last() and self::para]" mode="tableBlocks">
	<p>
		<xsl:attribute name="class">noBottomMargin <xsl:apply-templates select="@checkFile" /></xsl:attribute>
		<xsl:apply-templates />
	</p>
</xsl:template>

<xsl:template match="node()[position()=1 and position()=last() and self::para]" mode="tableBlocks">
	<p>
		<xsl:attribute name="class">noTopMargin noBottomMargin <xsl:apply-templates select="@checkFile" /></xsl:attribute>
		<xsl:apply-templates />
	</p>
</xsl:template>

<xsl:template match="caution/node()[position()=1 and self::para] |
                     warning/node()[position()=1 and self::para] |
                     tip/node()[position()=1 and self::para] |
                     note/node()[position()=1 and self::para]" mode="tableBlocks">
	<xsl:apply-templates />
</xsl:template>

<!-- Block level formatting for tags inside short/long description that end up inside table cells.
     The ordering of these templates is VERY IMPORTANT. 
     The latter templates have higher priority than the earlier ones. -->

<xsl:template match="*" mode="descTableBlocks">
	<xsl:apply-templates select="." />
</xsl:template>

<xsl:template match="shortDescription/*[position()=last() and self::para]">
	<p>
		<xsl:apply-templates select="@checkFile" mode="includeAttribute"/>
		<xsl:apply-templates />
		<xsl:apply-templates select="parent::*/parent::*/longDescription/*[position()=1 and self::para and @append='true']" mode="append" />
	</p>
</xsl:template>

<!-- Template to append the first thing in longDescription to the last thing in shortDescription, 
     if those things are paras and append="true" -->

<xsl:template match="longDescription/*[position()=1 and 
		     self::para and 
		     @append='true']" 
		     mode="append">
	<xsl:text> </xsl:text><xsl:apply-templates />
</xsl:template>

<!-- Template to hide the first element inside longDescription, IF that element is a para and append='true' -->
<xsl:template match="longDescription/*[position()=1 and self::para and @append='true']" />

<xsl:template match="shortDescription/para" mode="descTableBlocks">
	<xsl:variable name="includeNoTopMarginStyle"><xsl:if test="position()=1"><xsl:value-of select="true()" /></xsl:if></xsl:variable>
	<xsl:variable name="includeNoBottomMarginStyle">
		<xsl:if test="position()=last() and
			      not(parent::*/parent::*/longDescription/*[not(position()=1 and self::para and @append='true')]) and
			      not(parent::*/following-sibling::enum) and
			      not(parent::*/following-sibling::ring)"><xsl:value-of select="true()" /></xsl:if>
	</xsl:variable>
	<xsl:variable name="marginStyles">
		<xsl:if test="$includeNoTopMarginStyle = 'true'">noTopMargin</xsl:if>
		<xsl:if test="$includeNoTopMarginStyle = 'true' and $includeNoBottomMarginStyle = 'true'"><xsl:text> </xsl:text></xsl:if>
		<xsl:if test="$includeNoBottomMarginStyle = 'true'">noBottomMargin</xsl:if>
	</xsl:variable>
	<p>
	<xsl:choose>
		<xsl:when test="$includeNoTopMarginStyle = 'true' or $includeNoBottomMarginStyle = 'true'">
			<xsl:attribute name="class"><xsl:value-of select="$marginStyles" /><xsl:apply-templates select="@checkFile" /></xsl:attribute>
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates select="@checkFile" mode="includeAttribute"/>
		</xsl:otherwise>
	</xsl:choose>
	<xsl:apply-templates />
	<xsl:if test="position()=last()">
		<xsl:apply-templates select="parent::*/parent::*/longDescription/*[position()=1 and self::para and @append='true']" mode="append" />
	</xsl:if>
	</p>
</xsl:template>	

<xsl:template match="longDescription/para" mode="descTableBlocks">
	<xsl:variable name="includeNoBottomMarginStyle">
		<xsl:if test="position()=last() and
			      not(parent::*/following-sibling::enum) and
			      not(parent::*/following-sibling::ring)"><xsl:value-of select="true()" /></xsl:if>
	</xsl:variable>
	<xsl:variable name="marginStyles">
		<xsl:if test="$includeNoBottomMarginStyle = 'true'">noBottomMargin</xsl:if>
	</xsl:variable>
	<p>
	<xsl:choose>
		<xsl:when test="$includeNoBottomMarginStyle = 'true'">
			<xsl:attribute name="class"><xsl:value-of select="$marginStyles" /><xsl:apply-templates select="@checkFile" /></xsl:attribute>
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates select="@checkFile" mode="includeAttribute"/>
		</xsl:otherwise>
	</xsl:choose>
	<xsl:apply-templates />
	</p>
</xsl:template>	

<!-- Hides an appended para. Also overrides the previous template if the only thing inside longDescription
     is an appended para. -->
<xsl:template match="longDescription/*[position()=1 and self::para and @append='true']" mode="descTableBlocks" />


<!-- This formats bulletted lists and steps -->
<xsl:template match="oList">
	<ol>
		<xsl:apply-templates />
	</ol>
</xsl:template>

<xsl:template match="listItem">
	<li>
		<xsl:apply-templates select="@*" />
		<xsl:apply-templates />
	</li>
</xsl:template>

<xsl:template match="indent">
	<br/>
	<br/>
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="uList">
	<ul>
		<xsl:apply-templates select="@class" />
		<xsl:apply-templates />
	</ul>
</xsl:template>


<!-- This formats notes -->
<xsl:template match="note">
	<table class="Borderless">
		<tr>
			<td class="Icon">
				<img src="note.gif"/>
			</td>
			<td>
				<strong><xsl:call-template name="noteHeading" /></strong>&#160;&#160;<xsl:apply-templates mode="tableBlocks"/>
			</td>
		</tr>
	</table>
</xsl:template>

<!-- This formats the tips -->
<xsl:template match="tip">
	<table class="Borderless">
			<tr>
				<td class="Icon">
					<img src="tip.gif"/>
				</td>
				<td>
					<strong><xsl:call-template name="tipHeading" /></strong>&#160;&#160;<xsl:apply-templates mode="tableBlocks"/>
				</td>
			</tr>
	</table>
</xsl:template>

<!-- This formats the warning -->
<xsl:template match="warning">
	<table class="Borderless">
			<tr>
				<td class="Icon">
					<img src="caution.gif"/>
				</td>
				<td>
					<strong><xsl:call-template name="warningHeading" /></strong>&#160;&#160;<xsl:apply-templates mode="tableBlocks"/>
				</td>
			</tr>
	</table>
</xsl:template>

<!-- This formats the caution-->
<xsl:template match="caution">
	<table class="Borderless">
			<tr>
				<td class="Icon">
					<img src="caution.gif"/>
				</td>
				<td class="Dark-Red">
					<strong><xsl:call-template name="cautionHeading" /></strong>&#160;&#160;<xsl:apply-templates mode="tableBlocks"/>
				</td>
			</tr>
	</table>
</xsl:template>

<xsl:template match="longDescription/img | shortDescription/img">
	<p class="Anchor">
		<img><xsl:apply-templates select="@*" /></img>
	</p>
	<xsl:apply-templates />
</xsl:template>

<xsl:template match="img/caption">
	<p class="body">
		<strong><xsl:call-template name="figureHeading" /></strong><xsl:text> </xsl:text>
		<xsl:apply-templates />
	</p>
</xsl:template>


<!-- Show Me Find Me buttons -->
<xsl:template match="buttons">
	<xsl:call-template name="placeFindButtons">
		<xsl:with-param name="JSParam" select="@object" />
	</xsl:call-template>
</xsl:template>

<xsl:template name="placeFindButtons">
	<xsl:param name="JSParam" />
	<table class="Borderless">
		<tr>
			<td>
			<img src="minibutton.gif" alt="minibutton.gif">
				<xsl:attribute name="onClick">placeObject(<xsl:value-of select="$JSParam" />);</xsl:attribute>
			</img>
			&#160;<xsl:call-template name="placeObjectHeading" /></td>
			<td>
			<img src="minibutton.gif" alt="minibutton.gif">
				<xsl:attribute name="onClick">findObject(<xsl:value-of select="$JSParam" />);</xsl:attribute>
			</img>
			&#160;<xsl:call-template name="findObjectHeading" /></td>
		</tr>
	</table>
</xsl:template>


<!-- Example buttons -->
<xsl:template match="openExample">
	<xsl:choose>
		<xsl:when test="contains(@path, '.vi')">
			<xsl:variable name="path">javascript:openVI('<xsl:value-of select="@path"/>');</xsl:variable>
			<a>
				<xsl:attribute name="href"><xsl:value-of select="$path"/></xsl:attribute>
				<img src="minibutton.gif" border="0"/>
			</a>
		</xsl:when>
		<xsl:when test="contains(@path, '.lvproj')">
			<xsl:variable name="path">javascript:openProj('<xsl:value-of select="@path"/>');</xsl:variable>
			<a>
				<xsl:attribute name="href"><xsl:value-of select="$path"/></xsl:attribute>
				<img src="minibutton.gif" border="0"/>
			</a>
		</xsl:when>
		<xsl:otherwise>
			<xsl:variable name="path">javascript:openLLB('<xsl:value-of select="@path"/>');</xsl:variable>
			<a>
				<xsl:attribute name="href"><xsl:value-of select="$path"/></xsl:attribute>
				<img src="minibutton.gif" border="0"/>
			</a>
		</xsl:otherwise>
	</xsl:choose>
	&#160;<xsl:call-template name="openExampleHeading" />&#160;
</xsl:template>

<xsl:template match="browseExample">
	<xsl:variable name="id">javascript:findExamples(<xsl:value-of select="@id"/>);</xsl:variable>
	<a>
		<xsl:attribute name="href"><xsl:value-of select="$id"/></xsl:attribute>
		<img src="minibutton.gif" border="0"/>
	</a>
	&#160;<xsl:call-template name="browseRelatedExamplesHeading" />
</xsl:template>

</xsl:stylesheet>
