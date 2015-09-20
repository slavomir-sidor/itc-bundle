<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: ExceptionHandler.xsl - UML2 -->

<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:import href="../ActivityDiagrams/ActivityEdgeDescription.xsl" />
	<xsl:import href="../Common/Arrowheads.xsl" />
	<xsl:import href="../Common/Styling.xsl" />
	<xsl:import href="../Common/Lines.xsl" />

	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

	<!-- ExceptionHandler edge, displayed as a simple line with a simple arrowhead -->
	<xsl:template name="ExceptionHandler">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<xsl:variable name="PathData">
			<xsl:call-template name="BuildPathData" />
		</xsl:variable>

		<!-- The main ExceptionHandler group -->
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
				ExceptionHandler
				<xsl:value-of select="$SemanticID" />
			</title>

			<!-- The marker -->
			<xsl:call-template name="DirectedArrowheadEnd">
				<xsl:with-param
					name="OwnerDiagramID"
					select="@xmi.id" />
			</xsl:call-template>

			<!-- The line -->
			<path
				d="{$PathData}"
				fill="none"
				marker-end="url(#DirectedArrowheadEnd{@xmi.id})" />

			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'StereotypeCompartment'">
						<!-- Stereotype compartment -->
						<xsl:call-template name="StereotypeCompartment">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$SemanticID" />
						</xsl:call-template>
					</xsl:when>

					<!-- Name -->
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
						<xsl:call-template name="Name">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$SemanticID" />
						</xsl:call-template>
					</xsl:when>

					<!-- ImageAdornment: a small lightning bolt -->
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'ImageAdornment'">
						<g
							id="{@xmi.id}"
							transform="translate({UML:GraphElement.position/XMI.field[1]}, {UML:GraphElement.position/XMI.field[2]})">
							<path
								fill="none"
								d="M 0 0 H {UML:GraphNode.size/XMI.field[1]} L 0 {UML:GraphNode.size/XMI.field[2]-3} H {UML:GraphNode.size/XMI.field[1]} l -3 -3 m 3 3 l -3 3" />
						</g>
					</xsl:when>

				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>
</xsl:stylesheet>