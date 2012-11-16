<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="xs"
  version="2.0">

<!-- XSLT 2.0 stylesheet by Wendell Piez, http://www.wendellpiez.com
     First version August 2011
     This version November 2012 -->

<!-- This stylesheet is released into the public domain.     
     Please credit your sources. -->

<!-- This stylesheet transforms XML input, casting all elements in
     namespaces specified into no namespace.

     (Yes, this can merge namespaces, so beware.)

     Elements already in no namespace remain with no namespace.

     Elements in namespaces not specified are left unchanged.

     (But note: namespaces are not stripped from attribute nodes,
     a different kettle of fish.)

     Also note: Running this stylesheet moves elements in identified
     namespaces into no namespace, which is not the same as putting
     them into the default namespace. If you have a default namespace,
     running this stylesheet will typically result in xmlns=""
     namespace "undeclarations" littering your document (to disambiguate
     the new no-namespace elements from the default namespace.

     See the namespace-cast.xsl utility for a more general-purpose
     set of namespace manipulations. -->

  <xsl:variable name="strip-ns" as="element()+">
    <!-- designate the namespaces you want stripped here -->
    <ns uri="http://mulberrytech.com/xslt/util"/>
  </xsl:variable>

  <xsl:template match="*">
    <xsl:copy copy-namespaces="no">
      <xsl:copy-of select="namespace::*[not(. = $strip-ns/@uri)]"/>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="*[namespace-uri(.) = $strip-ns/@uri]">
    <xsl:variable name="e" select="."/>
    <xsl:element name="{local-name()}">
      <xsl:copy-of select="@*"/>
      <xsl:for-each select="in-scope-prefixes(.)[not(.=('','xml'))]
        [not(namespace-uri-for-prefix(.,$e) = $strip-ns/@uri)]">
        <xsl:namespace name="{.}" select="namespace-uri-for-prefix(.,$e)"/>
      </xsl:for-each>
      <xsl:apply-templates/>    
    </xsl:element>
  </xsl:template>

  <xsl:template match="comment() | processing-instruction()">
    <xsl:copy-of select="."/>
  </xsl:template>
</xsl:stylesheet>