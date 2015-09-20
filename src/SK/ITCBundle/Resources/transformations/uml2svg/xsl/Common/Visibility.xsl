<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: NewVisibility.xsl Transforms the visibility of an element to the apropriate 
	string (+,-,#,~) -->

<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:import href="Globals.xsl" />

	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

	<!-- Visibility -->
	<xsl:template name="Visibility">
		<xsl:param
			name="OwnerSemanticID"
			select="../../UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<xsl:variable
			name="visibility"
			select="key('xmi.id', $OwnerSemanticID)/@visibility" />
		<xsl:choose>
			<xsl:when test="$visibility = 'public'">
				<xsl:value-of select="$PublicVisibility" />
			</xsl:when>
			<xsl:when test="$visibility = 'package'">
				<xsl:value-of select="$PackageVisibility" />
			</xsl:when>
			<xsl:when test="$visibility = 'protected'">
				<xsl:value-of select="$ProtectedVisibility" />
			</xsl:when>
			<xsl:when test="$visibility = 'private'">
				<xsl:value-of select="$PrivateVisibility" />
			</xsl:when>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>

