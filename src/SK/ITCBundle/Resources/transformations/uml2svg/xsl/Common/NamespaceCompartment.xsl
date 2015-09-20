<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: NamespaceCompartment.xsl A namespace compartment is a double-collon 
	separated list of container names between paranthesis ( (from ...::... ) ) -->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:import href="Globals.xsl" />
	<xsl:import href="Styling.xsl" />
	<xsl:import href="Text.xsl" />

	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

	<!-- Namespace -->
	<xsl:template name="NamespaceCompartment">

		<!-- Main Namespace group -->
		<g
			id="{@xmi.id}"
			transform="translate({UML:GraphElement.position/XMI.field[1]}, {UML:GraphElement.position/XMI.field[2]})">
			<xsl:apply-templates
				select="."
				mode="FontStyle" />
			<xsl:apply-templates
				select="."
				mode="isVisible" />
			<xsl:attribute name="font-style">italic</xsl:attribute>

			<desc>
				<xsl:text>Namespace</xsl:text>
			</desc>

			<!-- Namespace contents -->
			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NamespaceStart'">
						<!-- Namespace start, '(from' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$NamespaceStart" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*">
						<!-- Namespace elements -->
						<xsl:variable
							name="ContainerSemanticID"
							select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="key('xmi.id', $ContainerSemanticID)/@name" />
							<xsl:with-param
								name="Space"
								select="'preserve'" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NamespaceSeparator'">
						<!-- Namespace separator, '::' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$NamespaceSeparator" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NamespaceEnd'">
						<!-- Namespace end, ')' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$NamespaceEnd" />
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>
</xsl:stylesheet>
