<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: AssociationClass.xsl Displays AssociationClass -->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:import href="../ClassDiagrams/Class.xsl" />
	<xsl:import href="../Common/Styling.xsl" />
	<xsl:import href="../Common/Lines.xsl" />
	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

	<!-- AssociationClass -->
	<xsl:template name="AssociationClass">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- The outline shape, an Association Line -->
		<xsl:call-template name="Association_Line" />

		<!-- Main AssociationClass group -->
		<g
			id="{@xmi.id}"
			transform="translate({UML:GraphElement.position/XMI.field[1]}, {UML:GraphElement.position/XMI.field[2]})">
			<xsl:apply-templates
				select="."
				mode="FontStyle" />
			<xsl:apply-templates
				select="."
				mode="StrokeStyle" />
			<xsl:apply-templates
				select="."
				mode="isVisible" />

			<title>
				<xsl:value-of select="key('xmi.id', $SemanticID)/@name" />
			</title>
			<desc>
				<xsl:text>AssociationClass</xsl:text>
			</desc>

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/*">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'AssociationClassNode'">
						<!-- Association Node, a Class -->
						<xsl:call-template name="Class">
							<xsl:with-param
								name="SemanticID"
								select="$SemanticID" />
						</xsl:call-template>
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'AssociationClassEdge'">
						<!-- Association Edge -->
						<xsl:call-template name="AssociationClassEdge_Line" />
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>
</xsl:stylesheet>
