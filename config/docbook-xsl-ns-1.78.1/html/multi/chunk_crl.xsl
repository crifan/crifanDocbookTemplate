<?xml version='1.0'?>

<!DOCTYPE stylesheet 
[

<!-- <!ENTITY docbook_xsl_ns "docbook-xsl-ns-1.76.1"> -->
<!-- <!ENTITY docbook_xsl_ns "docbook-xsl-ns-1.77.1"> -->
<!ENTITY docbook_xsl_ns "docbook-xsl-ns-1.78.1">


<!-- ============== HOME ============== -->
<!ENTITY xsl_ns_base_cygwin "/cygdrive/e/dev_root/docbook/dev/tools/&docbook_xsl_ns;">
<!ENTITY xsl_ns_base_cmd    "E:/dev_root/docbook/tools/&docbook_xsl_ns;">
<!ENTITY config_base_cmd    "E:/dev_root/docbook/dev/config/&docbook_xsl_ns;">

<!-- ============== OFFICE ============== -->
<!-- <!ENTITY xsl_ns_base_cygwin "/home/CLi/develop/docbook/tools/&docbook_xsl_ns;"> -->

<!-- ============== UNIFY ============== -->

]
>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>

<!-- <xsl:import href="file://&xsl_ns_base_cmd;/html/chunk.xsl"/> -->
<xsl:import href="&xsl_ns_base_cmd;/html/chunk.xsl"/>
<!--<xsl:import href="file://E:/Dev_Root/docbook/tools/docbook-xsl-ns-1.77.1/html/chunk.xsl"/>-->
<xsl:import href="../common_html.xsl"/>

<!--============================================================================
misc setting
=============================================================================-->

<xsl:param name="chunker.output.encoding" select="'UTF-8'"/>
<!-- html source code contain indent == formatted -->
<xsl:param name="chunker.output.indent" select="'yes'"/>

<!-- now put all path related settings into makefile -->
<!-- <xsl:param name="base.dir">&output_base_cmd;/html/multi/</xsl:param> -->

<!-- has moved following to makefile
<xsl:param name="navig.graphics">1</xsl:param>
<xsl:param name="navig.graphics.extension">.png</xsl:param>
<xsl:param name="navig.graphics.path">images/system/</xsl:param>
-->

<xsl:param name="use.id.as.filename">1</xsl:param>

<xsl:param name="generate.manifest">1</xsl:param>


</xsl:stylesheet>