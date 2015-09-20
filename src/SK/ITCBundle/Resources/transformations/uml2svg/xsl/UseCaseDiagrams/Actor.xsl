<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: Actor.xsl Displays an Actor -->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:import href="../UseCaseDiagrams/ActorStickman.xsl" />
	<xsl:import href="../ClassDiagrams/Class.xsl" />

	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

	<!-- Actor -->
	<xsl:template name="Actor">
		<xsl:choose>
			<xsl:when
				test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/@presentation = 'Classifier'">
				<xsl:call-template name="Class" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="ActorStickman" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
