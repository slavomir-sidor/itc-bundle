<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: Node.xsl Displays Node (from Deployment diagrams) as a cube. -->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:import href="../Common/Styling.xsl" />
	<xsl:import href="../Common/NameCompartment.xsl" />
	<xsl:import href="../Common/Lines.xsl" />

	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

	<!-- Node -->
	<xsl:template name="Node">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
		<!-- Node outline parameters -->
		<xsl:variable name="w">
			<xsl:value-of select="UML:GraphNode.size/XMI.field[1]" />
		</xsl:variable>
		<xsl:variable name="h">
			<xsl:value-of select="UML:GraphNode.size/XMI.field[2]" />
		</xsl:variable>

		<!-- Main Node group -->
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
				<xsl:text>Node</xsl:text>
			</desc>

			<!-- The outline shape, a cube -->
			<path
				d="M 0 20 L 20 0 L {$w} 0 {$w} {$h - 20} {$w - 20} {$h} 0 {$h} 0 20 {$w - 20} 20 {$w - 20} {$h} M {$w} 0 {$w - 20} 20">
				<xsl:apply-templates
					select="."
					mode="FillStyle" />
			</path>

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
						<g
							id="{@xmi.id}"
							transform="translate(0, 20)">

							<title>
								<xsl:text>BodyCompartment for Node </xsl:text>
								<xsl:value-of select="$SemanticID" />
							</title>
							<desc>
								<xsl:text>BodyCompartment</xsl:text>
							</desc>

							<xsl:for-each select="UML:GraphElement.contained/*">
								<xsl:choose>

									<xsl:when
										test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Component">
										<xsl:call-template name="Component" />
									</xsl:when>

									<xsl:when
										test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Dependency">
										<xsl:call-template name="Dependency_Line" />
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
