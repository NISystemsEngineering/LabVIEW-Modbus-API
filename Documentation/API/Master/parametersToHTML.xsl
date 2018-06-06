<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="enumsToHTML.xsl" />

<xsl:template match="refParameter">
	<!-- This varible lets each child identify its parent-->
	<xsl:param name="fileName">parameters.xml</xsl:param>
	<xsl:variable name="child_number">
		<xsl:value-of select="@id"/>
	</xsl:variable>
	<xsl:if test="not(document($fileName, .)/parameters/parameter[@id=$child_number])"><xsl:message terminate="yes">Parameter id &quot;<xsl:value-of select="$child_number"/>&quot; not found in <xsl:value-of select="$fileName"/>.</xsl:message></xsl:if>
	<xsl:apply-templates select="document($fileName, .)/parameters/parameter[@id=$child_number]"/>
</xsl:template>

<xsl:template match="parameter">
	<tr>
		<td>
			<img>
				<xsl:attribute name="src">
					<xsl:call-template name="cleanUpPathSlashesForURL">
						<xsl:with-param name="path" select="document('options.xml',.)/options/datatypesSubDir/@path" />
						<xsl:with-param name="addTrailingSlash" select="1" />
					</xsl:call-template><xsl:value-of select="@img"/></xsl:attribute>
				<xsl:attribute name="alt"><xsl:value-of select="@img"/></xsl:attribute>
			</img>
		</td>
		<td>
			<xsl:apply-templates select="shortDescription | longDescription | enum | ring | subParameters" />
		</td>
	</tr>
</xsl:template>

<xsl:template match="parameters | subParameters">
	<table class="Borderless">
		<xsl:apply-templates />
	</table>
</xsl:template>

<xsl:template match="/parameters">
   <html>
      <head>
         <meta name="department" content="Engineering" />
         <xsl:apply-templates select="name" mode="title" />
         <link rel="STYLESHEET" type="text/css" href="minimal.css" />
         <link media="print" rel="stylesheet" type="text/css" href="print.css" />
      </head>
      <body>
         <h1>All Parameters</h1>
         <p>**Instructions for creating VI list here**</p>
         <table class="Borderless">
         <xsl:apply-templates select="parameter" mode="paramList">
            <xsl:sort select="name" />
            <xsl:sort select="img" />
            <xsl:sort select="shortDescription" />
         </xsl:apply-templates>
         </table>
      </body>
   </html>
</xsl:template>

<xsl:template match="parameter" mode="paramList">
	<xsl:variable name="id" select="@id" />
	<tr>
		<xsl:if test="position() mod 2 = 0">
			<xsl:attribute name="style">background-color:#DDDDDD</xsl:attribute>
		</xsl:if>
		<td class="Icon">
			<a name="{@id}" />
			<img>
				<xsl:attribute name="src">
					<xsl:call-template name="cleanUpPathSlashesForURL">
						<xsl:with-param name="path" select="document('options.xml',.)/options/datatypesSubDir/@path" />
						<xsl:with-param name="addTrailingSlash" select="1" />
					</xsl:call-template><xsl:value-of select="@img"/></xsl:attribute>
			<xsl:attribute name="alt"><xsl:value-of select="@img"/></xsl:attribute>
			</img>
		</td>
		<td>
		<xsl:apply-templates select="shortDescription | longDescription | enum | ring | subParameters" />
		<br /><br /><strong>ID: </strong><xsl:value-of select="$id" />&#160;
		<xsl:if test="not(/parameters/quickPreview)">
		<xsl:for-each select="document('allVIs.xml',.)/allvis/vi[document(@filename)/vi/parameters/refParameter[@id=$id]]">
			<xsl:if test="position()=1">
			<br /><br /><strong>Used in: </strong>
			</xsl:if>
			<a>
				<xsl:attribute name="href"><xsl:value-of select="@filename" /></xsl:attribute>
				<xsl:value-of select="@filename" />
			</a>
			<xsl:if test="position()!=last()">, </xsl:if>
		</xsl:for-each>
		<xsl:for-each select="/parameters/parameter[subParameters/refParameter[@id=$id]]">
			<xsl:if test="position()=1">
			<br /><br /><strong>SubParameter of: </strong>
			</xsl:if>
			<a>
				<xsl:attribute name="href">#<xsl:value-of select="@id" /></xsl:attribute>
				<xsl:value-of select="@id" />
			</a>
			<xsl:if test="position()!=last()">, </xsl:if>
		</xsl:for-each>
		</xsl:if>
		</td>
	</tr>
</xsl:template>




<xsl:template match="parameter/shortDescription" priority="9">
	<xsl:if test="not(*[position()=1 and self::para]/thisParameter) and document('options.xml',.)/options/requireThisParameterTag">
		<xsl:message terminate="yes">Parameter ID <xsl:value-of select="parent::*/@id"/>: The first paragraph of a parameter short description must contain at least one "thisParameter" tag. Remove the "requireThisParameter" tag from options.xml to suppress this error.
		</xsl:message>
	</xsl:if>
	<xsl:apply-templates select="*" mode="descTableBlocks" />
</xsl:template>

<xsl:template match="parameter/longDescription" priority="9">
	<xsl:apply-templates select="*" mode="descTableBlocks" />
</xsl:template>


</xsl:stylesheet>
