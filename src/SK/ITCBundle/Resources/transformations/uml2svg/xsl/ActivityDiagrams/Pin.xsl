<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: Pin.xsl - UML2 Some kind of object -->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:import href="../Common/Styling.xsl" />
	<xsl:import href="../Common/NameCompartment.xsl" />

	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

	<!-- Pin -->
	<xsl:template name="Pin">

		<xsl:param
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
		<xsl:param
			name="ShowArrow"
			select="false()" />

		<!-- Main Pin group -->
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
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:InputPin">
						InputPin
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:OutputPin">
						OutputPin
					</xsl:when>
					<xsl:otherwise>
						Pin
					</xsl:otherwise>
				</xsl:choose>
			</desc>

			<xsl:variable
				name="width"
				select="UML:GraphNode.size/XMI.field[1]" />
			<xsl:variable
				name="height"
				select="UML:GraphNode.size/XMI.field[2]" />

			<!-- The outline shape, a rectangle -->
			<rect
				width="{$width}"
				height="{$height}">
				<xsl:apply-templates
					select="."
					mode="FillStyle" />
			</rect>

			<xsl:if
				test="$ShowArrow and (UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:OutputPin)">
				<xsl:variable
					name="w"
					select="$width div 8" />
				<path
					fill="none"
					d="M {$w} {$height div 2} h {$width - $w - $w} l -3 -3 m 3 3 l -3 3" />
			</xsl:if>

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/*">
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
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>
</xsl:stylesheet>
