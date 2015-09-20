<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: Collaboration.xsl Displays a dashed ellipse containig the object properties. -->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:import href="../Common/Styling.xsl" />
	<xsl:import href="../Common/NameCompartment.xsl" />
	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

	<!-- Collaboration -->
	<xsl:template name="Collaboration">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- Collaboration outline parameters -->
		<xsl:variable name="rx">
			<xsl:value-of select="UML:GraphNode.size/XMI.field[1] div 2" />
		</xsl:variable>
		<xsl:variable name="ry">
			<xsl:value-of select="UML:GraphNode.size/XMI.field[2] div 2" />
		</xsl:variable>

		<!-- Main Collaboration group -->
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
				<xsl:text>Collaboration</xsl:text>
			</desc>

			<!-- The outline shape, a filled ellipse -->
			<ellipse
				cx="{$rx}"
				cy="{$ry}"
				rx="{$rx}"
				ry="{$ry}"
				stroke-dasharray="10">
				<xsl:apply-templates
					select="."
					mode="FillStyle" />
			</ellipse>

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NameCompartment'">
						<!-- Name compartment -->
						<xsl:call-template name="NameCompartment">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$SemanticID" />
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>
</xsl:stylesheet>
