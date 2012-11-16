<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="xs"
  version="2.0">
  
  <xsl:import href="../XSLT/namespace-cast.xsl"/>

  <xsl:variable name="merge-ns">
    <ns default="yes" uri="http://www.w3.org/1998/Math/MathML">
      <ns uri="http://docs.oasis-open.org/ns/oasis-exchange/table"/>
    </ns>
  </xsl:variable>
  
  <xsl:variable name="controlled-namespaces">
    <ns prefix="mml" uri="http://www.w3.org/1998/Math/MathML" required="yes"/>
    <ns prefix="d" uri="default"/>
    <ns prefix="xlink" uri="http://www.w3.org/1999/xlink" required="yes"/>
    <ns prefix="oasis" uri="http://docs.oasis-open.org/ns/oasis-exchange/table"/>
    <ns prefix="svg" uri="http://www.w3.org/2000/svg"/>
  </xsl:variable>
  
</xsl:stylesheet>