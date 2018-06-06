<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="VIXMLtoHTMLCore.xsl" />
<xsl:import href="blocksToHTML.xsl" />

<xsl:template match="enum | ring">
   <table class="Bordered">
      <xsl:apply-templates/>
   </table>
</xsl:template>

<xsl:template match="enumValue">
   <tr>
      <td class="Bordered">
         <xsl:apply-templates select="@name" />&#160;<xsl:apply-templates select="@value" />
      </td>
      <td class="Bordered">
         <xsl:apply-templates select="shortDescription" />
         <xsl:apply-templates select="longDescription" />
      </td>
   </tr>
</xsl:template>

<xsl:template match="ringValue">
   <tr>
      <td class="Bordered">
         <xsl:apply-templates select="name" />&#160;<xsl:apply-templates select="@value" />
      </td>
      <td class="Bordered">
         <xsl:apply-templates select="shortDescription" />
         <xsl:apply-templates select="longDescription" />
      </td>
   </tr>
</xsl:template>


<xsl:template match="enumValue/@value | ringValue/@value">(<xsl:value-of select="." />)</xsl:template>

<xsl:template match="enumValue/@name | ringValue/name"><strong><xsl:value-of select="." /></strong></xsl:template>

<xsl:template match="enumValue/shortDescription | enumValue/longDescription | ringValue/shortDescription | ringValue/longDescription">
	<xsl:apply-templates select="*" mode="descTableBlocks" />
</xsl:template>

</xsl:stylesheet>
