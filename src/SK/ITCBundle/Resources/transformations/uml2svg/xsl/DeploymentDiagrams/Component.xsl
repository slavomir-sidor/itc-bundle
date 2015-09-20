<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: Component.xsl Displays Component -->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:import href="../Common/Styling.xsl" />
	<xsl:import href="../Common/NameCompartment.xsl" />
	<xsl:import href="../DeploymentDiagrams/ProvidedInterfaceNode.xsl" />
	<xsl:import href="../DeploymentDiagrams/RequiredInterfaceNode.xsl" />
	<xsl:import href="../DeploymentDiagrams/PortNameCompartment.xsl" />
	<xsl:import href="../DeploymentDiagrams/ComponentBody.xsl" />
	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

	<!-- Component -->
	<xsl:template name="Component">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- Main Component group -->
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
				<xsl:text>Component</xsl:text>
			</desc>

			<xsl:variable
				name="height"
				select="UML:GraphNode.size/XMI.field[2]" />

			<!-- The outline shape, a Rectangle with two small handles -->
			<rect
				width="{UML:GraphNode.size/XMI.field[1]}"
				height="{$height}">
				<xsl:apply-templates
					select="."
					mode="FillStyle" />
			</rect>
			<xsl:if test="$UmlStdVersion = '1.5'">
				<rect
					width="25"
					height="10"
					x="-12.5"
					y="{$height div 2 - 20}">
					<xsl:apply-templates
						select="."
						mode="FillStyle" />
				</rect>
				<rect
					width="25"
					height="10"
					x="-12.5"
					y="{$height div 2 + 10}">
					<xsl:apply-templates
						select="."
						mode="FillStyle" />
				</rect>
			</xsl:if>

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

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'BodyCompartment'">
						<!-- Contained nodes -->
						<xsl:call-template name="ComponentBody" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge//UML:Attribute">
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
								<xsl:text>Port for </xsl:text>
								<xsl:value-of select="$SemanticID" />
							</title>
							<desc>
								<xsl:text>Port</xsl:text>
							</desc>

							<!-- The outline shape, a Rectangle -->
							<rect
								width="{UML:GraphNode.size/XMI.field[1]}"
								height="{UML:GraphNode.size/XMI.field[2]}">
								<xsl:apply-templates
									select="."
									mode="FillStyle" />
							</rect>

							<!-- Contained nodes -->
							<xsl:for-each select="UML:GraphElement.contained/*">
								<xsl:choose>
									<xsl:when
										test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'PortNameCompartment'">
										<xsl:call-template name="PortNameCompartment" />
									</xsl:when>

									<xsl:when
										test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'StereotypeCompartment'">
										<xsl:call-template name="StereotypeCompartment" />
									</xsl:when>

									<xsl:when
										test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'RequiredInterfaceEdge'">
										<xsl:call-template name="RequiredInterfaceEdge" />
									</xsl:when>

									<xsl:when
										test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'RequiredInterfaceNode'">
										<xsl:call-template name="RequiredInterfaceNode" />
									</xsl:when>

									<xsl:when
										test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'ProvidedInterfaceEdge'">
										<xsl:call-template name="ProvidedInterfaceEdge" />
									</xsl:when>

									<xsl:when
										test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'ProvidedInterfaceNode'">
										<xsl:call-template name="ProvidedInterfaceNode" />
									</xsl:when>
								</xsl:choose>
							</xsl:for-each>
						</g>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>
</xsl:stylesheet>
