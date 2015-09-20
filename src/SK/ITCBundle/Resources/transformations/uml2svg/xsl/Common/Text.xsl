<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: Text.xsl -->
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

	<!-- Text -->
	<xsl:template name="Text">
		<xsl:param name="String" />
		<xsl:param
			name="x"
			select="UML:GraphElement.position/XMI.field[1]" />
		<xsl:param
			name="y"
			select="UML:GraphElement.position/XMI.field[2]" />
		<xsl:param
			name="OffsetY"
			select="1.0" /> <!-- Y offset measured in em -->
		<xsl:param name="Space" />
		<xsl:param
			name="TextDecoration"
			select="''" /> <!-- underline -->
		<xsl:param
			name="FontStyle"
			select="''" /> <!-- italic -->
		<xsl:param
			name="FontWeight"
			select="''" /> <!-- normal or bold -->
		<xsl:choose>
			<xsl:when
				test="substring-before($String, '&#xA;') or substring-after($String, '&#xA;')">
				<!-- Text on multiple lines (!WARNING: do not break the following line) -->
				<text
					transform="translate({$x}, {$y})"
					y="{$OffsetY}em">
					<xsl:apply-templates
						select="."
						mode="FontStyle" />
					<xsl:if test="$FontStyle != ''">
						<xsl:attribute name="font-style"><xsl:value-of select="$FontStyle" /></xsl:attribute>
					</xsl:if>
					<xsl:if test="$FontWeight != ''">
						<xsl:attribute name="font-weight"><xsl:value-of select="$FontWeight" /></xsl:attribute>
					</xsl:if>
					<xsl:if test="$TextDecoration != ''">
						<xsl:attribute name="text-decoration"><xsl:value-of select="$TextDecoration" /></xsl:attribute>
					</xsl:if>
					<xsl:if test="$Space = 'preserve'">
						<xsl:attribute name="xml:space">preserve</xsl:attribute>
					</xsl:if>
					<xsl:attribute name="stroke">none</xsl:attribute>
					<xsl:value-of select="substring-before($String, '&#xA;')" />
				</text>
				<!-- Call this template recursively for the rest of the lines -->
				<xsl:call-template name="Text">
					<xsl:with-param
						name="String"
						select="substring-after($String, '&#xA;')" />
					<xsl:with-param
						name="x"
						select="$x" />
					<xsl:with-param
						name="y"
						select="$y" />
					<xsl:with-param
						name="OffsetY"
						select="$OffsetY + 1.2" />
					<xsl:with-param
						name="Space"
						select="$Space" />
					<xsl:with-param
						name="TextDecoration"
						select="$TextDecoration" />
					<xsl:with-param
						name="FontStyle"
						select="$FontStyle" />
					<xsl:with-param
						name="FontWeight"
						select="$FontWeight" />
				</xsl:call-template>
			</xsl:when>

			<xsl:otherwise>
				<!-- Text on a single line (!WARNING: do not break the following line) -->
				<text
					transform="translate({$x}, {$y})"
					y="{$OffsetY}em">
					<xsl:apply-templates
						select="."
						mode="FontStyle" />
					<xsl:if test="$FontStyle != ''">
						<xsl:attribute name="font-style"><xsl:value-of select="$FontStyle" /></xsl:attribute>
					</xsl:if>
					<xsl:if test="$FontWeight != ''">
						<xsl:attribute name="font-weight"><xsl:value-of select="$FontWeight" /></xsl:attribute>
					</xsl:if>
					<xsl:if test="$TextDecoration != ''">
						<xsl:attribute name="text-decoration"><xsl:value-of select="$TextDecoration" /></xsl:attribute>
					</xsl:if>
					<xsl:if test="$Space = 'preserve'">
						<xsl:attribute name="xml:space">preserve</xsl:attribute>
					</xsl:if>
					<xsl:attribute name="stroke">none</xsl:attribute>
					<xsl:value-of select="$String" />
				</text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
