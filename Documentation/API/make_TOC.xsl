<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" doctype-public="-//IETF//DTD HTML//EN" encoding="ISO-8859-1" />
	<xsl:preserve-space elements="*"/>
	<xsl:template match="TOC">
		<HTML>
			<HEAD>
				<meta name="GENERATOR">
					<xsl:attribute name="content">Microsoft<xsl:text>&amp;</xsl:text>reg; HTML Help Workshop 4.1</xsl:attribute>
				</meta>
				<xsl:comment> Sitemap 1.0 </xsl:comment>
			</HEAD>
			<BODY>
				<OBJECT type="text/site properties">
					<param name="FrameName" value="right"/>
					<param name="Window Styles" value="0x0225"/>
					<param name="comment" value="title:Online Help"/>
					<param name="comment" value="base:index.htm"/>
				</OBJECT>
				<UL>
					<!--<OBJECT type="text/sitemap">-->
						<xsl:apply-templates/>
					<!-- </OBJECT>-->
				</UL>
			</BODY>
		</HTML>
	</xsl:template>
	<xsl:template match="book">
		<!-- <xsl:text disable-output-escaping="yes">&lt;LI&gt;</xsl:text>-->
		<xsl:text disable-output-escaping="yes">&lt;LI&gt;</xsl:text><OBJECT type="text/sitemap">
			<param name="Name">
				<xsl:attribute name="value"><xsl:value-of select="name"/></xsl:attribute>
			</param>
			<param name="Local">
				<xsl:attribute name="value"><xsl:value-of select="fileName"/></xsl:attribute>
			</param>
		<!-- <xsl:text disable-output-escaping="yes">&lt;--></OBJECT><!--&gt;</xsl:text>-->
		<ul>
			<!-- <xsl:text disable-output-escaping="yes">&lt;LI&gt;</xsl:text>--><xsl:apply-templates/>
		</ul>
	</xsl:template>
	<xsl:template match="topics">
		<xsl:for-each select="refVI">
			<xsl:text disable-output-escaping="yes">&lt;LI&gt;</xsl:text>
			<OBJECT type="text/sitemap">
				<param name="Name">
					<xsl:attribute name="value"><xsl:value-of select="document(@fileName)//name"/></xsl:attribute>
				</param>
				<param name="Local">
					<xsl:attribute name="value"><xsl:value-of select="substring-before(@fileName,'.xml')"/>.html</xsl:attribute>
				</param>
			</OBJECT>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="name | fileName">
		<!-- -->
	</xsl:template>
</xsl:stylesheet>
