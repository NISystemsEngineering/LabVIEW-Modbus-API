<?xml version="1.0" encoding="ISO-8859-1"?>
<!-- LOCALIZE -->
<!-- edited with XMLSPY v2004 rel. 3 U (http://www.xmlspy.com) by Jonathan McCreless Roe (National Instruments) -->
<!-- 
ABOUT THIS XSL
This contains all the formats we use to transform XML files to HTML files. It's used by the help_topics.xsl, Features.xsl, and the various beta making XSLs.
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:strip-space elements="*"/>
	<xsl:preserve-space elements="format VI function express_VI method property event dialog_box constant palette child parent para li note tip warning directory path"/>
	<!--	<xsl:include href="search_replace.xsl"/>
	<xsl:include href="objects.xsl"/>-->
	
	

	<!-- This formats the headers within the contents tag. -->
	<xsl:template match="doc_title">
		<h1>
			<xsl:apply-templates/>
		</h1>
	</xsl:template>

	<!-- This formats the keywords section-->
	<!-- This formats each keyword -->
	<xsl:template match="meta_info/keywords/keyword">
		<xsl:value-of select="entry"/>
		<xsl:if test="sub_entry">:<xsl:choose>
				<xsl:when test="sub_entry/sub_entry">
					<xsl:copy>:<xsl:value-of select="sub_entry"/>
					</xsl:copy>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="sub_entry"/>
				</xsl:otherwise>
			</xsl:choose>;
		</xsl:if>
	</xsl:template>
	<xsl:template match="entry">
		<xsl:apply-templates/>
		<br/>
	</xsl:template>
	<xsl:template match="sub_entry">
		:
		<xsl:choose>
			<xsl:when test="sub_entry">
				<xsl:copy>:<xsl:value-of select="sub_entry"/>
				</xsl:copy>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="."/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="keyword">
		<!-- -->
	</xsl:template>
	<xsl:template match="TOC_Location">
		<p class="instruction">TOC Location: <xsl:value-of select="."/>
		</p>
	</xsl:template>
	
	
	
	<xsl:template match="connectorPane">
		<p class="Anchor">
			<img>
				<xsl:attribute name="src"><xsl:value-of select="@src"/></xsl:attribute>
			</img>
		</p>
	</xsl:template>
	
	<!-- start parent child tags: These are used to identify and render documentation that appears in more than one place in our documentation. Anything you place parent tags around can be referenced by a child tag. You do not need to include ANY documentation between child tags. The documentation from the parent appears in the tags automatically. NOTE: The parent/child tags in the Feature.xsl are unique to the form.-->
	<!-- start here parent tag. -->

	<!-- This refers to a section in a chapter or in another chapter -->
	<xsl:template match="section_reference">
		<xsl:variable name="section">
			<xsl:value-of select="@section"/>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="@xml_file">
				<em>
					<xsl:value-of select="document(@xml_file)//*[@id=$section]"/>
				</em>
			</xsl:when>
			<xsl:otherwise>
				<em>
					<xsl:value-of select="//*[@id=$section]"/>
				</em>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text> </xsl:text>
	</xsl:template>
	<!-- This refers to a the chapter number in another chapter. -->
	<xsl:template match="number_reference">
		<xsl:value-of select="document(@xml_file)//concept/chapter_number"/>
		<xsl:text> </xsl:text>
	</xsl:template>
	<!-- This refers to a the chapter number in another chapter. -->
	<xsl:template match="title_reference">
		<em>
			<xsl:value-of select="document(@xml_file)//concept/chapter_title"/>
			<xsl:text> </xsl:text>
		</em>
	</xsl:template>
	<!-- This formats and prettifies the document titles. Anything entered here appears in the doc_status tag above, for now anyway. -->
	<xsl:template match="document_title">
		<h4>
			<xsl:value-of select="."/>
		</h4>
	</xsl:template>

	<xsl:template match="*[@equation='Yes']">
		<div style="margin-left:12.00pt">
			<xsl:if test="self::img">
				<table>
					<tr>
						<td>
							<img>
								<xsl:attribute name="src"><xsl:value-of select="@src"/></xsl:attribute>
							</img>
						</td>
						<td style="vertical-align:middle; text-align:right;">
							<strong>(<xsl:number from="section" level="any" count="*[@equation='Yes']" format="A"/>)</strong>
						</td>
					</tr>
				</table>
			</xsl:if>
			<xsl:if test="self::para">
				<table>
					<tr>
						<td style="vertical-align:middle;">
							<xsl:apply-templates/>
						</td>
						<td>
							<strong>(<xsl:number from="section" level="any" count="*[@equation='Yes']" format="A"/>)</strong>
						</td>
					</tr>
				</table>
			</xsl:if>
			<xsl:if test="self::indent">
				<table>
					<tr>
						<td style="vertical-align:middle;">
							<xsl:apply-templates/>
						</td>
						<td>
							<strong>(<xsl:number from="section" level="any" count="*[@equation='Yes']" format="A"/>)</strong>
						</td>
					</tr>
				</table>
			</xsl:if>
		</div>
	</xsl:template>
	<xsl:template match="equation_ref">
		<div style="margin-left:12.00pt">
			<xsl:variable name="ref_number">
				<xsl:value-of select="@ref"/>
			</xsl:variable>
			<xsl:for-each select="//*[@id=$ref_number]">
				<xsl:variable name="file_name">
					<xsl:value-of select="ancestor::section//file_name"/>
				</xsl:variable>
				<xsl:variable name="equID">#<xsl:value-of select="@id"/>
				</xsl:variable>
				<xsl:variable name="topic_name">
					<xsl:value-of select="ancestor::section//h1"/>
				</xsl:variable>
				<xsl:if test="self::img">
					<table border="0">
						<tr>
							<td>
								<img>
									<xsl:attribute name="src"><xsl:value-of select="@src"/></xsl:attribute>
								</img>
							</td>
						</tr>
						<tr>
							<td style="padding-left:15px; padding-top:5px; align:center">
								<strong>Source: </strong>
								<a>
									<xsl:attribute name="href"><xsl:value-of select="concat($file_name,$equID)"/></xsl:attribute>
									<xsl:value-of select="$topic_name"/>
								</a>
							</td>
						</tr>
					</table>
				</xsl:if>
				<xsl:if test="self::para">
					<table border="0">
						<tr>
							<td>
								<xsl:apply-templates/>
							</td>
						</tr>
						<tr>
							<td style="padding-left:15px; padding-top:5px; align:center">
								<strong>Source: </strong>
								<a>
									<xsl:attribute name="href"><xsl:value-of select="concat($file_name,$equID)"/></xsl:attribute>
									<xsl:value-of select="$topic_name"/>
								</a>
							</td>
						</tr>
					</table>
				</xsl:if>
			</xsl:for-each>
		</div>
	</xsl:template>
	<!-- Dialog boxes are formatted in object.xsl. -->
	
	
	
	<!-- This formats the preliminary warning we put on pre-shipping versions of the help -->

	<!-- These are extraneous tags left over from formatting in HTML versions of the New Feature Documenation form -->
	
	<xsl:template match="html">
		<xsl:text disable-output-escaping="yes">&lt;!-- begin HTML formatting --&gt;</xsl:text>
		<xsl:copy-of select="child::node()"/>
		<xsl:text disable-output-escaping="yes">&lt;!-- end HTML formatting --&gt;</xsl:text>
	</xsl:template>
	
	<xsl:template name="format_term">
		<xsl:if test="not(@print_only='True')">
			<tr>
				<xsl:for-each select="term">
					<td>
						<xsl:if test="@id">
							<a>
								<xsl:attribute name="name"><xsl:value-of select="@id"/></xsl:attribute>
							</a>
						</xsl:if>
						<xsl:apply-templates/>
					</td>
				</xsl:for-each>
				<td>
					<xsl:for-each select="definition">
						<xsl:apply-templates/>
						<br/>
					</xsl:for-each>
				</td>
			</tr>
		</xsl:if>
	</xsl:template>
	<xsl:template match="instruction">
		<!-- If the Doc_Status tag is not specified, show all the Author instructions.-->
		<!-- Show the Integrator and Developer instructions always in the visible sections.-->
		<xsl:if test="@employee_type[.='Integrator']">
			<p>
				<span style="color:'#0000C0'">
					<strong>
						<xsl:apply-templates/>
					</strong>
				</span>
			</p>
		</xsl:if>
	</xsl:template>
	<xsl:template match="caption">
		<!-- <xsl:apply-templates /> -->
	</xsl:template>

</xsl:stylesheet>
