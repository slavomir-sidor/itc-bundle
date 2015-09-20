<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: CompartmentSeparator.xsl A compartment separator is a simple horizontal 
	line -->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:import href="Styling.xsl" />
	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

	<!-- Compartment separator -->
	<xsl:template name="CompartmentSeparator">

		<!-- Main compartment separator group -->
		<g
			id="{@xmi.id}"
			transform="translate({UML:GraphElement.position/XMI.field[1]}, {UML:GraphElement.position/XMI.field[2]})">
			<xsl:apply-templates
				select="."
				mode="StrokeStyle" />
			<xsl:apply-templates
				select="."
				mode="isVisible" />

			<desc>
				<xsl:text>Compartment separator</xsl:text>
			</desc>

			<!-- Compartment separator line -->
			<line
				x1="0"
				y1="0"
				x2="{UML:GraphNode.size/XMI.field[1]}"
				y2="0" />
		</g>
	</xsl:template>
</xsl:stylesheet>
