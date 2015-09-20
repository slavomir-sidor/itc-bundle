<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: PackageClass.xsl Displays Packages from class diagrams -->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:import href="../Common/Styling.xsl" />
	<xsl:import href="../Common/NameCompartment.xsl" />
	<xsl:import href="../ClassDiagrams/PackageClassBody.xsl" />
	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

	<!-- Package -->
	<xsl:template name="PackageClass">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- Main Package group -->
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
				<xsl:text>Package </xsl:text>
				<xsl:value-of select="key('xmi.id', $SemanticID)/@name" />
			</title>
			<desc>
				<xsl:text>Package</xsl:text>
			</desc>

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NameCompartment'">
						<!-- Name compartment -->
						<!-- The package name outline shape, a rectangle -->
						<rect
							x="{UML:GraphElement.position/XMI.field[1]}"
							y="{UML:GraphElement.position/XMI.field[2]}"
							width="{UML:GraphNode.size/XMI.field[1]}"
							height="{UML:GraphNode.size/XMI.field[2]}">
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
						</rect>
						<xsl:call-template name="NameCompartment" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'BodyCompartment'">
						<xsl:call-template name="PackageClassBody" />
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>
</xsl:stylesheet>
