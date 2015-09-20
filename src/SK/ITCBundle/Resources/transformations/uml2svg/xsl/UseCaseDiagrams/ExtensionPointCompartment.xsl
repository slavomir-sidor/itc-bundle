<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: ExtensionPointCompartment.xsl Displays Extension points -->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:import href="../Common/Styling.xsl" />
	<xsl:import href="../Common/Text.xsl" />
	<xsl:import href="../UseCaseDiagrams/ExtensionPoint.xsl" />
	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

	<!-- ExtensionPointCompartment -->
	<xsl:template name="ExtensionPointCompartment">

		<!-- Main ExtensionPointCompartment group -->
		<g
			id="{@xmi.id}"
			transform="translate({UML:GraphElement.position/XMI.field[1]}, {UML:GraphElement.position/XMI.field[2]})">
			<xsl:apply-templates
				select="."
				mode="FontStyle" />
			<xsl:apply-templates
				select="."
				mode="isVisible" />

			<desc>
				<xsl:text>ExtensionPointCompartment</xsl:text>
			</desc>

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Label'">
						<!-- Compartment Label -->
						<g font-weight="bold">
							<xsl:call-template name="Text">
								<xsl:with-param
									name="String"
									select="'Extension Points'" />
							</xsl:call-template>
						</g>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:ExtensionPoint">
						<!-- Extension -->
						<xsl:call-template name="ExtensionPoint" />
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>
</xsl:stylesheet>
