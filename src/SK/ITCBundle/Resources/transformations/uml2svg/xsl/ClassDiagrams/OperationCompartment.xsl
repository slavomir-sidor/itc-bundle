<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: OperationCompartment.xsl An operation compartment holds a list of 
	strings, each of which is the encoded representation of an operation -->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:import href="../Common/Styling.xsl" />
	<xsl:import href="../ClassDiagrams/Operation.xsl" />

	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

	<!-- Operation compartment -->
	<xsl:template name="OperationCompartment">

		<!-- Main OperationCompartment group -->
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
				<xsl:text>Operation compartment</xsl:text>
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
									test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Operation">
									<!-- Operation -->
									<xsl:call-template name="Operation" />
								</xsl:when>
							</xsl:choose>
						</xsl:for-each>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>
</xsl:stylesheet>
