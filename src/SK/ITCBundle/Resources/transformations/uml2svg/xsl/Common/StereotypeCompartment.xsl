<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: StereotypeCompartment.xsl A stereotype compartment is a list of comma 
	separated stereotypes between guillmets ( << ...,... >> ) -->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:import href="Globals.xsl" />
	<xsl:import href="Styling.xsl" />
	<xsl:import href="Text.xsl" />
	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

	<!-- Stereotype Compartment -->
	<xsl:template name="StereotypeCompartment">
		<xsl:param
			name="OwnerSemanticID"
			select="../../../../UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
		<xsl:param
			name="TextDecoration"
			select="''" />

		<!-- Main Stereotype Compartment group -->
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
				<xsl:text>Stereotype Compartment for </xsl:text>
				<xsl:value-of select="key('xmi.id', $OwnerSemanticID)/@name" />
			</desc>
			<desc>
				<xsl:text>Stereotype Compartment</xsl:text>
			</desc>

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'StereotypeStart'">
						<!-- Stereotype start, a '<<' symbol -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$StereotypeStart" />
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*">
						<!-- Stereotypes -->
						<xsl:variable
							name="StereotypeID"
							select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="key('xmi.id', $StereotypeID)/@name" />
							<xsl:with-param
								name="Space"
								select="'preserve'" />
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'KeywordMetaclass'">
						<!-- Metaclass -> Extend / Include -->
						<xsl:call-template name="Text">
							<xsl:with-param name="String">
								<xsl:choose>
									<xsl:when test="key('xmi.id', $OwnerSemanticID)/self::UML:Interface">
										<xsl:value-of select="'interface'" />
									</xsl:when>
									<xsl:when test="key('xmi.id', $OwnerSemanticID)/self::UML:Actor">
										<xsl:value-of select="'actor'" />
									</xsl:when>
									<xsl:when test="key('xmi.id', $OwnerSemanticID)/self::UML:Extend">
										<xsl:value-of select="'extend'" />
									</xsl:when>
									<xsl:when test="key('xmi.id', $OwnerSemanticID)/self::UML:Include">
										<xsl:value-of select="'include'" />
									</xsl:when>
									<xsl:when
										test="key('xmi.id', $OwnerSemanticID)/self::UML:Component or key('xmi.id', $OwnerSemanticID)/self::UML:ComponentInstance">
										<xsl:value-of select="'component'" />
									</xsl:when>
								</xsl:choose>
							</xsl:with-param>
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'StereotypeSeparator'">
						<!-- Stereotypes separators, ',' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$StereotypeSeparator" />
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'StereotypeEnd'">
						<!-- Stereotype end, a '>>' symbol -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$StereotypeEnd" />
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>
</xsl:stylesheet>
