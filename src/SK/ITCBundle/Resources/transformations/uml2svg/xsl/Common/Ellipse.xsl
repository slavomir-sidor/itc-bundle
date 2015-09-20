<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: Ellipse.xsl Displays a simple ellipse. -->
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

	<!-- Ellipse -->
	<xsl:template name="Ellipse">

		<!-- Main ellipse group -->
		<g
			id="{@xmi.id}"
			transform="translate({UML:Ellipse.center/XMI.field[1] - @radiusX}, {UML:Ellipse.center/XMI.field[2] - @radiusY})">
			<xsl:apply-templates
				select="."
				mode="StrokeStyle" />
			<xsl:apply-templates
				select="."
				mode="isVisible" />

			<desc>
				<xsl:text>Ellipse</xsl:text>
			</desc>

			<!-- The ellipse -->
			<ellipse
				cx="{@radiusX}"
				cy="{@radiusY}"
				rx="{@radiusX}"
				ry="{@radiusY}">
				<xsl:apply-templates
					select="."
					mode="FillStyle" />
			</ellipse>
		</g>
	</xsl:template>
</xsl:stylesheet>
