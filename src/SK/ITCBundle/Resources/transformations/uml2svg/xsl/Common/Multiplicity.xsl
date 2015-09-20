<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: Multiplicity.xsl Gets the multiplicity of an element -->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:import href="Styling.xsl" />
	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

	<!-- Multiplicity -->
	<xsl:template name="Multiplicity">
		<xsl:param
			name="OwnerSemanticID"
			select="../../UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<xsl:variable
			name="lower"
			select="key('xmi.id', $OwnerSemanticID)/*/UML:Multiplicity/UML:Multiplicity.range/UML:MultiplicityRange/@lower" />
		<xsl:variable
			name="upper"
			select="key('xmi.id', $OwnerSemanticID)/*/UML:Multiplicity/UML:Multiplicity.range/UML:MultiplicityRange/@upper" />

		<!-- Multiplicity text -->
		<xsl:choose>
			<xsl:when test="$lower = 1 and $upper = 1">
				<xsl:text>1</xsl:text>
			</xsl:when>
			<xsl:when test="$lower = 0 and $upper = 1">
				<xsl:text>0..1</xsl:text>
			</xsl:when>
			<xsl:when test="$lower = 1 and $upper = -1">
				<xsl:text>1..*</xsl:text>
			</xsl:when>
			<xsl:when test="$lower = 0 and $upper = -1">
				<xsl:text>*</xsl:text>
			</xsl:when>
			<xsl:when test="$lower = $upper">
				<xsl:value-of select="$lower" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$lower" />
				<xsl:text>..</xsl:text>
				<xsl:value-of select="$upper" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
