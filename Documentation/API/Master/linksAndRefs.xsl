<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:variable name="docElementName" select="name(/*)" />

<!-- [KS] When we add similar tags for instances, it needs to be smart enough to not make 
a link if transforming to anything other than a poly VI topic. -->

<xsl:template match="refVI | refPolyVI | refConstant | refObject | refPalette">
	<xsl:variable name="viName">
		<xsl:value-of select="document(@fileName,.)/*/name" />
	</xsl:variable>
	<a>
		<xsl:attribute name="href">
			<xsl:if test="@chm"><xsl:value-of select="@chm" />::/</xsl:if>
			<xsl:call-template name="removeFileExt">
				<xsl:with-param name="string" select="@fileName" />
				<xsl:with-param name="ext" select="'xml'" />
			</xsl:call-template>.html</xsl:attribute>
		<!-- [KS] It might be nice to use command-line params to create a sort of debug mode where 
		if you're just viewing an XML file in IE, the links go to .xml files instead of 
		switching the extention. -->
		<xsl:call-template name="removeFileExt">
			<xsl:with-param name="string" select="$viName" />
			<xsl:with-param name="ext" select="'vi'" />
		</xsl:call-template>
	</a>
</xsl:template>


<!-- [KS] Copying this over from DAQ XSL for safe keeping.
<xsl:template match="refInstance">
	<xsl:variable name="strippedVIFileName">
		<xsl:call-template name="removeVIExt">
			<xsl:with-param name="string" select="document(@instanceFile,.)/vi/@filename" />
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="instanceFile" select="@instanceFile" />
	<xsl:choose>
		<xsl:when test="$docElementName='polyvi'">
			<a>
				<xsl:attribute name="href">#<xsl:value-of select="translate($strippedVIFileName, ' ', '')" /></xsl:attribute>
				<xsl:value-of select="document(@polyVIFile,.)/polyvi/instances/refVI[@filename=$instanceFile]" />
			</a>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="document(@polyVIFile,.)/polyvi/instances/refVI[@filename=$instanceFile]" />
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>
-->

<xsl:template match="thisParameter">
   <xsl:choose>
      <xsl:when test="ancestor::parameter[1]/name">
         <strong><xsl:value-of select="ancestor::parameter[1]/name" /></strong>
      </xsl:when>
      <xsl:otherwise>
         <xsl:message terminate="yes"><xsl:text disable-output-escaping="yes">&lt;thisParameter&gt;</xsl:text> tag is valid only inside parameter and enum descriptions.</xsl:message>
      </xsl:otherwise>
   </xsl:choose>
</xsl:template>

</xsl:stylesheet>
