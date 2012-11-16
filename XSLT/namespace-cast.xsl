<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:cast="http://wendellpiez.com/xslt/util"
  exclude-result-prefixes="xs"
  version="2.0">

<!-- XSLT 2.0 stylesheet by Wendell Piez,
     November 2012 -->
  
<!-- This stylesheet is released into the public domain.     
     Please credit your sources. -->
     
<!-- This stylesheet transforms XML input, casting elements
     in designated namespaces into other namespaces.

     Capable of casting namespaces arbitrarily, it can be
     used to merge namespaces together as well as simply change
     them.

     Elements not designated for casting are left unchanged.

     <ns/> - represents elements in no namespace
     <ns uri="whathaveyou"/> - represents elements
       in the 'whathaveyou' namespace (irrespective of prefix)

     So to merge elements in the 'http://wendellpiez.com/old/ns' 
     namespace into 'http://wendellpiez.com/new/ns', have this:

     <ns prefix="new" uri="http://wendellpiez.com/new/ns">
       <ns uri="http://wendellpiez.com/old/ns"/>
     </ns>
     
     To do the same, except making the target namespace a default
     (unprefixed):
     
     <ns default="yes" uri="http://wendellpiez.com/new/ns">
       <ns uri="http://wendellpiez.com/old/ns"/>
     </ns>
  
     And to merge both of these with elements in no namespace
  
     <ns>
       <ns uri="http://wendellpiez.com/new/ns"/>
       <ns uri="http://wendellpiez.com/old/ns"/>
     </ns>

     Note a prefix is given only for purposes of assigning
     prefixes consistently to elements whose namespaces are
     reassigned. Otherwise names are copied as is. If a prefix
     is not designated for merged elements, the stylesheet attempts
     to find or make one.

     While this stylesheet manipulates namespace, it does nothing
     to clean up or regularize their declarations. In some cases 
     you may want to follow this transformation with a 
     namespace-cleanup.xsl transformation. -->
  
  <xsl:variable name="merge-ns">
    <ns>
      <ns uri="http://docs.oasis-open.org/ns/oasis-exchange/table"/>
    </ns>
  </xsl:variable>
  
  <!-- $cast-ns represents all namespaces we will be casting -->
  <xsl:variable name="cast-ns" select="$merge-ns/*/ns"/>
  
  <xsl:variable name="doc" select="/"/>
  
  <xsl:template match="*">
    <xsl:copy copy-namespaces="yes">
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="*[namespace-uri(.) = $cast-ns/@uri]">
    <xsl:variable name="cast-ns"
      select="$cast-ns[@uri = namespace-uri(current())][1]"/>
    <xsl:element name="{string-join((cast:prefix($cast-ns),local-name()),':')}"
      namespace="{$cast-ns/../@uri}">
      <xsl:copy-of select="@* |
        namespace::*[not(.=(namespace-uri(current()),$cast-ns/../@uri))]"/>
      <xsl:apply-templates/>    
    </xsl:element>
  </xsl:template>

  <xsl:template match="comment() | processing-instruction()">
    <xsl:copy-of select="."/>
  </xsl:template>
  
  <xsl:function name="cast:prefix" as="xs:string?">
    <!-- The prefix for the new namespace is determined as follows:
      * If ns/@default='yes' no prefix is returned
      * If ns/@prefix is given, its value is returned
      * If neither of these, the first prefix given in the document
          for this namespace is returned
      * If all else fails, 'nsN' is returned, where 'N' is the
          position of the ns element inside $merge-ns -->
    <xsl:param name="n" as="element(ns)"/>
    <xsl:variable name="new-ns" select="$n/parent::ns"/>
    <xsl:sequence select="($new-ns/@prefix,
      $doc//(*|@*)[namespace-uri(.) = $new-ns/@uri][1]
      /prefix-from-QName(node-name(.)),
      concat('ns',count($new-ns|$new-ns/preceding-sibling::ns)))[1]
      [not($new-ns/@default='yes')]"/>
  </xsl:function>
</xsl:stylesheet>