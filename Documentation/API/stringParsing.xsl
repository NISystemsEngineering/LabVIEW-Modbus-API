<?xml version="1.0" encoding="iso-8859-1"?> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:template name="replace">
   <xsl:param name="string" />
   <xsl:param name="find" />
   <xsl:param name="replacewith" />

   <xsl:choose>
      <xsl:when test="not(contains($string, $find))">
         <xsl:value-of select="$string" />
      </xsl:when>
      <xsl:otherwise>
         <xsl:value-of select="substring-before($string, $find)" /><xsl:value-of select="$replacewith" />
         <xsl:call-template name="replace">
            <xsl:with-param name="string" select="substring-after($string, $find)" />
            <xsl:with-param name="find" select="$find" />
            <xsl:with-param name="replacewith" select="$replacewith" />
         </xsl:call-template>
      </xsl:otherwise>
   </xsl:choose>
</xsl:template>

<!-- xsl:template name="compareStrings">
   <xsl:param name="str1" />
   <xsl:param name="str2" />
   <xsl:param name="caseInsensitive">0</xsl:param>
   <xsl:variable name="ucStr1">
      <xsl:choose>
         <xsl:when test="$caseInsensitive = '1'">
            <xsl:value-of select="translate($str1, 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')" />
         </xsl:when>
         <xsl:otherwise><xsl:value-of select="$str1" /></xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="ucStr2">
      <xsl:choose>
         <xsl:when test="$caseInsensitive = '1'">
            <xsl:value-of select="translate($str2, 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')" />
         </xsl:when>
         <xsl:otherwise><xsl:value-of select="$str2" /></xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:value-of select="$ucStr1 = $ucStr2" />
</xsl:template -->

<xsl:template name="removeVIExt">
   <xsl:param name="string" />
   <xsl:call-template name="removeFileExt">
      <xsl:with-param name="string" select="$string" />
      <xsl:with-param name="ext" select="'vi'" />
   </xsl:call-template>
</xsl:template>


<!-- 
This template removing a file extention is a bit of a misnomer. 
All it does is remove .$ext if it's at the end of a string.
-->

<xsl:template name="removeFileExt">
   <xsl:param name="string" />
   <xsl:param name="ext" />
   <xsl:variable name="upperCasedExt" select="translate($ext, 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')" />
   <xsl:variable name="upperCased" select="translate($string, 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')" />
   <xsl:variable name="fileExtOffset" select="string-length(substring-before($upperCased, concat('.', $upperCasedExt)))" />
   <xsl:choose>
      <!-- 
      Need the extra case to see if the string contains .the extension at all. 
      Can't rely on looking at substring-before() in case .extension is at the beginning
      -->
      <xsl:when test="contains($upperCased, concat('.', $upperCasedExt))">
         <xsl:choose>
            <xsl:when test="string-length(substring-after($upperCased, concat('.', $upperCasedExt))) = 0">
               <xsl:value-of select="substring($string, 1, $fileExtOffset)" />
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="substring($string, 1, $fileExtOffset + string-length(concat('.', $upperCasedExt)))" />
               <xsl:call-template name="removeFileExt">
                  <xsl:with-param name="string" select="substring($string, $fileExtOffset + string-length(concat('.', $upperCasedExt))+1)" />
                  <xsl:with-param name="ext" select="$ext" />
               </xsl:call-template>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
         <xsl:value-of select="$string" />
      </xsl:otherwise>
   </xsl:choose>
</xsl:template>

<xsl:template name="escapeForURL">
   <xsl:param name="string" />
   <xsl:call-template name="massReplace">
      <xsl:with-param name="string" select="$string" />
      <xsl:with-param name="parameterSetsFile">urlescape.xml</xsl:with-param>
   </xsl:call-template>
</xsl:template>


<!-- 
<xsl:template name="massReplace">

Performs a mass search and replace with multiple sets of search/replace strings. 
The strings must be sourced in an XML file, and the path of that file relative to this .xsl 
passed in via the parameterSetsFile parameter. The XML file containing the search/replace strings is of the form:

<?xml version="1.0"?>
<searchReplaceSets>
   <searchReplaceSet find="findString1" replace="replacementString1" />
   <searchReplaceSet find="findString2" replace="replacementString2" />
   ...
   <searchReplaceSet find="findStringn" replace="replacementStringn" />
