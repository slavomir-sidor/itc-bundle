<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: ComponentInstance.xsl Displays ComponentInstance -->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:import href="../Common/Styling.xsl" />
	<xsl:import href="../Common/NameCompartment.xsl" />
	<xsl:import href="../CollaborationDiagrams/Object.xsl" />
	<xsl:import href="../Common/Lines.xsl" />
	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

	<!-- ComponentInstance -->
	<xsl:template name="ComponentInstance">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- Main ComponentInstance group -->
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
				<xsl:text>ComponentInstance</xsl:text>
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
							<xsl:with-param
								name="TextDecoration"
								select="'underline'" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'BodyCompartment'">
						<!-- Contained nodes -->
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
								<xsl:text>Component instance body</xsl:text>
							</desc>
							<xsl:for-each select="UML:GraphElement.contained/*">
								<xsl:choose>
									<xsl:when
										test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Object">
										<xsl:call-template name="Object" />
									</xsl:when>

									<xsl:when
										test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Link">
										<xsl:call-template name="Link_Line" />
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
