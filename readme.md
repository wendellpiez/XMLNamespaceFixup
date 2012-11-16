XML Namespace fixup utilities

XSLT and Schematron for taming XML namespace madness.

Stylesheets can be used to modify the usage and presentation
of namespaces in XML documents, including:

* Rewrite elements in no namespace using a namespace
* Rewrite elements in any namespace in no namespace
* Cast elements from their namespaces into other
  namespaces
* Normalize namespace usage, by moving all namespace
  declarations to the top of the XML document and unifying
  their prefixes

The stylesheets can be used as is (by modifying their internal
configurations) or by importing them into your own stylesheets
(providing their configurations in the importing layer).

Schematron schemas are also provided to help detect issues with
namespaces in your documents.

Further documentation is given in the stylesheets.

By Wendell Piez, 2011-2012.
wapiez (at) wendellpiez (dot) com.
http://www.wendellpiez.com
Eat Your Vegetables

With thanks to Mulberry Technologies, Inc., who sponsored the original
version of these stylesheets.