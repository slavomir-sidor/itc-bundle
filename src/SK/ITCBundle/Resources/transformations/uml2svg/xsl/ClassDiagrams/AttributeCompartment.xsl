<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: AttributeCompartment.xsl An attribute compartment holds a list of 
	strings, each of which is the encoded representation of an attribute -->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:import href="../Common/Styling.xsl" />
	<xsl:import href="../ClassDiagrams/Attribute.xsl" />

	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

	<!-- Attribute compartment -->
	<xsl:template name="AttributeCompartment">

		<!-- Main attribute compartment group -->
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

			<desc>
				<xsl:text>AttributeCompartment</xsl:text>
			</desc>

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/*">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'DelimitedSection'">
						<!-- Compartment section -->
						<xsl:for-each select="UML:GraphElement.contained/*">
							<xsl:choose>
								<xsl:when
									test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Attribute">
									<!-- Attribute -->
									<xsl:call-template name="Attribute" />
								</xsl:when>
							</xsl:choose>
						</xsl:for-each>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>
</xsl:stylesheet>
