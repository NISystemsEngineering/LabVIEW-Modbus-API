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
		    
	<xsl:template match="parameter/shortDescription/*[position()=1 and self::para]">
		<para><xsl:apply-templates select="@*" /><thisParameter /><xsl:apply-templates /></para></xsl:template>
		


</xsl:stylesheet>
