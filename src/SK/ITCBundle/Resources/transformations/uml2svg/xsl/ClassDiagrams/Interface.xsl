<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: Interface.xsl Displays Interface -->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:import href="../ClassDiagrams/Interface_Ball.xsl" />
	<xsl:import href="../ClassDiagrams/Class.xsl" />

	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

	<!-- Interface -->
	<xsl:template name="Interface">
		<xsl:choose>
			<xsl:when
				test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/@presentation = 'Ball'">
				<xsl:call-template name="Interface_Ball" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="Class" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
