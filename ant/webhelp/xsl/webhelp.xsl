<?xml version="1.0"?>

<!DOCTYPE stylesheet 
[
<!-- HOME -->
<!ENTITY xsl_ns_path "E:/Dev_Root/docbook/tools/docbook-xsl-ns-1.77.1">
<!ENTITY config_path "E:/Dev_Root/docbook/dev/config/docbook-xsl-ns-1.77.1">

<!-- OFFICE -->
<!--<!ENTITY xsl_ns_path "D:/tmp/tmp_dev_root/cgwin/home/CLi/develop/docbook/tools/docbook-xsl-ns-1.77.1">-->
<!--<!ENTITY config_path "D:/tmp/tmp_dev_root/cgwin/home/CLi/develop/docbook/config/docbook-xsl-ns-1.77.1">-->
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:d="http://docbook.org/ns/docbook"
xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
                xmlns:exsl="http://exslt.org/common"
                xmlns:set="http://exslt.org/sets"
		version="1.0"
                exclude-result-prefixes="doc exsl set d">

<!-- ********************************************************************
     $Id$
     ******************************************************************** 

     This file is part customization layer on top of the XSL DocBook
     Stylesheet distribution that generates webhelp output.

     ******************************************************************** -->
<!--
<xsl:import href="../../xhtml/chunk.xsl"/>
<xsl:include href="webhelp-common.xsl"/>
<xsl:include href="titlepage.templates.xsl"/>
-->

<!--<xsl:import href="file:///E:/Dev_Root/docbook/tools/docbook-xsl-ns-1.77.1/xhtml/chunk.xsl"/>-->
<xsl:import href="file:///&xsl_ns_path;/xhtml/chunk.xsl"/>
<xsl:include href="webhelp-common.xsl"/>
<xsl:include href="titlepage.templates.xsl"/>

</xsl:stylesheet>
