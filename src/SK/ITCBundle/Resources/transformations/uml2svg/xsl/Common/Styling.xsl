<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: Styling.xsl Obtain display properties -->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

	<xsl:template
		match="text()"
		mode="isVisible" />
	<xsl:template
		match="text()"
		mode="FontStyle" />
	<xsl:template
		match="text()"
		mode="StrokeStyle" />
	<xsl:template
		match="text()"
		mode="FillStyle" />

	<!-- Test for element's visibility -->
	<xsl:template
		match="*"
		mode="isVisible">
		<xsl:if test="@isVisible= 'false'">
			<xsl:attribute name="display"><xsl:text>none</xsl:text></xsl:attribute>
		</xsl:if>
	</xsl:template>

	<!-- Font-family, font-color, font-size -->
	<xsl:template
		match="*"
		mode="FontStyle">
		<xsl:if test="UML:DiagramElement.property/UML:Property[@key='FontSize']">
			<!-- OMG attribute -->
			<xsl:attribute name="font-size">
				<xsl:value-of
				select="UML:DiagramElement.property/UML:Property[@key='FontSize']/@value" />
			</xsl:attribute>
		</xsl:if>
		<xsl:if test="UML:DiagramElement.property/UML:Property[@key='font-size']">
			<!-- Gentleware attribute -->
			<xsl:attribute name="font-size">
				<xsl:value-of
				select="UML:DiagramElement.property/UML:Property[@key='font-size']/@value" />
			</xsl:attribute>
		</xsl:if>
		<xsl:if test="UML:DiagramElement.property/UML:Property[@key='FontColor']">
			<!-- OMG attribute -->
			<xsl:attribute name="fill">
				<xsl:value-of
				select="UML:DiagramElement.property/UML:Property[@key='FontColor']/@value" />
			</xsl:attribute>
		</xsl:if>
		<xsl:if test="UML:DiagramElement.property/UML:Property[@key='font-color']">
			<!-- Gentleware attribute -->
			<xsl:attribute name="fill">
				<xsl:value-of
				select="UML:DiagramElement.property/UML:Property[@key='font-color']/@value" />
			</xsl:attribute>
		</xsl:if>
		<xsl:if test="UML:DiagramElement.property/UML:Property[@key='FontFamily']">
			<!-- OMG attribute -->
			<xsl:attribute name="font-family">
				<xsl:value-of
				select="UML:DiagramElement.property/UML:Property[@key='FontFamily']/@value" />
			</xsl:attribute>
		</xsl:if>
		<xsl:if test="UML:DiagramElement.property/UML:Property[@key='font-family']">
			<!-- Gentleware attribute -->
			<xsl:attribute name="font-family">
				<xsl:value-of
				select="UML:DiagramElement.property/UML:Property[@key='font-family']/@value" />
			</xsl:attribute>
		</xsl:if>
	</xsl:template>

	<!-- Stroke -->
	<xsl:template
		match="*"
		mode="StrokeStyle">
		<xsl:if test="UML:DiagramElement.property/UML:Property[@key='ForegroundColor']">
			<xsl:attribute name="stroke">
				<!-- OMG attribute -->
				<xsl:value-of
				select="UML:DiagramElement.property/UML:Property[@key='ForegroundColor']/@value" />
			</xsl:attribute>
		</xsl:if>
		<xsl:if test="UML:DiagramElement.property/UML:Property[@key='stroke']">
			<xsl:attribute name="stroke">
				<!-- Gentleware attribute -->
				<xsl:value-of
				select="UML:DiagramElement.property/UML:Property[@key='stroke']/@value" />
			</xsl:attribute>
		</xsl:if>
	</xsl:template>

	<!-- Fill -->
	<xsl:template
		match="*"
		mode="FillStyle">
		<xsl:param
			name="DefaultFill"
			select="'white'" />

		<xsl:if
			test="UML:DiagramElement.property/UML:Property[@key='BackgroundColor'] or UML:DiagramElement.property/UML:Property[@key='fill'] or $DefaultFill != 'none'">
			<xsl:attribute name="fill">
				<xsl:choose>
					<xsl:when
				test="UML:DiagramElement.property/UML:Property[@key='BackgroundColor']">
						<!-- OMG attribute -->
						<xsl:value-of
				select="UML:DiagramElement.property/UML:Property[@key='BackgroundColor']/@value" />
					</xsl:when>
					<xsl:when test="UML:DiagramElement.property/UML:Property[@key='fill']">
						<!-- Gentleware attribute -->
						<xsl:value-of
				select="UML:DiagramElement.property/UML:Property[@key='fill']/@value" />
					</xsl:when>
					<xsl:otherwise><xsl:value-of select="$DefaultFill" /></xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
		</xsl:if>

		<xsl:if test="UML:DiagramElement.property/UML:Property[@key='Translucent']">
			<!-- OMG attribute -->
			<xsl:attribute name="fill-opacity"><xsl:text>0</xsl:text></xsl:attribute>
		</xsl:if>
		<xsl:if test="UML:DiagramElement.property/UML:Property[@key='fill-opacity']">
			<!-- Gentleware attribute -->
			<xsl:attribute name="fill-opacity">
                <xsl:value-of
				select="UML:DiagramElement.property/UML:Property[@key='fill-opacity']/@value" />
            </xsl:attribute>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
