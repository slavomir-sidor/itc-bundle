<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: DiagramList.xsl Displays a list of diagrams within a XMI file (for 
	online transforming tool) -->
<xsl:stylesheet
	version="1.0"
	exclude-result-prefixes="UML"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:output
		method="xml"
		media-type="text/text"
		indent="yes"
		omit-xml-declaration="yes" />

	<xsl:template match="text()" />

	<!-- DiagramList -->
	<xsl:template match="/">
		<input
			type="radio"
			name="DiagramID"
			value="ALL_DIAGRAMS"
			checked="checked" />
		<xsl:text>All</xsl:text>
		<br />
		<xsl:for-each select="/XMI/XMI.content/UML:Diagram">
			<input
				type="radio"
				name="DiagramID"
				value="{@xmi.id}" />
			<xsl:value-of select="@name" />
			<br />
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
