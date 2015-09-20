<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: SendSignalAction.xsl - UML2 Some kind of object -->
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

	<!-- SendSignalAction -->
	<xsl:template name="SendSignalAction">

		<xsl:param
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- Main SendSignalAction group -->
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
			<desc>SendSignalAction</desc>

			<xsl:variable
				name="width"
				select="UML:GraphNode.size/XMI.field[1]" />
			<xsl:variable
				name="height"
				select="UML:GraphNode.size/XMI.field[2]" />

			<xsl:variable name="w">
				<xsl:choose>
					<xsl:when test="$width >= 100 ">
						20
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$width * 0.2" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>

			<!-- <xsl:message><xsl:value-of select="$width" /></xsl:message> <xsl:message><xsl:value-of 
				select="$width >= 100" /></xsl:message> -->

			<!-- The outline shape, a Rectangle with a strange edge -->
			<path
				d="M 0 0 h {$width - $w} l {$w} {$height div 2.0} l {- $w} {$height div 2.0} h {- $width + $w} z">
				<xsl:apply-templates
					select="."
					mode="FillStyle" />
			</path>

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/*">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'StereotypeCompartment'">
						<xsl:call-template name="StereotypeCompartment" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NameCompartment'">
						<xsl:call-template name="NameCompartment">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$SemanticID" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:InputPin">
						<xsl:call-template name="Pin" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:OutputPin">
						<xsl:call-template name="Pin" />
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>
</xsl:stylesheet>
