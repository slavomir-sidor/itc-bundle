<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: Interface_Ball.xsl Displays Interface as a ball -->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:import href="../Common/Styling.xsl" />
	<xsl:import href="../Common/Name.xsl" />
	<xsl:import href="../Common/NamespaceCompartment.xsl" />
	<xsl:import href="../Common/StereotypeCompartment.xsl" />
	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

	<!-- Interface_Ball -->
	<xsl:template name="Interface_Ball">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- Interface_Ball outline parameters -->
		<xsl:variable name="rx">
			<xsl:value-of select="UML:GraphNode.size/XMI.field[1] div 2" />
		</xsl:variable>
		<xsl:variable name="ry">
			<xsl:value-of select="UML:GraphNode.size/XMI.field[2] div 2" />
		</xsl:variable>

		<!-- Main Interface_Ball group -->
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
				<xsl:text>Interface_Ball</xsl:text>
			</desc>

			<!-- The outline shape, a Circle -->
			<ellipse
				cx="{$rx}"
				cy="{$ry}"
				rx="{$rx}"
				ry="{$ry}">
				<xsl:apply-templates
					select="."
					mode="FillStyle" />
			</ellipse>

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'StereotypeCompartment'">
						<!-- Interface Stereotypes -->
						<xsl:call-template name="StereotypeCompartment">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$SemanticID" />
						</xsl:call-template>
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
						<!-- Interface Name -->
						<xsl:call-template name="Name">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$SemanticID" />
							<xsl:with-param
								name="FontWeight"
								select="'bold'" />
						</xsl:call-template>
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NamespaceCompartment'">
						<!-- Interface Namespace -->
						<xsl:call-template name="NamespaceCompartment">
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