</searchReplaceSets>

The search and replace is performed using each set in the order in which they appear within <searchReplaceSets>. 
Be mindful of that order so you do not make unintentional replacements. For example, this order:

<searchReplaceSets>
   <searchReplaceSet find="&" replace="%26" />
   <searchReplaceSet find="%" replace="%25" />
</searchReplaceSets>

Would replace any ampersands with %25, but the subsequent search would replace the shiny new percent signs with %26, 
resulting in %2526.
-->

<xsl:template name="massReplace">
   <xsl:param name="string" />
   <xsl:param name="parameterSetsFile" />
   <xsl:param name="searchReplaceSetNum">1</xsl:param>
   <xsl:choose>
      <xsl:when test="$searchReplaceSetNum = count(document($parameterSetsFile, document(''))/searchReplaceSets/searchReplaceSet)">
         <xsl:call-template name="replace">
            <xsl:with-param name="string" select="$string" />
	    <xsl:with-param name="find"><xsl:value-of select="document($parameterSetsFile, document(''))/searchReplaceSets/searchReplaceSet[$searchReplaceSetNum]/@find" /></xsl:with-param>
	    <xsl:with-param name="replacewith"><xsl:value-of select="document($parameterSetsFile, document(''))/searchReplaceSets/searchReplaceSet[$searchReplaceSetNum]/@replace" /></xsl:with-param>
         </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
         <xsl:call-template name="massReplace">
	    <xsl:with-param name="string">
	       <xsl:call-template name="replace">
	          <xsl:with-param name="string" select="$string" />
	          <xsl:with-param name="find"><xsl:value-of select="document($parameterSetsFile, document(''))/searchReplaceSets/searchReplaceSet[$searchReplaceSetNum]/@find" /></xsl:with-param>
	          <xsl:with-param name="replacewith"><xsl:value-of select="document($parameterSetsFile, document(''))/searchReplaceSets/searchReplaceSet[$searchReplaceSetNum]/@replace" /></xsl:with-param>
	       </xsl:call-template>
	    </xsl:with-param>
	    <xsl:with-param name="parameterSetsFile" select="$parameterSetsFile" />
	    <xsl:with-param name="searchReplaceSetNum" select="$searchReplaceSetNum +1" />
         </xsl:call-template>
      </xsl:otherwise>
   </xsl:choose>
</xsl:template>

<!-- The following two templates manipulate a non-escaped example path for use in example buttons -->
<xsl:template name="escapePathForJS">
<xsl:param name="fullpath" />
<xsl:call-template name="replace">
   <xsl:with-param name="string">
      <xsl:call-template name="replace">
         <xsl:with-param name="string">
            <xsl:call-template name="replace">
	       <xsl:with-param name="string" select="$fullpath" />
	       <xsl:with-param name="find">&amp;</xsl:with-param>
	       <xsl:with-param name="replacewith">%2526</xsl:with-param>
             </xsl:call-template>
          </xsl:with-param>
         <xsl:with-param name="find" select="' '"/>
         <xsl:with-param name="replacewith">%20</xsl:with-param>
      </xsl:call-template>
   </xsl:with-param>
   <xsl:with-param name="find">\</xsl:with-param>
   <xsl:with-param name="replacewith">%5C%5C</xsl:with-param>
</xsl:call-template>
</xsl:template>

<xsl:template name="getVIName">
   <xsl:param name="path" />
   
   <xsl:choose>
      <xsl:when test="not(contains($path, '\'))">
         <xsl:value-of select="$path" />
      </xsl:when>
      <xsl:otherwise>
         <xsl:call-template name="getVIName">
            <xsl:with-param name="path" select="substring-after($path, '\')" />
         </xsl:call-template>
      </xsl:otherwise>
   </xsl:choose>
</xsl:template>

<xsl:template name="cleanUpPathSlashesForURL">
   <xsl:param name="path" />
   <xsl:param name="addTrailingSlash" />
   <xsl:variable name="pathWithSlashes"><xsl:value-of select="translate($path, '\', '/')" /></xsl:variable>
   <xsl:value-of select="$pathWithSlashes" />
   <xsl:if test="$path and $addTrailingSlash and not(substring($pathWithSlashes,string-length($pathWithSlashes))='/')">/</xsl:if>
</xsl:template>   	
   

</xsl:stylesheet>