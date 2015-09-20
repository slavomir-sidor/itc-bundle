<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: Name.xsl Displays element names -->
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

	<!-- Name -->
	<xsl:template name="Name">
		<xsl:param
			name="OwnerSemanticID"
			select="../../../../UML:GraphElement.semanticModel//@xmi.idref" />
		<xsl:param
			name="TextDecoration"
			select="''" />
		<xsl:param
			name="FontWeight"
			select="''" />

		<!-- Main Name group -->
		<g
			id="{@xmi.id}"
			transform="translate({UML:GraphElement.position/XMI.field[1]}, {UML:GraphElement.position/XMI.field[2]})">
			<xsl:apply-templates
				select="."
				mode="FontStyle" />
			<xsl:apply-templates
				select="."
				mode="isVisible" />
			<xsl:if test="key('xmi.id', $OwnerSemanticID)/@isAbstract = 'true'">
				<xsl:attribute name="font-style">italic</xsl:attribute>
			</xsl:if>
			<xsl:if test="$FontWeight = 'bold'">
				<xsl:attribute name="font-weight">bold</xsl:attribute>
			</xsl:if>
			<desc>
				<xsl:text>Name</xsl:text>
			</desc>

			<!-- Name text -->
			<xsl:call-template name="Text">
				<xsl:with-param
					name="String"
					select="key('xmi.id', $OwnerSemanticID)/@name" />
				<xsl:with-param
					name="Space"
					select="'preserve'" />
				<xsl:with-param
					name="x"
					select="0" />
				<xsl:with-param
					name="y"
					select="0" />
				<xsl:with-param
					name="TextDecoration"
					select="$TextDecoration" />
			</xsl:call-template>
		</g>
	</xsl:template>
</xsl:stylesheet>
