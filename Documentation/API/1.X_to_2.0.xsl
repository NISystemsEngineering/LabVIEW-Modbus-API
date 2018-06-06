<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:import href="identityXForm.xsl"/>
	
	<xsl:output method="xml"
		    indent="yes" 
		    encoding="iso-8859-1" />
		    
	<xsl:template match="processing-instruction()">
		<xsl:copy>
			<xsl:apply-templates select="@*" />
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match="processing-instruction('xml-stylesheet')[/vi or /polyvi or /constant or /palette]">
		<xsl:processing-instruction name="xml-stylesheet">
			<xsl:text>type="text/xsl" href="VI_to_HTML.xsl"</xsl:text>
		</xsl:processing-instruction>
	</xsl:template>
	
	<xsl:template match="/parameters | /vi | /polyvi | /constant | /palette">
		<xsl:copy>
			<xsl:attribute name="xml:space">preserve</xsl:attribute>
			<xsl:apply-templates select="@*" />
			<xsl:apply-templates />
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match="instances/instanceRef | viRef">
		<refVI>
			<xsl:apply-templates select="@*" />
		</refVI>
	</xsl:template>
	
	<xsl:template match="instances/instanceRef[node()]">
		<refVI>
			<xsl:apply-templates select="@*" />
			<xsl:apply-templates />
		</refVI>
	</xsl:template>
	
	<xsl:template match="polyRef | polyVIRef">
		<refPolyVI>
			<xsl:apply-templates select="@*" />
		</refPolyVI>
	</xsl:template>
	
	<xsl:template match="paletteRef">
		<refPalette>
			<xsl:apply-templates select="@*" />
		</refPalette>
	</xsl:template>
	
	<xsl:template match="constantRef">
		<refPalette>
			<xsl:apply-templates select="@*" />
		</refPalette>
	</xsl:template>
	
	<xsl:template match="functionRef">
		<refFunction>
			<xsl:apply-templates select="@*" />
		</refFunction>
	</xsl:template>
	
	<xsl:template match="expressVIRef">
		<refExpressVI>
			<xsl:apply-templates select="@*" />
		</refExpressVI>
	</xsl:template>
	
	<xsl:template match="parameterRef">
		<refParameter>
			<xsl:apply-templates select="@*" />
		</refParameter>
	</xsl:template>
	
	<xsl:template match="polyRef/@href | polyVIRef/@href | viRef/@href | constantRef/@href | instanceRef/@href | paletteRef/@href">
		<xsl:if test="not(../@fileName)">
			<xsl:attribute name="fileName"><xsl:value-of select="." /></xsl:attribute>
		</xsl:if>
	</xsl:template>


</xsl:stylesheet>
