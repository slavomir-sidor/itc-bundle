<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: InterruptableActivityRegion.xsl - UML2 -->

<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:import href="../Common/Styling.xsl" />
	<xsl:import href="../ActivityDiagrams/Compartment.xsl" />


	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

	<!-- InterruptableActivityRegion -->
	<xsl:template name="InterruptableActivityRegion">

		<xsl:param
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- Main InterruptableActivityRegion group -->
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
			<desc>InterruptableActivityRegion</desc>

			<!-- Outline variables -->
			<xsl:variable name="rx">
				<xsl:choose>
					<xsl:when test="UML:GraphNode.size/XMI.field[1] &lt; 150">
						<xsl:text>10</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="UML:GraphNode.size/XMI.field[1] * 0.066" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>

			<xsl:variable name="ry">
				<xsl:choose>
					<xsl:when test="UML:GraphNode.size/XMI.field[2] &lt; 150">
						<xsl:text>10</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="UML:GraphNode.size/XMI.field[2] * 0.066" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>

			<!-- The outline shape, a rounded corner rectangle with dashed lines -->
			<rect
				style="stroke-dasharray: 10 6"
				width="{UML:GraphNode.size/XMI.field[1]}"
				height="{UML:GraphNode.size/XMI.field[2]}"
				rx="{$rx}"
				ry="{$ry}">
				<xsl:apply-templates
					select="."
					mode="FillStyle" />
			</rect>

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/*">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'BodyCompartment'">
						<xsl:call-template name="Compartment">
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
