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
     
<!-- This stylesheet transforms XML input, casting all elements in no
     namespace into a namespace as specified.

     Elements already in the target namespace are left with the same
     binding, with their prefix rewritten to the specified prefix.
  
     Elements in some other namespace are left unchanged, as
     are all attributes.
  
-->
  
  <xsl:variable name="target-ns" as="element()">
    <!-- Include one and only one ns element as given,
         specifying the desired prefix and namespace.
         
         Leave @prefix off if you want this to be the
         default namespace (unprefixed) -->
    <ns prefix="m" uri="http://mulberrytech.com/xslt/util"/>
  </xsl:variable>
  
  <xsl:template match="*">
    <xsl:copy copy-namespaces="yes">
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="*[not(namespace-uri(.)) or
    (namespace-uri(.) = $target-ns/@uri)]">
    <xsl:element name="{string-join(($target-ns/@prefix,local-name()),':')}"
      namespace="{$target-ns/@uri}">
      <xsl:copy-of select="namespace::*[not(.=$target-ns/@uri)] | @*"/>
      <xsl:apply-templates/>    
    </xsl:element>
  </xsl:template>

  <xsl:template match="comment() | processing-instruction()">
    <xsl:copy-of select="."/>
  </xsl:template>
</xsl:stylesheet>