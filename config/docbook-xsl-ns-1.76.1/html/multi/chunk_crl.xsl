<?xml version='1.0'?>

<!DOCTYPE stylesheet 
[

<!-- ============== HOME ============== -->
<!-- <!ENTITY xsl_ns_base_cygwin "/cygdrive/e/Dev_Root/docbook/tools/docbook-xsl-ns-1.76.1"> -->

<!-- ============== OFFICE ============== -->
<!-- <!ENTITY xsl_ns_base_cygwin "/home/CLi/develop/docbook/tools/docbook-xsl-ns-1.76.1"> -->

<!-- ============== UNIFY ============== -->
<!ENTITY xsl_ns_base_cygwin "/home/develop/docbook/tools_root/docbook-xsl-ns-1.76.1">

]
>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>

<xsl:import href="&xsl_ns_base_cygwin;/html/chunk.xsl"/>

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