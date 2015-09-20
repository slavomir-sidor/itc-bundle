<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: FreeText.xsl Displays Free Text elements -->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:import href="Styling.xsl" />
	<xsl:import href="Text.xsl" />
	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

	<!-- FreeText -->
	<xsl:template name="FreeText">

		<!-- Main FreeText group -->
		<g
			id="{@xmi.id}"
			transform="translate({UML:GraphElement.position/XMI.field[1]}, {UML:GraphElement.position/XMI.field[2]})">
			<xsl:apply-templates
				select="."
				mode="FontStyle" />
			<xsl:apply-templates
				select="."
				mode="isVisible" />

			<desc>
				<xsl:text>FreeText</xsl:text>
			</desc>

			<!-- FreeText text -->
			<xsl:call-template name="Text">
				<xsl:with-param
					name="String"
					select="UML:GraphElement.contained/UML:TextElement/@text" />
				<xsl:with-param
					name="Space"
					select="'preserve'" />
				<xsl:with-param
					name="x"
					select="0" />
				<xsl:with-param
					name="y"
					select="0" />
			</xsl:call-template>
		</g>
	</xsl:template>
</xsl:stylesheet>
