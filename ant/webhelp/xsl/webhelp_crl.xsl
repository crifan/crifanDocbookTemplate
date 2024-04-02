<?xml version="1.0"?>

<!DOCTYPE stylesheet 
[
<!-- HOME -->
<!ENTITY xsl_ns_path "E:/Dev_Root/docbook/tools/docbook-xsl-ns-1.77.1">
<!ENTITY config_path "E:/Dev_Root/docbook/dev/config/docbook-xsl-ns-1.77.1">

<!-- OFFICE -->
<!--<!ENTITY xsl_ns_path "D:/tmp/tmp_dev_root/cgwin/home/CLi/develop/docbook/tools/docbook-xsl-ns-1.77.1">-->
<!--<!ENTITY config_path "D:/tmp/tmp_dev_root/cgwin/home/CLi/develop/docbook/config/docbook-xsl-ns-1.77.1">-->

<!-- ONLINE -->
<!--<!ENTITY xsl_ns_path "http://www.crifan.com/files/res/docbook">-->
<!--<!ENTITY config_path "http://www.crifan.com/files/res/docbook">-->
]>

<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:d="http://docbook.org/ns/docbook"
    xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
    xmlns:exsl="http://exslt.org/common"
    xmlns:set="http://exslt.org/sets"
    version="1.0"
    exclude-result-prefixes="doc exsl set d">


<!--
<xsl:import href="file:///E:/Dev_Root/docbook/tools/docbook-xsl-ns-1.77.1/webhelp/xsl/webhelp.xsl"/>
-->
<xsl:import href="webhelp.xsl"/>
<xsl:import href="file:///&config_path;/common_all.xsl"/>
<!--<xsl:import href="file:///E:/Dev_Root/docbook/dev/config/docbook-xsl-ns-1.77.1/html/multi/chunk_crl.xsl"/>-->


<!--
desitinate the dir of webhelp common resource
currently those resources include common/ and favicon.ico
-->
<!--<xsl:param name="webhelp.common.dir">E:/Dev_Root/docbook/tools/docbook-xsl-ns-1.77.1/webhelp/docs/common/</xsl:param>-->
<!--<xsl:param name="webhelp.common.dir">&xsl_ns_path;/webhelp/docs/common/</xsl:param>-->
<xsl:param name="webhelp.common.dir">&xsl_ns_path;/webhelp/template/common/</xsl:param>

<!-- custom css file path -->
<xsl:param name="custom.css.path">&config_path;/css/common_html.css</xsl:param>

<!--<xsl:param name="custom.css.path">http://www.crifan.com/files/res/docbook/css/common_html.css</xsl:param>-->

<xsl:param name="webhelp.autolabel">1</xsl:param>
<xsl:param name="chapter.autolabel" select="1"/>
<xsl:param name="appendix.autolabel" select="0"/>
<xsl:param name="qandadiv.autolabel" select="1"/>
<xsl:param name="reference.autolabel" select="1"/>

<xsl:param name="navig.showtitles">1</xsl:param>

<!-- remove warning: Request for label of unexpected element: bibliodiv -->
<xsl:template match="d:bibliodiv" mode="label.markup">
  <xsl:if test="@label">
    <xsl:value-of select="@label"/>
  </xsl:if>
</xsl:template>


<!--============================================================================
try add google analytics tracking code
=============================================================================-->
<!-- http://www.sagehill.net/docbookxsl/InsertExtHtml.html -->
<xsl:template name="user.header.content">
   <xsl:variable name="google_analytics_js" select="document('file:///&config_path;/html/js/crifan_ga_js.xml')"/>
   <xsl:copy-of select="$google_analytics_js/ga_js/node()"/>
</xsl:template>

</xsl:stylesheet>
