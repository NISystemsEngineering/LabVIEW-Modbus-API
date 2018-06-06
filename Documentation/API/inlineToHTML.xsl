<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:import href="stringParsing.xsl" />
<xsl:import href="identityXform.xsl" />
<xsl:import href="linksAndRefs.xsl" />



<!-- [KS] Why do most of these templates insert a space? This isn't going to 
work if people need to change character styles mid word. For example: 
<para>NI-DAQmx 8.<format type="Italic">x</format> blah blah</para>
will be transformed to:
<p class="Body">NI-DAQmx 8. <em>x</em> blah blah</p>

Is this meant to ensure a space in something like this:

<para><format type="bold">Some bold,</format> <format type="bold">then some italic</format></para>

If so, we can change all of these to look at the previous sibling and insert a space if necessary.

[KS 6-12] Yeah, it's for the above scenario with naked whitespace.

Finally, several templates in here appear to just be doing copies, 
like the templates for <a> and <span>. But, they aren't doing complete copies. It would probably be better
to just use copy them if that's what we mean. I've always used templates that copy all elements/attributes by
default, unless I have a specific template for that attribute.

[KS 6-12] Going to add identityXform.xsl

-->

<!-- Template for the @embed attribute so it doesn't get copied by the default template. -->
<xsl:template match="img/@embed" priority="5" />

<!-- This dialog box options. -->
<xsl:template match="dBOption | menu | menu_option | menu_path">
	<strong><xsl:apply-templates/></strong>
</xsl:template>

<xsl:template match="code">
	<p class="Body Monospace"><xsl:apply-templates/></p>
</xsl:template>

<!-- This formats directory paths. -->
<xsl:template match="directory|path">
	<span class="Monospace"><xsl:apply-templates/></span>
</xsl:template>

<xsl:template match="key">
	&lt;<xsl:apply-templates/>&gt;
</xsl:template>

<!-- <xsl:template match="parameter">
	<strong>
		<xsl:apply-templates/>
	</strong>
</xsl:template>-->

<!-- This formats the platform tags. -->
<xsl:template match="platform">
	<span class="Platform">
		<xsl:apply-templates/>
	</span>
</xsl:template>

<!-- These tags format characters using format tags where other content tags are not appropriate. -->
<xsl:template match="format">
		<xsl:choose>
		<xsl:when test="@type='bold'">
			<strong>
				<xsl:apply-templates/>
			</strong>
		</xsl:when>
		<xsl:when test="@type='italic'">
			<em>
				<xsl:apply-templates/>
			</em>
		</xsl:when>
		<xsl:when test="@type='italics'">
			<em>
				<xsl:apply-templates/>
			</em>
		</xsl:when>
		<xsl:when test="@type='bold-italic'">
			<strong>
				<em>
					<xsl:apply-templates/>
				</em>
			</strong>
		</xsl:when>
		<xsl:when test="@type='monospace'">
			<span class="Monospace">
				<xsl:apply-templates/>
			</span>
		</xsl:when>
		<xsl:when test="@type='monospace-bold'">
			<span class="Monospace-Bold">
				<xsl:apply-templates/>
			</span>
		</xsl:when>
		<xsl:when test="@type='monospace-italic'">
			<span class="Monospace-Italic">
				<xsl:apply-templates/>
			</span>
		</xsl:when>
		<xsl:when test="@type='monospace-bold-italic'">
			<strong>
				<span class="Monospace-Italic">
					<xsl:apply-templates/>
				</span>
			</strong>
		</xsl:when>
		<xsl:when test="@type='monospace-bold-italics'">
			<strong>
				<span class="Monospace-Italic">
					<xsl:apply-templates/>
				</span>
			</strong>
		</xsl:when>
		<xsl:when test="@type='subscript'">
			<sub>
				<xsl:apply-templates/>
			</sub>
		</xsl:when>
		<xsl:when test="@type='subscript-bold'">
			<sub>
				<strong>
					<xsl:apply-templates/>
				</strong>
			</sub>
		</xsl:when>
		<xsl:when test="@type='subscript-italic'">
			<sub>
				<em>
					<xsl:apply-templates/>
				</em>
			</sub>
		</xsl:when>
		<xsl:when test="@type='superscript'">
			<sup>
				<xsl:apply-templates/>
			</sup>
		</xsl:when>
		<xsl:when test="@type='superscript-bold'">
			<sup>
				<strong>
					<xsl:apply-templates/>
				</strong>
			</sup>
		</xsl:when>
		<xsl:when test="@type='superscript-italic'">
			<sup>
				<em>
					<xsl:apply-templates/>
				</em>
			</sup>
		</xsl:when>
		<!-- [KS] What's the point of <format type="symbol">? 
		[KS 6-12] It's to workaround a FrameMaker issue.
		-->
		<xsl:when test="@type='symbol'">
			<xsl:value-of select="."/>
		</xsl:when>
	<!--[KS] stick an <xsl:message> inside of <xsl:otherwise> here. -->
	</xsl:choose>
</xsl:template>



</xsl:stylesheet>
