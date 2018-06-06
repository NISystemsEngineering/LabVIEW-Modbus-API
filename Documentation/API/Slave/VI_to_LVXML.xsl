<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- [KS] Do we really want to default to copying?
	[KS 6-12] Yes, we do.
	-->
	<xsl:import href="identityXform.xsl" />
	<xsl:import href="inlineToHTML.xsl" />
	<xsl:output encoding="ISO-8859-1" indent="yes" omit-xml-declaration="yes" method="xml"/>
	<xsl:variable name="fileName" select="string('parameters.xml')"/>
	
	<!-- [KS] Adding a helpTopic parameter because we're going to need to pass the real value of
	$helpTopic in on the command line because it can't really be figured out for instance VIs using XSL alone.
	We might want to do something other than default to the vi name to avoid broken links.
	-->
	<xsl:param name="helpTopic">
		<xsl:call-template name="removeVIExt">
			<xsl:with-param name="string" select="translate(/*/@name,' ','_')" />
		</xsl:call-template>.html</xsl:param>
	
	<xsl:template match="/vi | /polyvi">
		<vi>
			<!-- [KS] The name tag should just be copied over because the cxt help import tool
			uses it to generate a list of cases where that tag does not match the VI title. -->
			<xsl:apply-templates select="name" />
			<xsl:apply-templates select="shortDescription" />
			<helptopic><xsl:value-of select="$helpTopic"/></helptopic>
			<xsl:apply-templates select="parameters" mode="controls"/>
			<xsl:apply-templates select="parameters" mode="indicators"/>
		</vi>
	</xsl:template>
	
	
	<xsl:template match="name">
		<name><xsl:apply-templates /></name>
	</xsl:template>
	
	<xsl:template match="/*/shortDescription">
	<desc><xsl:apply-templates /></desc>
	</xsl:template>
	
	<xsl:template match="parameter/shortDescription">
		<xsl:if test="not(*[position()=1 and self::para]/thisParameter) and document('options.xml',.)/options/requireThisParameterTag">
			<xsl:message terminate="yes">Parameter ID <xsl:value-of select="parent::*/@id"/>: The first paragraph of a parameter short description must contain at least one "thisParameter" tag. Remove the "requireThisParameter" tag from options.xml to suppress this error.
			</xsl:message>
		</xsl:if>
		<desc><xsl:apply-templates /></desc>
	</xsl:template>
	
	<xsl:template match="parameters" mode="controls">
		<controls>
			<xsl:apply-templates select="refParameter" mode="control" />
		</controls>
	</xsl:template>
	
	<xsl:template match="parameters" mode="indicators">
		<indicators>
			<xsl:apply-templates select="refParameter" mode="indicator" />
		</indicators>
	</xsl:template>

	<xsl:template match="parameter">
		<!-- [KS] This change to the logic as to whether to output a <control> or <indicator> tag
		will make it easier for us to change it when that will be based on stuff besides the image filename. -->
		<xsl:variable name="controlOrIndicator">
			<xsl:choose>
				<xsl:when test="substring(@img,1,1) = 'c'">control</xsl:when>
				<xsl:otherwise>indicator</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:element name="{$controlOrIndicator}">
			<xsl:apply-templates select="@name" />
			<xsl:apply-templates select="shortDescription" />
			<xsl:apply-templates select="subParameters" />
		</xsl:element>
	</xsl:template>
		
	<xsl:template match="refParameter" mode="control">
		<xsl:variable name="id" select="@id" />
		<xsl:apply-templates select="document($fileName,.)/parameters/parameter[@id=$id][substring(@img,1,1) = 'c']" />
	</xsl:template>
	
	<xsl:template match="refParameter" mode="indicator">
		<xsl:variable name="id" select="@id" />
		<xsl:apply-templates select="document($fileName,.)/parameters/parameter[@id=$id][substring(@img,1,1) = 'i']" />
	</xsl:template>
	
	<xsl:template match="@name">
	<name><xsl:value-of select="." /></name>
	</xsl:template>

	<xsl:template match="subParameters">
		<xsl:apply-templates select="refParameter" mode="control" />
		<xsl:apply-templates select="refParameter" mode="indicator" />
	</xsl:template>
	
	<xsl:template match="shortDescription/para">
		<para><xsl:apply-templates/></para>
	</xsl:template>
	
	<xsl:template match="note">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="note/*[position()=1 and self::para and not(normalize-space(preceding-sibling::text()))]">
		<para><b>NOTE:</b><xsl:text> </xsl:text><xsl:apply-templates/></para>
	</xsl:template>

	<xsl:template match="note/node()[position()=1 and self::text() and normalize-space()]">
		<para><b>NOTE:</b><xsl:text> </xsl:text><xsl:value-of select="."/></para>
	</xsl:template>
	
	<xsl:template match="note/para[position()>1]">
		<para><xsl:apply-templates/></para>
	</xsl:template>
	
	<xsl:template match="tip">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="tip/*[position()=1 and self::para and not(normalize-space(preceding-sibling::text()))]">
		<para><b>TIP:</b><xsl:text> </xsl:text><xsl:apply-templates/></para>
	</xsl:template>
	
	<xsl:template match="tip/node()[position()=1 and self::text() and normalize-space()]">
		<para><b>TIP:</b><xsl:text> </xsl:text><xsl:value-of select="."/></para>
	</xsl:template>
	
	<xsl:template match="tip/para[position()>1]">
		<para><xsl:apply-templates/></para>
	</xsl:template>
	
	<xsl:template match="caution">
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="caution/*[position()=1 and self::para and not(normalize-space(preceding-sibling::text()))]">
		<para><b>CAUTION:</b><xsl:text> </xsl:text><xsl:apply-templates/></para>
	</xsl:template>
	
	<xsl:template match="caution/node()[position()=1 and self::text() and normalize-space()]">
		<para><b>CAUTION:</b><xsl:text> </xsl:text><xsl:value-of select="."/></para>
	</xsl:template>
	
	<xsl:template match="caution/para[position()>1]">
		<para><xsl:apply-templates/></para>
	</xsl:template>
	
</xsl:stylesheet>
