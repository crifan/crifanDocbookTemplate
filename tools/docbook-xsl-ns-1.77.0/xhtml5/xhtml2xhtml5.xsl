<xsl:stylesheet exclude-result-prefixes="d"
                 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:d="http://docbook.org/ns/docbook"
xmlns:xslo="http://www.w3.org/1999/XSL/TransformAlias"
                version="1.0">

<xsl:output indent="no"/>

<xsl:namespace-alias stylesheet-prefix="xslo" result-prefix="xsl"/>

<xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates/>
   </xsl:copy>
</xsl:template>

<xsl:template match="xsl:output">
  <xsl:comment>Same as xhtml but with doctypes removed from xsl:output </xsl:comment>
  <xsl:text>&#10;</xsl:text>
  <xsl:comment>and including from ../xhtml directory </xsl:comment>
  <xsl:text>&#10;</xsl:text>
  <xslo:output method="xml" encoding="UTF-8" indent="no"/>
</xsl:template>

<xsl:template match="xsl:include/@href">
  <xsl:choose>
    <xsl:when test="starts-with(., '../')">
      <xsl:copy-of select="."/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:attribute name="href">
        <xsl:value-of select="concat('../xhtml/', .)"/>
      </xsl:attribute>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:include href="../common/subtitles.xsl"/>
</xsl:stylesheet>

