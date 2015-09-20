<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: Polyline.xsl Displays a simple polyline -->
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

	<!-- Polyline -->
	<xsl:template name="Polyline">

		<!-- Main Polyline group -->
		<g id="{@xmi.id}">
			<xsl:apply-templates
				select="."
				mode="StrokeStyle" />
			<xsl:apply-templates
				select="."
				mode="isVisible" />

			<desc>
				<xsl:text>Polyline</xsl:text>
			</desc>

			<!-- The Polyline -->
			<path>
				<xsl:choose>
					<xsl:when test="@closed = 'false'">
						<xsl:attribute name="fill">none</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates
							select="."
							mode="FillStyle">
							<xsl:with-param
								name="DefaultFill"
								select="'white'" />
						</xsl:apply-templates>
					</xsl:otherwise>
				</xsl:choose>
				<!-- Build the path data -->
				<xsl:attribute name="d">
					<xsl:text>M </xsl:text>
					<xsl:for-each select="UML:Polyline.waypoints/XMI.field">
						<xsl:choose>
						  <xsl:when test="position() = 1">
							<xsl:value-of select="./XMI.field[position()=1]" /><xsl:text> </xsl:text>
							<xsl:value-of select="./XMI.field[position()=2]" /><xsl:text> L </xsl:text>
						  </xsl:when>
						  <xsl:otherwise>
							<xsl:if test="(position() mod 3) = 1">
								<xsl:value-of select="./XMI.field[position()=1]" /><xsl:text> </xsl:text>
								<xsl:value-of select="./XMI.field[position()=2]" /><xsl:text> </xsl:text>
							</xsl:if>
						  </xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
					<xsl:if test="@closed = 'true'"><xsl:text>z</xsl:text></xsl:if>
				</xsl:attribute>
			</path>
		</g>
	</xsl:template>
</xsl:stylesheet>
