<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron"
   queryBinding="xslt2">

  <!-- XSLT 2.0 Schematron by Wendell Piez (Mulberry Technologies, Inc.),
       August 2011 -->
  
  <!-- This Schematron is released into the public domain.     
       Please credit your sources. -->
  
  
  <!-- Requires Schematron with support for the namespace:: axis.
       Tested with Saxon 9.3.0.5. -->
  
  <pattern>
    <!-- On the document element, no namespace may be aliased
         (declared for more than one prefix) -->
    <rule context="/*">
      <report test="some $n in (namespace::*) satisfies
        ($n = (namespace::* except $n))">
        Namespace may not be aliased (declared for more than one prefix).
      </report>
    </rule>
    <!-- Elsewhere, all namespaces given must correspond with those
         on the parent -->
    <rule context="*">
      <assert test="every $n in (namespace::*) satisfies
        exists(../namespace::*[deep-equal(.,$n)])">
        Namespace may not be declared here.
      </assert>
      <assert test="every $n in (../namespace::*) satisfies
        exists(namespace::*[deep-equal(.,$n)])">
        Namespace may not be undeclared here.
      </assert>
    </rule>
  </pattern>
</schema>