<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: Object.xsl Displays objects from collaboration diagrams -->
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

	<!-- Object -->
	<xsl:template name="Object">

		<xsl:param
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- Main Object group -->
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
				<xsl:text>Object</xsl:text>
			</desc>

			<!-- The outline shape, a rectangle -->
			<rect
				width="{UML:GraphNode.size/XMI.field[1]}"
				height="{UML:GraphNode.size/XMI.field[2]}">
				<xsl:choose>
					<!-- Object in sequence diagram -->
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement[@typeInfo='HeaderCompartment'] and ../../UML:GraphElement.semanticModel//UML:Object">
						<xsl:apply-templates
							select="../.."
							mode="FillStyle" />
						<xsl:apply-templates
							select="."
							mode="FillStyle">
							<xsl:with-param
								name="DefaultFill"
								select="'none'" />
						</xsl:apply-templates>
						<!-- Active? -->
						<xsl:for-each
							select="key('xmi.id', $SemanticID)/UML:ModelElement.taggedValue/UML:TaggedValue">
							<xsl:variable
								name="idref"
								select=".//*[@xmi.idref]/@xmi.idref" />
							<xsl:if
								test="(key('xmi.id', $idref)/@name = 'isActive') and (UML:TaggedValue.dataValue = 'true')">
								<xsl:attribute name="stroke-width"><xsl:text>3px</xsl:text></xsl:attribute>
							</xsl:if>
						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates
							select="."
							mode="FillStyle" />
					</xsl:otherwise>
				</xsl:choose>
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

						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>
</xsl:stylesheet>
