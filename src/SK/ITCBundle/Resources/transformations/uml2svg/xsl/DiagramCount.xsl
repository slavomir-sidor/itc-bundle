<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:output
		method="text"
		media-type="text/text"
		indent="no" />

	<xsl:template match="text()" />

	<xsl:template match="/">
		<xsl:value-of select="count(/XMI/XMI.content/UML:Diagram)" />
	</xsl:template>
</xsl:stylesheet>
