<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:UML="org.omg.xmi.namespace.UML"
	xmlns:UML2="org.omg.xmi.namespace.UML2"
	xmlns="http://www.w3.org/2000/svg"
	version="1.0"
	exclude-result-prefixes="UML UML2">
	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

	<!--********************************************************************** -->


	<xsl:variable name="uml2svgVersion">
		0.17
	</xsl:variable>

	<xsl:param name="UmlStdVersion">
		1.5
	</xsl:param>

	<xsl:param name="TypeSeparator">
		:
	</xsl:param>
	<xsl:param name="ParameterSeparator">
		,
	</xsl:param>
	<xsl:param name="ParameterStart">
		(
	</xsl:param>
	<xsl:param name="ParameterEnd">
		)
	</xsl:param>

	<xsl:param name="PublicVisibility">
		+
	</xsl:param>
	<xsl:param name="ProtectedVisibility">
		#
	</xsl:param>
	<xsl:param name="PackageVisibility">
		~
	</xsl:param>
	<xsl:param name="PrivateVisibility">
		-
	</xsl:param>

	<xsl:param name="Derived">
		/
	</xsl:param>
	<xsl:param name="MultiplicityStart">
		[
	</xsl:param>
	<xsl:param name="MultiplicityEnd">
		]
	</xsl:param>
	<xsl:param name="InitialValueSeparator">
		=
	</xsl:param>

	<xsl:param name="ExpressionStart">
		{
	</xsl:param>
	<xsl:param name="ExpressionSeparator">
		,
	</xsl:param>
	<xsl:param name="ExpressionEnd">
		}
	</xsl:param>

	<xsl:param name="NamespaceStart">
		(from
	</xsl:param>
	<xsl:param name="NamespaceSeparator">
		::
	</xsl:param>
	<xsl:param name="NamespaceEnd">
		)
	</xsl:param>

	<xsl:param name="StereotypeStart">&lt;&lt;
	</xsl:param>
	<xsl:param name="StereotypeSeparator">
		,
	</xsl:param>
	<xsl:param name="StereotypeEnd">&gt;&gt;
	</xsl:param>

	<xsl:param name="InStatesStart">
		[
	</xsl:param>
	<xsl:param name="InStatesEnd">
		]
	</xsl:param>

	<xsl:param name="NameLocationSeparator">
		:
	</xsl:param>

	<xsl:param name="TriggerSeparator">
		|
	</xsl:param>

	<xsl:param name="GuardStart">
		[
	</xsl:param>
	<xsl:param name="GuardEnd">
		]
	</xsl:param>
	<xsl:param name="EffectStart">
		/
	</xsl:param>

	<xsl:param name="MessageSeparator">
		.
	</xsl:param>

	<xsl:param name="AEGuardStart">
		[
	</xsl:param>
	<xsl:param name="AEGuardEnd">
		]
	</xsl:param>

	<xsl:param name="WeightStart">
		{
	</xsl:param>
	<xsl:param name="WeightIs">
		weight=
	</xsl:param>
	<xsl:param name="WeightEnd">
		}
	</xsl:param>

	<xsl:param
		name="CommentPaddingLeft"
		select="10" />
	<xsl:param
		name="CommentPaddingTop"
		select="10" />

	<xsl:param
		name="ViewBoxPaddingLeft"
		select="20" />
	<xsl:param
		name="ViewBoxPaddingRight"
		select="20" />
	<xsl:param
		name="ViewBoxPaddingTop"
		select="20" />
	<xsl:param
		name="ViewBoxPaddingBottom"
		select="20" />

	<xsl:param
		name="TreeWidth"
		select="200" />


	<!--********************************************************************** -->
	<!-- Template: Styling.xsl Obtain display properties -->

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

	<!--********************************************************************** -->
	<!-- Template: Text.xsl -->

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

	<!--********************************************************************** -->
	<!-- Template: StereotypeCompartment.xsl A stereotype compartment is a list of comma 
		separated stereotypes between guillmets ( << ...,... >> ) -->

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

	<!--********************************************************************** -->
	<!-- Template: Name.xsl Displays element names -->

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

	<!--********************************************************************** -->
	<!-- Template: NameAndType.xsl Displays name and type of an object (all is underlined) -->

	<!-- NameAndType -->
	<xsl:template name="NameAndType">
		<xsl:param
			name="OwnerSemanticID"
			select="../../../../UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- Main NameAndType group -->
		<g
			id="{@xmi.id}"
			transform="translate({UML:GraphElement.position/XMI.field[1]}, {UML:GraphElement.position/XMI.field[2]})">
			<xsl:apply-templates
				select="."
				mode="FontStyle" />
			<xsl:apply-templates
				select="."
				mode="isVisible" />

			<title>
				<xsl:text>NameAndType for </xsl:text>
				<xsl:value-of select="$OwnerSemanticID" />
			</title>
			<desc>
				<xsl:text>NameAndType</xsl:text>
			</desc>

			<!-- NameAndType text should be underlined -->

			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
						<!-- Name -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="key('xmi.id', $OwnerSemanticID)/@name" />
							<xsl:with-param
								name="Space"
								select="'preserve'" />
							<xsl:with-param
								name="TextDecoration"
								select="'underline'" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'TypeSeparator'">
						<!-- Type separators, ':' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$TypeSeparator" />
							<xsl:with-param
								name="TextDecoration"
								select="'underline'" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*">
						<!-- Type -->
						<xsl:variable name="TypeID">
							<xsl:value-of
								select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
						</xsl:variable>
						<xsl:variable
							name="x1"
							select="UML:GraphElement.position/XMI.field[1]" />
						<xsl:variable
							name="y1"
							select="UML:GraphElement.position/XMI.field[2]" />
						<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
							<xsl:choose>
								<xsl:when
									test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
									<!-- Type Name -->
									<xsl:call-template name="Text">
										<xsl:with-param
											name="String"
											select="key('xmi.id', $TypeID)/@name" />
										<xsl:with-param
											name="Space"
											select="'preserve'" />
										<xsl:with-param
											name="x"
											select="UML:GraphElement.position/XMI.field[1] + $x1" />
										<xsl:with-param
											name="y"
											select="UML:GraphElement.position/XMI.field[2] + $y1" />
										<xsl:with-param
											name="TextDecoration"
											select="'underline'" />
									</xsl:call-template>
								</xsl:when>
							</xsl:choose>
						</xsl:for-each>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: NamespaceCompartment.xsl A namespace compartment is a double-collon 
		separated list of container names between paranthesis ( (from ...::... ) ) -->

	<!-- Namespace -->
	<xsl:template name="NamespaceCompartment">

		<!-- Main Namespace group -->
		<g
			id="{@xmi.id}"
			transform="translate({UML:GraphElement.position/XMI.field[1]}, {UML:GraphElement.position/XMI.field[2]})">
			<xsl:apply-templates
				select="."
				mode="FontStyle" />
			<xsl:apply-templates
				select="."
				mode="isVisible" />
			<xsl:attribute name="font-style">italic</xsl:attribute>

			<desc>
				<xsl:text>Namespace</xsl:text>
			</desc>

			<!-- Namespace contents -->
			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NamespaceStart'">
						<!-- Namespace start, '(from' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$NamespaceStart" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*">
						<!-- Namespace elements -->
						<xsl:variable
							name="ContainerSemanticID"
							select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="key('xmi.id', $ContainerSemanticID)/@name" />
							<xsl:with-param
								name="Space"
								select="'preserve'" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NamespaceSeparator'">
						<!-- Namespace separator, '::' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$NamespaceSeparator" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NamespaceEnd'">
						<!-- Namespace end, ')' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$NamespaceEnd" />
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: ExpressionCompartment.xsl An expression compartment is a comma separated 
		list of expressions (constraints) contained between braces { ... , ... } -->

	<!-- Expression compartment -->
	<xsl:template name="ExpressionCompartment">
		<xsl:param
			name="OwnerSemanticID"
			select="../../../../UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
		<xsl:param
			name="TextDecoration"
			select="''" />

		<!-- Main expression compartment group -->
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
				<xsl:text>Expression compartment for </xsl:text>
				<xsl:value-of select="key('xmi.id', $OwnerSemanticID)/@name" />
			</title>
			<desc>
				<xsl:text>Expression compartment</xsl:text>
			</desc>

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'ExpressionStart'">
						<!-- Expression start, '{' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$ExpressionStart" />
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*">
						<!-- Expressions -->
						<xsl:variable
							name="ConstraintSemanticID"
							select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="key('xmi.id', $ConstraintSemanticID)/UML:Constraint.body/*/@body" />
							<xsl:with-param
								name="Space"
								select="'preserve'" />
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'ExpressionSeparator'">
						<!-- Expression separators, ',' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$ExpressionSeparator" />
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Ordering'">
						<!-- Ordering -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="key('xmi.id', $OwnerSemanticID)/@ordering" />
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'ExpressionEnd'">
						<!-- Expression end, '}' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$ExpressionEnd" />
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: NameCompartment.xsl Displays element properties (stereotypes, name, 
		namespace, constraints) -->

	<!-- NameCompartment -->
	<xsl:template name="NameCompartment">
		<xsl:param
			name="OwnerSemanticID"
			select="../../UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
		<xsl:param
			name="TextDecoration"
			select="''" />

		<!-- Main NameCompartment group -->
		<g
			id="{@xmi.id}"
			transform="translate({UML:GraphElement.position/XMI.field[1]}, {UML:GraphElement.position/XMI.field[2]})">
			<xsl:apply-templates
				select="."
				mode="FontStyle" />
			<xsl:apply-templates
				select="."
				mode="isVisible" />


			<xsl:if
				test="local-name(key('xmi.id', $OwnerSemanticID)) = 'ActivityPartition' and ((../../../../UML:DiagramElement.property/UML:Property[@key = 'layout']/@value = 'horizontal') or ((../../../../UML:DiagramElement.property/UML:Property[@key = 'layout']/@value = 'matrix') and ../../UML:DiagramElement.property/UML:Property[@key = 'column']/@value = '0'))">
				<xsl:attribute name="transform">translate(<xsl:value-of
					select="UML:GraphElement.position/XMI.field[1]" />, <xsl:value-of
					select="UML:GraphElement.position/XMI.field[2]" />) rotate(-90)</xsl:attribute>
			</xsl:if>


			<desc>
				<xsl:text>NameCompartment</xsl:text>
			</desc>

			<xsl:if test="local-name(key('xmi.id', $OwnerSemanticID)) = 'Diagram'">
				<!-- The outline shape - a rectangle with a missing bottom-right edge -->
				<xsl:variable
					name="width"
					select="UML:GraphNode.size/XMI.field[1]" />
				<xsl:variable
					name="height"
					select="UML:GraphNode.size/XMI.field[2]" />
				<path d="M 0 0 h {$width} v {$height - 8} l -8 8 h {-$width+8} z">
					<xsl:apply-templates
						select="."
						mode="FillStyle" />
				</path>
			</xsl:if>

			<xsl:if test="local-name(key('xmi.id', $OwnerSemanticID)) = 'ActivityPartition'">
				<rect
					width="{UML:GraphNode.size/XMI.field[1]}"
					height="{UML:GraphNode.size/XMI.field[2]}">
					<xsl:apply-templates
						select="."
						mode="FillStyle" />
				</rect>
			</xsl:if>

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'StereotypeCompartment'">
						<!-- Stereotype compartment -->
						<xsl:call-template name="StereotypeCompartment">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$OwnerSemanticID" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
						<!-- Name -->
						<xsl:variable name="FontWeight">
							<xsl:if
								test="../../../../UML:GraphElement.semanticModel//UML:Class or ../../../../UML:GraphElement.semanticModel//*[@presentation = 'Classifier'] or ../../../../UML:GraphElement.semanticModel//UML:Interface or ../../../../UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'AssociationClassNode'">
								<xsl:text>bold</xsl:text>
							</xsl:if>
						</xsl:variable>
						<xsl:call-template name="Name">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$OwnerSemanticID" />
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
							<xsl:with-param
								name="FontWeight"
								select="$FontWeight" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NameAndType'">
						<!-- Name and Type -->
						<xsl:call-template name="NameAndType">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$OwnerSemanticID" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NamespaceCompartment'">
						<!-- Namespace compartment -->
						<xsl:call-template name="NamespaceCompartment">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$OwnerSemanticID" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'ExpressionCompartment'">
						<!-- Expression compartment -->
						<xsl:call-template name="ExpressionCompartment">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$OwnerSemanticID" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'TypeSeparator'">
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$TypeSeparator" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'SubmachineType'">
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
								<xsl:text>SubmachineType</xsl:text>
							</desc>

							<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
								<xsl:choose>
									<xsl:when
										test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:StateMachine">
										<xsl:variable
											name="StateMachineID"
											select=" UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:StateMachine/@xmi.idref" />
										<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
											<xsl:choose>
												<xsl:when
													test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
													<xsl:call-template name="Name">
														<xsl:with-param
															name="OwnerSemanticID"
															select="$StateMachineID" />
													</xsl:call-template>
												</xsl:when>
											</xsl:choose>
										</xsl:for-each>
									</xsl:when>
								</xsl:choose>
							</xsl:for-each>
						</g>
					</xsl:when>
				</xsl:choose>

			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: NewVisibility.xsl Transforms the visibility of an element to the 
		apropriate string (+,-,#,~) -->

	<!-- Visibility -->
	<xsl:template name="Visibility">
		<xsl:param
			name="OwnerSemanticID"
			select="../../UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<xsl:variable
			name="visibility"
			select="key('xmi.id', $OwnerSemanticID)/@visibility" />
		<xsl:choose>
			<xsl:when test="$visibility = 'public'">
				<xsl:value-of select="$PublicVisibility" />
			</xsl:when>
			<xsl:when test="$visibility = 'package'">
				<xsl:value-of select="$PackageVisibility" />
			</xsl:when>
			<xsl:when test="$visibility = 'protected'">
				<xsl:value-of select="$ProtectedVisibility" />
			</xsl:when>
			<xsl:when test="$visibility = 'private'">
				<xsl:value-of select="$PrivateVisibility" />
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: Multiplicity.xsl Gets the multiplicity of an element -->

	<!-- Multiplicity -->
	<xsl:template name="Multiplicity">
		<xsl:param
			name="OwnerSemanticID"
			select="../../UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<xsl:variable
			name="lower"
			select="key('xmi.id', $OwnerSemanticID)/*/UML:Multiplicity/UML:Multiplicity.range/UML:MultiplicityRange/@lower" />
		<xsl:variable
			name="upper"
			select="key('xmi.id', $OwnerSemanticID)/*/UML:Multiplicity/UML:Multiplicity.range/UML:MultiplicityRange/@upper" />

		<!-- Multiplicity text -->
		<xsl:choose>
			<xsl:when test="$lower = 1 and $upper = 1">
				<xsl:text>1</xsl:text>
			</xsl:when>
			<xsl:when test="$lower = 0 and $upper = 1">
				<xsl:text>0..1</xsl:text>
			</xsl:when>
			<xsl:when test="$lower = 1 and $upper = -1">
				<xsl:text>1..*</xsl:text>
			</xsl:when>
			<xsl:when test="$lower = 0 and $upper = -1">
				<xsl:text>*</xsl:text>
			</xsl:when>
			<xsl:when test="$lower = $upper">
				<xsl:value-of select="$lower" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$lower" />
				<xsl:text>..</xsl:text>
				<xsl:value-of select="$upper" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: Attribute.xsl Displays Attributes -->

	<!-- Attribute -->
	<xsl:template name="Attribute">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
		<xsl:variable name="TextDecoration">
			<xsl:choose>
				<xsl:when test="key('xmi.id', $SemanticID)/@ownerScope = 'classifier'">
					<xsl:text>underline</xsl:text>
				</xsl:when>
				<xsl:otherwise />
			</xsl:choose>
		</xsl:variable>

		<!-- Main Attribute group -->
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
			<xsl:if test="key('xmi.id', $SemanticID)/@isAbstract = 'true'">
				<xsl:attribute name="font-style">italic</xsl:attribute>
			</xsl:if>

			<title>
				<xsl:text>Attribute </xsl:text>
				<xsl:value-of select="key('xmi.id', $SemanticID)/@name" />
			</title>
			<desc>
				<xsl:text>Attribute</xsl:text>
			</desc>

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/*">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'StereotypeCompartment'">
						<!-- Stereotype compartment -->
						<xsl:call-template name="StereotypeCompartment">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$SemanticID" />
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Derived'">
						<!-- Derived, '/' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$Derived" />
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Visibility'">
						<!-- Visibility -->
						<xsl:call-template name="Text">
							<xsl:with-param name="String">
								<xsl:call-template name="Visibility">
									<xsl:with-param
										name="OwnerSemanticID"
										select="$SemanticID" />
								</xsl:call-template>
							</xsl:with-param>
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
						<!-- Name -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="key('xmi.id', $SemanticID)/@name" />
							<xsl:with-param
								name="Space"
								select="'preserve'" />
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'TypeSeparator'">
						<!-- Type separator, ':' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$TypeSeparator" />
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'StructuralFeatureType'">
						<!-- StructuralFeatureType -->
						<xsl:variable
							name="x1"
							select="UML:GraphElement.position/XMI.field[1]" />
						<xsl:variable
							name="y1"
							select="UML:GraphElement.position/XMI.field[2]" />
						<xsl:for-each select="UML:GraphElement.contained/*">
							<xsl:choose>
								<xsl:when
									test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*">
									<!-- Type -->
									<xsl:variable name="TypeID">
										<xsl:value-of
											select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
									</xsl:variable>
									<xsl:variable
										name="x2"
										select="UML:GraphElement.position/XMI.field[1]" />
									<xsl:variable
										name="y2"
										select="UML:GraphElement.position/XMI.field[2]" />
									<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
										<xsl:choose>
											<xsl:when
												test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
												<!-- Type Name -->
												<xsl:call-template name="Text">
													<xsl:with-param name="String">
														<xsl:value-of select="key('xmi.id', $TypeID)/@name" />
													</xsl:with-param>
													<xsl:with-param
														name="Space"
														select="'preserve'" />
													<xsl:with-param
														name="x"
														select="UML:GraphElement.position/XMI.field[1] + $x1 + $x2" />
													<xsl:with-param
														name="y"
														select="UML:GraphElement.position/XMI.field[2] + $y1 + $y2" />
													<xsl:with-param
														name="TextDecoration"
														select="$TextDecoration" />
												</xsl:call-template>
											</xsl:when>
										</xsl:choose>
									</xsl:for-each>
								</xsl:when>
							</xsl:choose>
						</xsl:for-each>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'MultiplicityStart'">
						<!-- MultiplicityStart, '[' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$MultiplicityStart" />
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Multiplicity'">
						<!-- Multiplicity -->
						<xsl:call-template name="Text">
							<xsl:with-param name="String">
								<xsl:call-template name="Multiplicity">
									<xsl:with-param
										name="OwnerSemanticID"
										select="$SemanticID" />
								</xsl:call-template>
							</xsl:with-param>
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'MultiplicityEnd'">
						<!-- MultiplicityEnd, ']' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$MultiplicityEnd" />
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Ordering'">
						<!-- Ordering -->
						<xsl:call-template name="Text">
							<xsl:with-param name="String">
								<xsl:value-of select="key('xmi.id', $SemanticID)/@ordering" />
							</xsl:with-param>
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'InitialValueSeparator'">
						<!-- InitialValueSeparator, '=' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$InitialValueSeparator" />
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'InitialValue'">
						<!-- InitialValue -->
						<xsl:call-template name="Text">
							<xsl:with-param name="String">
								<xsl:value-of
									select="key('xmi.id', $SemanticID)/UML:Attribute.initialValue/*/@body" />
							</xsl:with-param>
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'ExpressionCompartment'">
						<!-- Expression compartment -->
						<xsl:call-template name="ExpressionCompartment">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$SemanticID" />
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: AttributeCompartment.xsl An attribute compartment holds a list of 
		strings, each of which is the encoded representation of an attribute -->

	<!-- Attribute compartment -->
	<xsl:template name="AttributeCompartment">

		<!-- Main attribute compartment group -->
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

			<desc>
				<xsl:text>AttributeCompartment</xsl:text>
			</desc>

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/*">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'DelimitedSection'">
						<!-- Compartment section -->
						<xsl:for-each select="UML:GraphElement.contained/*">
							<xsl:choose>
								<xsl:when
									test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Attribute">
									<!-- Attribute -->
									<xsl:call-template name="Attribute" />
								</xsl:when>
							</xsl:choose>
						</xsl:for-each>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: Parameter.xsl Displays parameters as [kind] name:type -->

	<!-- Parameter -->
	<xsl:template name="Parameter">
		<xsl:param name="OwnerSemanticID" />
		<xsl:param
			name="TextDecoration"
			select="''" />

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

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
				<xsl:text>Parameter </xsl:text>
				<xsl:value-of select="key('xmi.id', $SemanticID)/@name" />
			</title>
			<desc>
				<xsl:text>Parameter</xsl:text>
			</desc>

			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Kind'">
						<!-- Kind -->
						<xsl:call-template name="Text">
							<xsl:with-param name="String">
								<xsl:value-of select="key('xmi.id', $SemanticID)/@kind" />
							</xsl:with-param>
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
						<!-- Name -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="Space"
								select="'preserve'" />
							<xsl:with-param
								name="String"
								select="key('xmi.id', $SemanticID)/@name" />
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'TypeSeparator'">
						<!-- Type separator, ':' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$TypeSeparator" />
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Ordering'">
						<!-- Ordering -->
						<xsl:call-template name="Text">
							<xsl:with-param name="String">
								<xsl:value-of select="key('xmi.id', $SemanticID)/@ordering" />
							</xsl:with-param>
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*">
						<!-- Type -->
						<xsl:variable
							name="TypeID"
							select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
						<xsl:variable
							name="x1"
							select="UML:GraphElement.position/XMI.field[1]" />
						<xsl:variable
							name="y1"
							select="UML:GraphElement.position/XMI.field[2]" />
						<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
							<xsl:choose>
								<xsl:when
									test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
									<!-- Type Name -->
									<xsl:call-template name="Text">
										<xsl:with-param name="String">
											<xsl:value-of select="key('xmi.id', $TypeID)/@name" />
										</xsl:with-param>
										<xsl:with-param
											name="Space"
											select="'preserve'" />
										<xsl:with-param
											name="x"
											select="UML:GraphElement.position/XMI.field[1] + $x1" />
										<xsl:with-param
											name="y"
											select="UML:GraphElement.position/XMI.field[2] + $y1" />
										<xsl:with-param
											name="TextDecoration"
											select="$TextDecoration" />
									</xsl:call-template>
								</xsl:when>
							</xsl:choose>
						</xsl:for-each>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: Operation.xsl Displays Operations -->

	<!-- Operation -->
	<xsl:template name="Operation">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
		<xsl:variable name="TextDecoration">
			<xsl:choose>
				<xsl:when test="key('xmi.id', $SemanticID)/@ownerScope = 'classifier'">
					<xsl:text>underline</xsl:text>
				</xsl:when>
				<xsl:otherwise />
			</xsl:choose>
		</xsl:variable>

		<!-- Main Operation group -->
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
			<xsl:if test="key('xmi.id', $SemanticID)/@isAbstract = 'true'">
				<xsl:attribute name="font-style">italic</xsl:attribute>
			</xsl:if>

			<title>
				<xsl:text>Operation </xsl:text>
				<xsl:value-of select="key('xmi.id', $SemanticID)/@name" />
			</title>
			<desc>
				<xsl:text>Operation</xsl:text>
			</desc>

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/*">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'StereotypeCompartment'">
						<!-- Stereotype compartment -->
						<xsl:call-template name="StereotypeCompartment">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$SemanticID" />
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Visibility'">
						<!-- Visibility -->
						<xsl:call-template name="Text">
							<xsl:with-param name="String">
								<xsl:call-template name="Visibility">
									<xsl:with-param
										name="OwnerSemanticID"
										select="$SemanticID" />
								</xsl:call-template>
							</xsl:with-param>
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
						<!-- Name -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="key('xmi.id', $SemanticID)/@name" />
							<xsl:with-param
								name="Space"
								select="'preserve'" />
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'ParameterStart'">
						<!-- Parameter Start, '(' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$ParameterStart" />
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Parameter">
						<!-- Parameter -->
						<xsl:call-template name="Parameter">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$SemanticID" />
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'ParameterSeparator'">
						<!-- Parameter Separator, ',' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$ParameterSeparator" />
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'ParameterEnd'">
						<!-- Parameter End, ')' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$ParameterEnd" />
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'TypeSeparator'">
						<!-- Type separator, ':' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$TypeSeparator" />
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'ExpressionCompartment'">
						<!-- Expression compartment -->
						<xsl:call-template name="ExpressionCompartment">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$SemanticID" />
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Argument">
						<!-- Argument -->
						<xsl:variable
							name="ArgumentID"
							select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Argument/@xmi.idref" />
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="key('xmi.id', $ArgumentID)/UML:Argument.value/UML:Expression/@body" />
							<xsl:with-param
								name="Space"
								select="'preserve'" />
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>


					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo= 'Assignment'">
						<!-- Assignment -->
						<xsl:call-template name="Text">
							<xsl:with-param name="String">
								<xsl:text>:=</xsl:text>
							</xsl:with-param>
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:OpaqueExpression">
						<xsl:variable
							name="OpaqueExpressionID"
							select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:OpaqueExpression/@xmi.idref" />
						<xsl:variable
							name="OpaqueExpressionBody"
							select="key('xmi.id', $OpaqueExpressionID)/@body" />

						<xsl:call-template name="Text">
							<xsl:with-param name="String">
								<xsl:value-of select="$OpaqueExpressionBody" />
							</xsl:with-param>
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: OperationCompartment.xsl An operation compartment holds a list of 
		strings, each of which is the encoded representation of an operation -->

	<!-- Operation compartment -->
	<xsl:template name="OperationCompartment">

		<!-- Main OperationCompartment group -->
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

			<desc>
				<xsl:text>Operation compartment</xsl:text>
			</desc>

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/*">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'DelimitedSection'">
						<!-- Compartment section -->
						<xsl:for-each select="UML:GraphElement.contained/*">
							<xsl:choose>
								<xsl:when
									test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Operation">
									<!-- Operation -->
									<xsl:call-template name="Operation" />
								</xsl:when>
							</xsl:choose>
						</xsl:for-each>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: CompartmentSeparator.xsl A compartment separator is a simple horizontal 
		line -->

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

	<!--********************************************************************** -->
	<!-- Template: Class.xsl Displays classes -->

	<!-- Class -->
	<xsl:template name="Class">

		<xsl:param
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- Main Class group -->
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
				<xsl:choose>
					<xsl:when test="UML:GraphElement.semanticModel//UML:Class">
						Class
					</xsl:when>
					<xsl:when test="UML:GraphElement.semanticModel//UML:Actor">
						Actor
					</xsl:when>
					<xsl:when test="UML:GraphElement.semanticModel//UML:Interface">
						Interface
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'AssociationClassNode'">
						AssociationClassNode
					</xsl:when>
				</xsl:choose>
			</desc>

			<!-- The outline shape, a Rectangle -->
			<rect
				width="{UML:GraphNode.size/XMI.field[1]}"
				height="{UML:GraphNode.size/XMI.field[2]}">
				<xsl:apply-templates
					select="."
					mode="FillStyle" />
			</rect>

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/*">
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

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'CompartmentSeparator'">
						<!-- Compartment separator -->
						<xsl:call-template name="CompartmentSeparator" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'AttributeCompartment'">
						<!-- Attribute compartment -->
						<xsl:call-template name="AttributeCompartment" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'OperationCompartment'">
						<!-- Operation compartment -->
						<xsl:call-template name="OperationCompartment" />
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: Interface_Ball.xsl Displays Interface as a ball -->

	<!-- Interface_Ball -->
	<xsl:template name="Interface_Ball">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- Interface_Ball outline parameters -->
		<xsl:variable name="rx">
			<xsl:value-of select="UML:GraphNode.size/XMI.field[1] div 2" />
		</xsl:variable>
		<xsl:variable name="ry">
			<xsl:value-of select="UML:GraphNode.size/XMI.field[2] div 2" />
		</xsl:variable>

		<!-- Main Interface_Ball group -->
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
				<xsl:text>Interface_Ball</xsl:text>
			</desc>

			<!-- The outline shape, a Circle -->
			<ellipse
				cx="{$rx}"
				cy="{$ry}"
				rx="{$rx}"
				ry="{$ry}">
				<xsl:apply-templates
					select="."
					mode="FillStyle" />
			</ellipse>

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'StereotypeCompartment'">
						<!-- Interface Stereotypes -->
						<xsl:call-template name="StereotypeCompartment">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$SemanticID" />
						</xsl:call-template>
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
						<!-- Interface Name -->
						<xsl:call-template name="Name">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$SemanticID" />
							<xsl:with-param
								name="FontWeight"
								select="'bold'" />
						</xsl:call-template>
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NamespaceCompartment'">
						<!-- Interface Namespace -->
						<xsl:call-template name="NamespaceCompartment">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$SemanticID" />
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: Interface.xsl Displays Interface -->

	<!-- Interface -->
	<xsl:template name="Interface">
		<xsl:choose>
			<xsl:when
				test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/@presentation = 'Ball'">
				<xsl:call-template name="Interface_Ball" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="Class" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: ActorStickman.xsl Displays an Actor as a Stickman -->

	<!-- ActorStickman -->
	<xsl:template name="ActorStickman">

		<xsl:param
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Actor/@xmi.idref" />

		<!-- Actor outline variables -->
		<xsl:variable name="Width">
			<xsl:value-of select="UML:GraphNode.size/XMI.field[1]" />
		</xsl:variable>
		<xsl:variable name="Height">
			<xsl:value-of select="UML:GraphNode.size/XMI.field[2]" />
		</xsl:variable>

		<!-- Main Actor group -->
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
			<xsl:if
				test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement[@typeInfo='HeaderCompartment'] and ../../UML:GraphElement.semanticModel//UML:Object"> <!-- Actor in sequence diagram -->
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
			</xsl:if>

			<title>
				<xsl:value-of select="key('xmi.id', $SemanticID)/@name" />
			</title>
			<desc>
				<xsl:text>Actor</xsl:text>
			</desc>

			<!-- Actor outline, a stickman -->
			<!-- Head -->
			<ellipse
				cx="{$Width div 2}"
				cy="{$Height div 8}"
				rx="{$Width * 3 div 16}"
				ry="{$Height div 8}">
				<xsl:choose>
					<!-- Actor in sequence diagram -->
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
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates
							select="."
							mode="FillStyle" />
					</xsl:otherwise>
				</xsl:choose>
			</ellipse>

			<!-- Body -->
			<line
				x1="{$Width div 2}"
				x2="{$Width div 2}"
				y1="{$Height div 4}"
				y2="{$Height * 2 div 3} " />

			<!-- Arms -->
			<line
				x1="0"
				x2="{$Width}"
				y1="{$Height div 3}"
				y2="{$Height div 3}" />

			<!-- Left leg -->
			<line
				x1="0"
				x2="{$Width div 2}"
				y1="{$Height}"
				y2="{$Height * 2 div 3}" />

			<!-- Right leg -->
			<line
				x1="{$Width}"
				x2="{$Width div 2}"
				y1="{$Height}"
				y2="{$Height * 2 div 3}" />

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
						<!-- Actor Name -->
						<xsl:call-template name="Name">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$SemanticID" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NameCompartment'">
						<!-- Actor Name -->
						<xsl:call-template name="NameCompartment">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$SemanticID" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NamespaceCompartment'">
						<!-- Actor Namespace -->
						<xsl:call-template name="NamespaceCompartment">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$SemanticID" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'StereotypeCompartment'">
						<!-- Actor Stereotypes -->
						<xsl:call-template name="StereotypeCompartment">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$SemanticID" />
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: Actor.xsl Displays an Actor -->

	<!-- Actor -->
	<xsl:template name="Actor">
		<xsl:choose>
			<xsl:when
				test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/@presentation = 'Classifier'">
				<xsl:call-template name="Class" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="ActorStickman" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: Collaboration.xsl Displays a dashed ellipse containig the object 
		properties. -->

	<!-- Collaboration -->
	<xsl:template name="Collaboration">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- Collaboration outline parameters -->
		<xsl:variable name="rx">
			<xsl:value-of select="UML:GraphNode.size/XMI.field[1] div 2" />
		</xsl:variable>
		<xsl:variable name="ry">
			<xsl:value-of select="UML:GraphNode.size/XMI.field[2] div 2" />
		</xsl:variable>

		<!-- Main Collaboration group -->
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
				<xsl:text>Collaboration</xsl:text>
			</desc>

			<!-- The outline shape, a filled ellipse -->
			<ellipse
				cx="{$rx}"
				cy="{$ry}"
				rx="{$rx}"
				ry="{$ry}"
				stroke-dasharray="10">
				<xsl:apply-templates
					select="."
					mode="FillStyle" />
			</ellipse>

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

	<!--********************************************************************** -->
	<!-- Template: Comment.xsl Displays a (usually) yellow rectangle with the upper 
		right corner bent. -->

	<!-- Comment -->
	<xsl:template name="Comment">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Comment/@xmi.idref" />

		<!-- Main Comment group -->
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

			<desc>
				<xsl:text>Comment</xsl:text>
			</desc>

			<!-- Comment outline -->
			<path
				d="M 0 0 L {UML:GraphNode.size/XMI.field[1] - 12} 0 {UML:GraphNode.size/XMI.field[1]} 12 {UML:GraphNode.size/XMI.field[1]} {UML:GraphNode.size/XMI.field[2]} 0 {UML:GraphNode.size/XMI.field[2]} z M {UML:GraphNode.size/XMI.field[1]} 12 L {UML:GraphNode.size/XMI.field[1] - 12} 12 {UML:GraphNode.size/XMI.field[1] - 12} 0">
				<xsl:apply-templates
					select="."
					mode="FillStyle">
					<xsl:with-param
						name="DefaultFill"
						select="'yellow'" />
				</xsl:apply-templates>
			</path>

			<!-- Comment text -->
			<xsl:call-template name="Text">
				<xsl:with-param
					name="String"
					select="key('xmi.id', $SemanticID)/@body" />
				<xsl:with-param
					name="Space"
					select="'preserve'" />
				<xsl:with-param
					name="x"
					select="$CommentPaddingLeft" />
				<xsl:with-param
					name="y"
					select="$CommentPaddingTop" />
			</xsl:call-template>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: Arrowheads.xsl Templates used for building Arrowhead markers -->

	<!-- Generalization -->
	<!-- White triangle -->
	<xsl:template name="GeneralizationArrowhead">
		<xsl:param name="OwnerDiagramID" />
		<marker
			id="GeneralizationArrowhead{$OwnerDiagramID}"
			viewBox="-1 -1 13 12"
			refX="10.5"
			refY="5"
			markerWidth="12"
			markerHeight="12"
			orient="auto"
			fill="white">
			<path d="M 0 0 L 10 5 0 10 z" />
		</marker>
	</xsl:template>

	<!-- Synchronous -->
	<!-- Black triangle -->
	<xsl:template name="SynchronousArrowheadEnd">
		<xsl:param name="OwnerDiagramID" />
		<marker
			id="SynchronousArrowheadEnd{$OwnerDiagramID}"
			viewBox="-1 -1 13 12"
			refX="10.5"
			refY="5"
			markerWidth="12"
			markerHeight="12"
			orient="auto"
			fill="black">
			<path d="M 0 0 L 10 5 0 10 z" />
		</marker>
	</xsl:template>
	<xsl:template name="SynchronousArrowheadStart">
		<xsl:param name="OwnerDiagramID" />
		<marker
			id="SynchronousArrowheadStart{$OwnerDiagramID}"
			viewBox="-10 -1 13 12"
			refX="-10.5"
			refY="5"
			markerWidth="12"
			markerHeight="12"
			orient="auto"
			fill="black">
			<path d="M 0 0 L -10 5 L 0 10 z" />
		</marker>
	</xsl:template>


	<!-- Asynchronous -->
	<!-- Simple arrowhead -->
	<xsl:template name="AsynchronousArrowheadEnd">
		<xsl:param name="OwnerDiagramID" />
		<marker
			id="AsynchronousArrowheadEnd{$OwnerDiagramID}"
			viewBox="-1 -1 13 12"
			refX="10.5"
			refY="5"
			markerWidth="12"
			markerHeight="12"
			orient="auto"
			fill="none">
			<path d="M 0 0 L 10 5 0 10" />
		</marker>
	</xsl:template>
	<xsl:template name="AsynchronousArrowheadStart">
		<xsl:param name="OwnerDiagramID" />
		<marker
			id="AsynchronousArrowheadStart{$OwnerDiagramID}"
			viewBox="-10 -1 13 12"
			refX="-10.5"
			refY="5"
			markerWidth="12"
			markerHeight="12"
			orient="auto"
			fill="none">
			<path d="M 0 0 L -10 5 L 0 10" />
		</marker>
	</xsl:template>

	<!-- Link -->
	<!-- Simple arrowhead -->
	<xsl:template name="LinkArrowhead">
		<xsl:param name="OwnerDiagramID" />
		<marker
			id="LinkArrowhead{$OwnerDiagramID}"
			viewBox="-1 -1 13 12"
			refX="0.5"
			refY="5"
			markerWidth="12"
			markerHeight="12"
			orient="auto"
			fill="none">
			<path d="M 10 0 L 0 5 10 10" />
		</marker>
	</xsl:template>

	<!-- Dependency -->
	<!-- Simple arrowhead -->
	<xsl:template name="DependencyArrowhead">
		<xsl:param name="OwnerDiagramID" />
		<marker
			id="DependencyArrowhead{$OwnerDiagramID}"
			viewBox="-1 -1 13 12"
			refX="10.5"
			refY="5"
			markerWidth="12"
			markerHeight="12"
			orient="auto"
			fill="none">
			<path d="M 0 0 L 10 5 0 10" />
		</marker>
	</xsl:template>

	<!-- Directed Association -->
	<!-- Simple arrowhead -->
	<xsl:template name="DirectedArrowheadEnd">
		<xsl:param name="OwnerDiagramID" />
		<marker
			id="DirectedArrowheadEnd{$OwnerDiagramID}"
			viewBox="-1 -1 13 12"
			refX="10.5"
			refY="5"
			markerWidth="12"
			markerHeight="12"
			orient="auto"
			fill="none">
			<path d="M 0 0 L 10 5 0 10" />
		</marker>
	</xsl:template>
	<xsl:template name="DirectedArrowheadStart">
		<xsl:param name="OwnerDiagramID" />
		<marker
			id="DirectedArrowheadStart{$OwnerDiagramID}"
			viewBox="-10 -1 13 12"
			refX="-10.5"
			refY="5"
			markerWidth="12"
			markerHeight="12"
			orient="auto"
			fill="none">
			<path d="M 0 0 L -10 5 L 0 10" />
		</marker>
	</xsl:template>

	<!-- Aggregation -->
	<!-- A white diamond -->
	<xsl:template name="AggregationArrowheadEnd">
		<xsl:param name="OwnerDiagramID" />
		<marker
			id="AggregationArrowheadEnd{$OwnerDiagramID}"
			viewBox="-1 -1 23 12"
			refX="20.5"
			refY="5"
			markerWidth="22"
			markerHeight="12"
			orient="auto"
			fill="white">
			<path d="M 0 5 L 10 10 20 5 10 0 z" />
		</marker>
	</xsl:template>
	<xsl:template name="AggregationArrowheadStart">
		<xsl:param name="OwnerDiagramID" />
		<marker
			id="AggregationArrowheadStart{$OwnerDiagramID}"
			viewBox="-21 -1 23 12"
			refX="-20.5"
			refY="5"
			markerWidth="22"
			markerHeight="12"
			orient="auto"
			fill="white">
			<path d="M0 5 L -10 10 -20 5 -10 0 z" />
		</marker>
	</xsl:template>
	<!-- Aggregation + Directional -->
	<!-- A white diamond preceded by a simple arrowhead -->
	<xsl:template name="DirectedAggregationArrowheadEnd">
		<xsl:param name="OwnerDiagramID" />
		<marker
			id="DirectedAggregationArrowheadEnd{$OwnerDiagramID}"
			viewBox="-1 -1 32 11"
			refX="30.5"
			refY="5"
			markerWidth="32"
			markerHeight="12"
			orient="auto"
			fill="white">
			<path
				fill="none"
				d="M 0 0 L 10 5 0 10" />
			<path d="M 10 5 L20 10 30 5 20 0 z" />
		</marker>
	</xsl:template>
	<xsl:template name="DirectedAggregationArrowheadStart">
		<xsl:param name="OwnerDiagramID" />
		<marker
			id="DirectedAggregationArrowheadStart{$OwnerDiagramID}"
			viewBox="-31 -1 32 11"
			refX="-30.5"
			refY="5"
			markerWidth="32"
			markerHeight="12"
			orient="auto"
			fill="white">
			<path
				fill="none"
				d="M 0 0 L -10 5 0 10" />
			<path d="M -10 5 L-20 10 -30 5 -20 0 z" />
		</marker>
	</xsl:template>

	<!-- Composition -->
	<!-- A filled diamond -->
	<xsl:template name="CompositionArrowheadEnd">
		<xsl:param name="OwnerDiagramID" />
		<marker
			id="CompositionArrowheadEnd{$OwnerDiagramID}"
			viewBox="-1 -1 23 11"
			refX="20.5"
			refY="5"
			markerWidth="22"
			markerHeight="12"
			orient="auto"
			fill="black">
			<path d="M 0 5 L 10 10 20 5 10 0 z" />
		</marker>
	</xsl:template>
	<xsl:template name="CompositionArrowheadStart">
		<xsl:param name="OwnerDiagramID" />
		<marker
			id="CompositionArrowheadStart{$OwnerDiagramID}"
			viewBox="-21 -1 23 11"
			refX="-20.5"
			refY="5"
			markerWidth="22"
			markerHeight="12"
			orient="auto"
			fill="black">
			<path
				fill="black"
				d="M 0 5 L -10 10 -20 5 -10 0 z" />
		</marker>
	</xsl:template>
	<!-- Composition + Directional -->
	<!-- A filled diamond preceded by a simple arrowhead -->
	<xsl:template name="DirectedCompositionArrowheadEnd">
		<xsl:param name="OwnerDiagramID" />
		<marker
			id="DirectedCompositionArrowheadEnd{$OwnerDiagramID}"
			viewBox="-1 -1 32 11"
			refX="30.5"
			refY="5"
			markerWidth="32"
			markerHeight="12"
			orient="auto"
			fill="black">
			<path
				fill="none"
				d="M 0 0 L 10 5 0 10" />
			<path
				fill="black"
				d="M 10 5 L20 10 30 5 20 0 z" />
		</marker>
	</xsl:template>
	<xsl:template name="DirectedCompositionArrowheadStart">
		<xsl:param name="OwnerDiagramID" />
		<marker
			id="DirectedCompositionArrowheadStart{$OwnerDiagramID}"
			viewBox="-31 -1 32 12"
			refX="-30.5"
			refY="5"
			markerWidth="12"
			markerHeight="12"
			orient="auto"
			fill="black">
			<path
				fill="none"
				d="M 0 0 L -10 5 0 10" />
			<path
				fill="black"
				d="M -10 5 L-20 10 -30 5 -20 0 z" />
		</marker>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: DirectedName.xsl * used in: Sequence Diagrams -->

	<!-- NameAndType -->
	<xsl:template name="DirectedName">
		<xsl:param
			name="OwnerSemanticID"
			select="../../UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- Main DirectedName group -->
		<g
			id="{@xmi.id}"
			transform="translate({UML:GraphElement.position/XMI.field[1]}, {UML:GraphElement.position/XMI.field[2]})">
			<xsl:apply-templates
				select="."
				mode="FontStyle" />
			<xsl:apply-templates
				select="."
				mode="isVisible" />

			<title>
				<xsl:text>DirectedName for </xsl:text>
				<xsl:value-of select="$OwnerSemanticID" />
			</title>
			<desc>
				<xsl:text>DirectedName</xsl:text>
			</desc>

			<!-- NameAndType text should be underlined -->

			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'MessageOrdering'">
						<xsl:variable
							name="Message"
							select="key('xmi.id', $OwnerSemanticID)" />

						<xsl:variable
							name="ExecutionOccurrenceID"
							select="(key('xmi.id', $Message/UML2:Message.receiveEvent/UML2:EventOccurrence/@xmi.idref)/UML2:EventOccurrence.startExec | key('xmi.id', $Message/UML2:Message.sendEvent/UML2:EventOccurrence/@xmi.idref)/UML2:EventOccurrence.finishExec)/UML2:ExecutionOccurrence[1]/@xmi.idref" />

						<xsl:if test="$ExecutionOccurrenceID">
							<xsl:variable
								name="ExecutionOccurrence"
								select="key('xmi.id', $ExecutionOccurrenceID)" />

							<xsl:variable name="Count">
								<xsl:value-of
									select="count($ExecutionOccurrence/preceding-sibling::UML2:ExecutionOccurrence)+1" />
							</xsl:variable>

							<xsl:call-template name="Text">
								<xsl:with-param
									name="String"
									select="concat($Count,')')" />
							</xsl:call-template>
						</xsl:if>
					</xsl:when>


					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'MessageSeparator'">
						<!-- Message separator: '.' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$MessageSeparator" />
							<xsl:with-param
								name="FontWeight"
								select="'bold'" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
						<xsl:call-template name="Name" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Signature'">
						<g
							id="{@xmi.id}"
							transform="translate({UML:GraphElement.position/XMI.field[1]}, {UML:GraphElement.position/XMI.field[2]})">
							<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
								<xsl:choose>
									<xsl:when
										test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Operation">
										<xsl:call-template name="Operation" />
									</xsl:when>
								</xsl:choose>
							</xsl:for-each>
						</g>
					</xsl:when>

				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: TransitionDescription.xsl Displays Transition Description -->

	<!-- TransitionDescription -->
	<xsl:template name="TransitionDescription">

		<xsl:variable
			name="SemanticID"
			select="../../UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- Main TransitionDescription group -->
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

			<desc>
				<xsl:text>TransitionDescription</xsl:text>
			</desc>

			<!-- TransitionDescription text -->
			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:CallEvent">
						<!-- Event Trigger -->
						<g
							id="{@xmi.id}"
							transform="translate({UML:GraphElement.position/XMI.field[1]}, {UML:GraphElement.position/XMI.field[2]})">
							<desc>CallEvent</desc>
							<xsl:variable
								name="CallEventSemanticID"
								select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
							<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
								<xsl:choose>
									<xsl:when
										test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
										<xsl:call-template name="Text">
											<xsl:with-param name="String">
												<xsl:choose>
													<xsl:when test="key('xmi.id', $CallEventSemanticID)/@name">
														<xsl:value-of select="key('xmi.id', $CallEventSemanticID)/@name" />
													</xsl:when>
													<xsl:otherwise>
														<xsl:text>anonymous</xsl:text>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:with-param>
										</xsl:call-template>
									</xsl:when>
								</xsl:choose>
							</xsl:for-each>
						</g>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'GuardStart'">
						<!-- Guard start, '[' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$GuardStart" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Guard">
						<!-- Transition guard -->
						<g
							id="{@xmi.id}"
							transform="translate({UML:GraphElement.position/XMI.field[1]}, {UML:GraphElement.position/XMI.field[2]})">
							<desc>Guard</desc>
							<xsl:variable
								name="GuardSemanticID"
								select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
							<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
								<xsl:choose>
									<xsl:when
										test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Expression'">
										<xsl:call-template name="Text">
											<xsl:with-param
												name="String"
												select="key('xmi.id', $GuardSemanticID)/UML:Guard.expression/UML:BooleanExpression/@body" />
										</xsl:call-template>
									</xsl:when>
								</xsl:choose>
							</xsl:for-each>
						</g>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'GuardEnd'">
						<!-- Guard end, ']' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$GuardEnd" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'EffectStart'">
						<!-- Effect start, '/' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$EffectStart" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:CallAction">
						<!-- Call Action -->
						<g
							id="{@xmi.id}"
							transform="translate({UML:GraphElement.position/XMI.field[1]}, {UML:GraphElement.position/XMI.field[2]})">
							<xsl:apply-templates
								select="."
								mode="FontStyle" />
							<xsl:apply-templates
								select="."
								mode="isVisible" />
							<xsl:variable
								name="CallActionSemanticID"
								select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
							<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
								<xsl:choose>
									<xsl:when
										test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Expression'">
										<xsl:call-template name="Text">
											<xsl:with-param
												name="String"
												select="key('xmi.id', $CallActionSemanticID)/UML:Action.script/UML:ActionExpression/@body" />
										</xsl:call-template>
									</xsl:when>
								</xsl:choose>
							</xsl:for-each>
						</g>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: StateTransitionDescription.xsl - UML2 -->

	<!-- StateTransitionDescription -->
	<xsl:template name="StateTransitionDescription">
		<xsl:param
			name="ShowNulls"
			select="false()" />

		<xsl:variable
			name="SemanticID"
			select="../../UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- Main StateTransitionDescription group -->
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

			<desc>
				<xsl:text>StateTransitionDescription</xsl:text>
			</desc>

			<!-- TransitionDescription text -->
			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:CallTrigger">
						<!-- UML2 CallTrigger -->
						<g
							id="{@xmi.id}"
							transform="translate({UML:GraphElement.position/XMI.field[1]}, {UML:GraphElement.position/XMI.field[2]})">
							<desc>CallTrigger</desc>
							<xsl:variable
								name="CallTriggerID"
								select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:CallTrigger/@xmi.idref" />
							<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
								<xsl:choose>
									<xsl:when
										test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
										<xsl:call-template name="Text">
											<xsl:with-param
												name="String"
												select="key('xmi.id', $CallTriggerID)/@name" />
										</xsl:call-template>
									</xsl:when>
								</xsl:choose>
							</xsl:for-each>
						</g>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NullTrigger'">
						<xsl:if test="$ShowNulls">
							<xsl:call-template name="Text">
								<xsl:with-param
									name="String"
									select="'&lt;trigger&gt;'" />
							</xsl:call-template>
						</xsl:if>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'TriggerSeparator'">
						<!-- Trigger separator, '|' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$TriggerSeparator" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'GuardStart'">
						<!-- Guard start, '[' -->
						<xsl:if
							test="$ShowNulls or not(following-sibling::UML:GraphNode/UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NullGuard'                         or preceding-sibling::UML:GraphNode/UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NullGuard')">
							<xsl:call-template name="Text">
								<xsl:with-param
									name="String"
									select="$GuardStart" />
							</xsl:call-template>
						</xsl:if>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:Constraint">
						<!-- UML2 Constraint -->
						<g
							id="{@xmi.id}"
							transform="translate({UML:GraphElement.position/XMI.field[1]}, {UML:GraphElement.position/XMI.field[2]})">
							<desc>Constraint</desc>
							<xsl:variable
								name="ConstraintID"
								select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:Constraint/@xmi.idref" />
							<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
								<xsl:choose>
									<xsl:when
										test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
										<xsl:call-template name="Text">
											<xsl:with-param
												name="String"
												select="key('xmi.id', $ConstraintID)/@name" />
										</xsl:call-template>
									</xsl:when>
								</xsl:choose>
							</xsl:for-each>
						</g>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NullGuard'">
						<xsl:if test="$ShowNulls">
							<xsl:call-template name="Text">
								<xsl:with-param
									name="String"
									select="'&lt;guard&gt;'" />
							</xsl:call-template>
						</xsl:if>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'GuardEnd'">
						<!-- Guard end, ']' -->
						<xsl:if
							test="$ShowNulls or not(following-sibling::UML:GraphNode/UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NullGuard'                         or preceding-sibling::UML:GraphNode/UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NullGuard')">
							<xsl:call-template name="Text">
								<xsl:with-param
									name="String"
									select="$GuardEnd" />
							</xsl:call-template>
						</xsl:if>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'EffectStart'">
						<!-- Effect start, '/' -->
						<xsl:if
							test="$ShowNulls or not(following-sibling::UML:GraphNode/UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NullEffect'                         or preceding-sibling::UML:GraphNode/UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NullEffect')">
							<xsl:call-template name="Text">
								<xsl:with-param
									name="String"
									select="$EffectStart" />
							</xsl:call-template>
						</xsl:if>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:OpaqueBehavior">
						<!-- UML2 OpaqueBehavior -->
						<g
							id="{@xmi.id}"
							transform="translate({UML:GraphElement.position/XMI.field[1]}, {UML:GraphElement.position/XMI.field[2]})">
							<desc>OpaqueBehavior</desc>
							<xsl:variable
								name="OpaqueBehaviorID"
								select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:OpaqueBehavior/@xmi.idref" />
							<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
								<xsl:choose>
									<xsl:when
										test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
										<xsl:call-template name="Text">
											<xsl:with-param
												name="String"
												select="key('xmi.id', $OpaqueBehaviorID)/@name" />
										</xsl:call-template>
									</xsl:when>
								</xsl:choose>
							</xsl:for-each>
						</g>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NullEffect'">
						<xsl:if test="$ShowNulls">
							<xsl:call-template name="Text">
								<xsl:with-param
									name="String"
									select="'&lt;effect&gt;'" />
							</xsl:call-template>
						</xsl:if>
					</xsl:when>

				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: StimuliArrows.xsl Displays Arrows for stimuli (in Collaboration diagrams) -->

	<!-- AsynchronousArrow -->
	<xsl:template name="AsynchronousArrow">

		<!-- Main AsynchronousArrow group -->
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

			<desc>
				<xsl:text>AsynchronousArrow</xsl:text>
			</desc>

			<!-- Outline parameters -->
			<xsl:variable
				name="width"
				select="UML:GraphNode.size/XMI.field[1]" />
			<xsl:variable
				name="height"
				select="UML:GraphNode.size/XMI.field[2] div 2" />
			<xsl:variable
				name="LinkSemanticID"
				select="../../../../UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
			<xsl:variable
				name="LinkSource"
				select="key('xmi.id', $LinkSemanticID)/UML:Link.connection/UML:LinkEnd[1]/UML:LinkEnd.instance/*/@xmi.idref" />
			<xsl:variable
				name="StimulusSemanticID"
				select="../../UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
			<xsl:variable
				name="StimulusSource"
				select="key('xmi.id', $StimulusSemanticID)/UML:Stimulus.sender/*/@xmi.idref" />
			<xsl:variable name="rotate">
				<xsl:choose>
					<xsl:when test="$LinkSource = $StimulusSource">
						0
					</xsl:when>
					<xsl:otherwise>
						180
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>

			<!-- The marker, a simple arrowhead -->
			<path
				d="M {- ($width div 2)} 0 h {$width - 1} M 0 -{$height div 2} L {$width div 2} 0 0 {$height div 2}"
				fill="none"
				transform="rotate({$rotate})" />
		</g>
	</xsl:template>

	<!-- SynchronousArrow -->
	<xsl:template name="SynchronousArrow">

		<!-- Main AsynchronousArrow group -->
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

			<desc>
				<xsl:text>SynchronousArrow</xsl:text>
			</desc>

			<!-- Outline parameters -->
			<xsl:variable
				name="width"
				select="UML:GraphNode.size/XMI.field[1]" />
			<xsl:variable
				name="height"
				select="UML:GraphNode.size/XMI.field[2] div 2" />
			<xsl:variable
				name="LinkSemanticID"
				select="../../../../UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
			<xsl:variable
				name="LinkSource"
				select="key('xmi.id', $LinkSemanticID)/UML:Link.connection/UML:LinkEnd[1]/UML:LinkEnd.instance/*/@xmi.idref" />
			<xsl:variable
				name="StimulusSemanticID"
				select="../../UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
			<xsl:variable
				name="StimulusSource"
				select="key('xmi.id', $StimulusSemanticID)/UML:Stimulus.sender/*/@xmi.idref" />
			<xsl:variable name="rotate">
				<xsl:choose>
					<xsl:when test="$LinkSource = $StimulusSource">
						0
					</xsl:when>
					<xsl:otherwise>
						180
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>

			<!-- The marker, a triangle -->
			<path d="M {- ($width div 2)} 0 h {$width - 1}" />
			<path
				d="M 0 -{$height div 3} L {$width div 2} 0 0 {$height div 3} z"
				fill="black"
				transform="rotate({$rotate})" />
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: Lines.xsl Templates used for displaying lines -->

	<!-- Generalization line, displayed as a simple line with an empty triangle at the 
		endpoint -->
	<xsl:template name="Generalization_Line">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
		<xsl:variable name="PathData">
			<xsl:call-template name="BuildPathData" />
		</xsl:variable>

		<!-- The main generalization group -->
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
				Generalization line
				<xsl:value-of select="$SemanticID" />
			</title>
			<desc>
				Generalization:
				<xsl:value-of
					select="key('xmi.id', $SemanticID)/UML:Generalization.child/*/@xmi.idref" />
				-&gt;
				<xsl:value-of
					select="key('xmi.id', $SemanticID)/UML:Generalization.parent/*/@xmi.idref" />
			</desc>

			<!-- The generalization marker -->
			<xsl:call-template name="GeneralizationArrowhead">
				<xsl:with-param
					name="OwnerDiagramID"
					select="@xmi.id" />
			</xsl:call-template>

			<path
				d="{$PathData}"
				fill="none"
				marker-end="url(#GeneralizationArrowhead{@xmi.id})" />

			<!-- Display edge properties -->
			<xsl:call-template name="EdgeText">
				<xsl:with-param
					name="OwnerSemanticID"
					select="$SemanticID" />
			</xsl:call-template>
		</g>
	</xsl:template>

	<!-- Dependency line, displayed as a dashed line with a simple arrowhead at the 
		endpoint -->
	<xsl:template name="Dependency_Line">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
		<xsl:variable name="PathData">
			<xsl:call-template name="BuildPathData" />
		</xsl:variable>

		<!-- The main Dependency group -->
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
				Dependency line
				<xsl:value-of select="$SemanticID" />
			</title>
			<desc>
				Dependency:
				<xsl:value-of
					select="key('xmi.id', $SemanticID)/UML:Dependency.client/*/@xmi.idref" />
				-&gt;
				<xsl:value-of
					select="key('xmi.id', $SemanticID)/UML:Dependency.supplier/*/@xmi.idref" />
			</desc>

			<!-- The dependency marker -->
			<xsl:call-template name="DependencyArrowhead">
				<xsl:with-param
					name="OwnerDiagramID"
					select="@xmi.id" />
			</xsl:call-template>
			<path
				d="{$PathData}"
				fill="none"
				style="stroke-dasharray: 6 10"
				marker-end="url(#DependencyArrowhead{@xmi.id})" />

			<!-- Display edge properties -->
			<xsl:call-template name="EdgeText">
				<xsl:with-param
					name="OwnerSemanticID"
					select="$SemanticID" />
			</xsl:call-template>
		</g>
	</xsl:template>

	<!-- Association line, displayed as a simple line -->
	<!-- Multiple semantics: aggregation, composition, direction -->
	<xsl:template name="Association_Line">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
		<xsl:variable name="PathData">
			<xsl:call-template name="BuildPathData" />
		</xsl:variable>

		<!-- Determine the type of the association from the AssociationEnds -->

		<!-- Association direction -->
		<xsl:variable name="TraversableFrom">
			<xsl:value-of
				select="key('xmi.id', $SemanticID)/UML:Association.connection/UML:AssociationEnd[1]/@isNavigable" />
		</xsl:variable>
		<xsl:variable name="TraversableTo">
			<xsl:value-of
				select="key('xmi.id', $SemanticID)/UML:Association.connection/UML:AssociationEnd[2]/@isNavigable" />
		</xsl:variable>
		<xsl:variable name="Traversable">
			<xsl:choose>
				<xsl:when test="($TraversableFrom = 'true') and ($TraversableTo = 'true')">
					<xsl:text>Both</xsl:text>
				</xsl:when>
				<xsl:when test="($TraversableFrom = 'true') and ($TraversableTo = 'false')">
					<xsl:text>From</xsl:text>
				</xsl:when>
				<xsl:when test="($TraversableFrom = 'false') and ($TraversableTo = 'true')">
					<xsl:text>To</xsl:text>
				</xsl:when>
				<xsl:when test="($TraversableFrom = 'false') and ($TraversableTo = 'false')">
					<xsl:text>None</xsl:text>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>

		<!-- Aggregation -->
		<xsl:variable name="Aggregation">
			<xsl:choose>
				<xsl:when
					test="key('xmi.id', $SemanticID)/UML:Association.connection/UML:AssociationEnd[(position() = 1) and (@aggregation = 'aggregate')]">
					<xsl:text>From</xsl:text>
				</xsl:when>
				<xsl:when
					test="key('xmi.id', $SemanticID)/UML:Association.connection/UML:AssociationEnd[(position() = 2) and (@aggregation = 'aggregate')]">
					<xsl:text>To</xsl:text>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>

		<!-- Composition -->
		<xsl:variable name="Composition">
			<xsl:choose>
				<xsl:when
					test="key('xmi.id', $SemanticID)/UML:Association.connection/UML:AssociationEnd[(position() = 1) and (@aggregation = 'composite')]">
					<xsl:text>From</xsl:text>
				</xsl:when>
				<xsl:when
					test="key('xmi.id', $SemanticID)/UML:Association.connection/UML:AssociationEnd[(position() = 2) and (@aggregation = 'composite')]">
					<xsl:text>To</xsl:text>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>

		<!-- Determine the line's end marker -->
		<xsl:variable name="marker-end">
			<xsl:choose>
				<xsl:when test="$Traversable = 'To'">
					<xsl:choose>
						<xsl:when test="$Aggregation = 'To'">
							<xsl:text>DirectedAggregationArrowheadEnd</xsl:text>
						</xsl:when>
						<xsl:when test="$Composition = 'To'">
							<xsl:text>DirectedCompositionArrowheadEnd</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>DirectedArrowheadEnd</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="$Aggregation = 'To'">
							<xsl:text>AggregationArrowheadEnd</xsl:text>
						</xsl:when>
						<xsl:when test="$Composition = 'To'">
							<xsl:text>CompositionArrowheadEnd</xsl:text>
						</xsl:when>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<!-- Determine the line's start marker -->
		<xsl:variable name="marker-start">
			<xsl:choose>
				<xsl:when test="$Traversable = 'From'">
					<xsl:choose>
						<xsl:when test="$Aggregation = 'From'">
							<xsl:text>DirectedAggregationArrowheadStart</xsl:text>
						</xsl:when>
						<xsl:when test="$Composition = 'From'">
							<xsl:text>DirectedCompositionArrowheadStart</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>DirectedArrowheadStart</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="$Aggregation = 'From'">
							<xsl:text>AggregationArrowheadStart</xsl:text>
						</xsl:when>
						<xsl:when test="$Composition = 'From'">
							<xsl:text>CompositionArrowheadStart</xsl:text>
						</xsl:when>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<!-- The main Association group -->
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
				Association line
				<xsl:value-of select="$SemanticID" />
			</title>
			<desc>
				Association:
				<xsl:value-of
					select="key('xmi.id', $SemanticID)/UML:Association.connection/UML:AssociationEnd[1]/UML:AssociationEnd.participant/*/@xmi.idref" />
				<xsl:if test="$Aggregation = 'From'">
					<xsl:text> (Aggregation)</xsl:text>
				</xsl:if>
				<xsl:if test="$Composition = 'From'">
					<xsl:text> (Composition)</xsl:text>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="$Traversable = 'Both'">
						&lt;-&gt;
					</xsl:when>
					<xsl:when test="$Traversable = 'From'">
						-&gt;
					</xsl:when>
					<xsl:when test="$Traversable = 'To'">
						&lt;-
					</xsl:when>
					<xsl:when test="$Traversable = 'None'">
						--
					</xsl:when>
				</xsl:choose>
				<xsl:value-of
					select="key('xmi.id', $SemanticID)/UML:Association.connection/UML:AssociationEnd[2]/UML:AssociationEnd.participant/*/@xmi.idref" />
				<xsl:if test="$Aggregation = 'To'">
					<xsl:text> (Aggregation)</xsl:text>
				</xsl:if>
				<xsl:if test="$Composition = 'To'">
					<xsl:text> (Composition)</xsl:text>
				</xsl:if>
			</desc>

			<xsl:if test="$marker-start != ''">
				<xsl:choose>
					<xsl:when test="$marker-start = 'DirectedArrowheadStart'">
						<xsl:call-template name="DirectedArrowheadStart">
							<xsl:with-param
								name="OwnerDiagramID"
								select="@xmi.id" />
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="$marker-start = 'DirectedAggregationArrowheadStart'">
						<xsl:call-template name="DirectedAggregationArrowheadStart">
							<xsl:with-param
								name="OwnerDiagramID"
								select="@xmi.id" />
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="$marker-start = 'DirectedCompositionArrowheadStart'">
						<xsl:call-template name="DirectedCompositionArrowheadStart">
							<xsl:with-param
								name="OwnerDiagramID"
								select="@xmi.id" />
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="$marker-start = 'AggregationArrowheadStart'">
						<xsl:call-template name="AggregationArrowheadStart">
							<xsl:with-param
								name="OwnerDiagramID"
								select="@xmi.id" />
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="$marker-start = 'CompositionArrowheadStart'">
						<xsl:call-template name="CompositionArrowheadStart">
							<xsl:with-param
								name="OwnerDiagramID"
								select="@xmi.id" />
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
			</xsl:if>
			<xsl:if test="$marker-end != ''">
				<xsl:choose>
					<xsl:when test="$marker-end = 'DirectedArrowheadEnd'">
						<xsl:call-template name="DirectedArrowheadEnd">
							<xsl:with-param
								name="OwnerDiagramID"
								select="@xmi.id" />
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="$marker-end = 'DirectedAggregationArrowheadEnd'">
						<xsl:call-template name="DirectedAggregationArrowheadEnd">
							<xsl:with-param
								name="OwnerDiagramID"
								select="@xmi.id" />
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="$marker-end = 'DirectedCompositionArrowheadEnd'">
						<xsl:call-template name="DirectedCompositionArrowheadEnd">
							<xsl:with-param
								name="OwnerDiagramID"
								select="@xmi.id" />
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="$marker-end = 'AggregationArrowheadEnd'">
						<xsl:call-template name="AggregationArrowheadEnd">
							<xsl:with-param
								name="OwnerDiagramID"
								select="@xmi.id" />
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="$marker-end = 'CompositionArrowheadEnd'">
						<xsl:call-template name="CompositionArrowheadEnd">
							<xsl:with-param
								name="OwnerDiagramID"
								select="@xmi.id" />
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
			</xsl:if>

			<!-- Association line -->
			<path
				d="{$PathData}"
				fill="none">
				<xsl:if test="$marker-start != ''">
					<xsl:attribute name="marker-start">
						<xsl:text>url(#</xsl:text><xsl:value-of select="$marker-start" /><xsl:value-of
						select="@xmi.id" /><xsl:text>)</xsl:text>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="$marker-end != ''">
					<xsl:attribute name="marker-end">
						<xsl:text>url(#</xsl:text><xsl:value-of select="$marker-end" /><xsl:value-of
						select="@xmi.id" /><xsl:text>)</xsl:text>
					</xsl:attribute>
				</xsl:if>
			</path>

			<!-- Display edge properties -->
			<xsl:call-template name="EdgeText">
				<xsl:with-param
					name="OwnerSemanticID"
					select="$SemanticID" />
			</xsl:call-template>
		</g>
	</xsl:template>

	<!-- AssociationClassEdge line, displayed as a dashed line -->
	<xsl:template name="AssociationClassEdge_Line">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
		<xsl:variable name="PathData">
			<xsl:call-template name="BuildPathData" />
		</xsl:variable>

		<!-- The main Link group -->
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
				Link line
				<xsl:value-of select="$SemanticID" />
			</title>
			<desc>
				Link:
				<xsl:value-of
					select="key('xmi.id', $SemanticID)/UML:LinkEnd.instance[1]/*/@xmi.idref" />
				--
				<xsl:value-of
					select="key('xmi.id', $SemanticID)/UML:LinkEnd.instance[2]/*/@xmi.idref" />
			</desc>

			<!-- The Link line -->
			<path
				d="{$PathData}"
				fill="none"
				stroke-dasharray="6 12" />
		</g>
	</xsl:template>

	<!-- Abstraction line, displayed as a dashed line with a white triangle at the endpoint -->
	<xsl:template name="Abstraction_Line">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
		<xsl:variable name="PathData">
			<xsl:call-template name="BuildPathData" />
		</xsl:variable>

		<!-- The main Abstraction group -->
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
				Abstraction line
				<xsl:value-of select="$SemanticID" />
			</title>
			<desc>
				Abstraction:
				<xsl:value-of
					select="key('xmi.id', $SemanticID)/UML:Dependency.client/*/@xmi.idref" />
				-&gt;
				<xsl:value-of
					select="key('xmi.id', $SemanticID)/UML:Dependency.supplier/*/@xmi.idref" />
			</desc>

			<!-- The Abstraction marker -->
			<xsl:call-template name="GeneralizationArrowhead">
				<xsl:with-param
					name="OwnerDiagramID"
					select="@xmi.id" />
			</xsl:call-template>

			<!-- The Abstraction line -->
			<path
				d="{$PathData}"
				fill="none"
				marker-end="url(#GeneralizationArrowhead{@xmi.id})"
				stroke-dasharray="6 9" />

			<!-- Display edge properties -->
			<xsl:call-template name="EdgeText">
				<xsl:with-param
					name="OwnerSemanticID"
					select="$SemanticID" />
			</xsl:call-template>
		</g>
	</xsl:template>

	<!-- Comment line, displayed as a dashed line -->
	<xsl:template name="Comment_Line">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@xmi.id" />
		<xsl:variable name="PathData">
			<xsl:call-template name="BuildPathData" />
		</xsl:variable>

		<!-- The main comment line group -->
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
				Comment line
				<xsl:value-of select="$SemanticID" />
			</title>
			<desc>Main Comment line group</desc>

			<!-- Comment line -->
			<path
				d="{$PathData}"
				fill="none"
				stroke-dasharray="6 4" />
		</g>
	</xsl:template>

	<!-- ClassifierRole line, displayed as a dashed line -->
	<xsl:template name="ClassifierRole_Line">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
		<xsl:variable name="PathData">
			<xsl:call-template name="BuildPathData" />
		</xsl:variable>

		<!-- The main ClassifierRole group -->
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
				ClassifierRole line
				<xsl:value-of select="$SemanticID" />
			</title>
			<desc>
				ClassifierRole:
				<xsl:value-of
					select="key('xmi.id', $SemanticID)/UML:ClassifierRole.base/*/@xmi.idref" />
				-&gt;
				<xsl:value-of select="key('xmi.id', $SemanticID)/../../@xmi.id" />
			</desc>

			<!-- ClasifierRole line -->
			<path
				d="{$PathData}"
				fill="none"
				stroke-dasharray="6 4" />

			<!-- Display edge properties -->
			<xsl:call-template name="EdgeText">
				<xsl:with-param
					name="OwnerSemanticID"
					select="$SemanticID" />
			</xsl:call-template>
		</g>
	</xsl:template>

	<!-- Extend line, displayed as a dashed line with a simple arrowhead at the endpoint -->
	<xsl:template name="Extend_Line">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
		<xsl:variable name="PathData">
			<xsl:call-template name="BuildPathData" />
		</xsl:variable>

		<!-- The main Extend group -->
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
				Extend line
				<xsl:value-of select="$SemanticID" />
			</title>
			<desc>
				Extend:
				<xsl:value-of select="key('xmi.id', $SemanticID)/UML:Extend.extension/*/@xmi.idref" />
				-&gt;
				<xsl:value-of select="key('xmi.id', $SemanticID)/UML:Extend.base/*/@xmi.idref" />
			</desc>

			<!-- The Extend marker -->
			<xsl:call-template name="DependencyArrowhead">
				<xsl:with-param
					name="OwnerDiagramID"
					select="@xmi.id" />
			</xsl:call-template>

			<!-- The Extend line -->
			<path
				d="{$PathData}"
				fill="none"
				marker-end="url(#DependencyArrowhead{@xmi.id})"
				stroke-dasharray="6 6" />

			<!-- Display edge properties -->
			<xsl:call-template name="EdgeText">
				<xsl:with-param
					name="OwnerSemanticID"
					select="$SemanticID" />
			</xsl:call-template>
		</g>
	</xsl:template>

	<!-- Include line, displayed as a dashed line with a simple arrowhead at the endpoint -->
	<xsl:template name="Include_Line">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
		<xsl:variable name="PathData">
			<xsl:call-template name="BuildPathData" />
		</xsl:variable>

		<!-- The main Include group -->
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
				Include line
				<xsl:value-of select="$SemanticID" />
			</title>
			<desc>
				Include:
				<xsl:value-of select="key('xmi.id', $SemanticID)/UML:Include.addition/*/@xmi.idref" />
				-&gt;
				<xsl:value-of select="key('xmi.id', $SemanticID)/UML:Include.base/*/@xmi.idref" />
			</desc>

			<!-- The Include marker -->
			<xsl:call-template name="DependencyArrowhead">
				<xsl:with-param
					name="OwnerDiagramID"
					select="@xmi.id" />
			</xsl:call-template>

			<!-- The Include line -->
			<path
				d="{$PathData}"
				fill="none"
				marker-end="url(#DependencyArrowhead{@xmi.id})"
				stroke-dasharray="6 6" />

			<!-- Display edge properties -->
			<xsl:call-template name="EdgeText">
				<xsl:with-param
					name="OwnerSemanticID"
					select="$SemanticID" />
			</xsl:call-template>
		</g>
	</xsl:template>

	<!-- Link line from Collaboration diagrams, displayed as a simple line -->
	<xsl:template name="Link_Line">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
		<xsl:variable name="PathData">
			<xsl:call-template name="BuildPathData" />
		</xsl:variable>

		<!-- The main Link group -->
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
				Link line
				<xsl:value-of select="$SemanticID" />
			</title>
			<desc>
				Link:
				<xsl:value-of
					select="key('xmi.id', $SemanticID)/UML:LinkEnd.instance[1]/*/@xmi.idref" />
				--
				<xsl:value-of
					select="key('xmi.id', $SemanticID)/UML:LinkEnd.instance[2]/*/@xmi.idref" />
			</desc>

			<!-- The Link line -->
			<path
				d="{$PathData}"
				fill="none" />

			<!-- Display edge properties -->
			<xsl:call-template name="EdgeText">
				<xsl:with-param
					name="OwnerSemanticID"
					select="$SemanticID" />
			</xsl:call-template>
		</g>
	</xsl:template>

	<!-- Link line from Sequence diagrams -->
	<xsl:template name="LinkSequence_Line">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Link/@xmi.idref" />
		<xsl:variable name="PathData">
			<xsl:call-template name="BuildPathData" />
		</xsl:variable>

		<!-- <xsl:variable name="StimulusSemanticID" select="UML:GraphElement.contained/*[UML:GraphElement.semanticModel//UML:Stimulus]/UML:GraphElement.semanticModel//*[@xmi.idref]/@xmi.idref"/> -->
		<xsl:variable
			name="StimulusSemanticID"
			select="UML:GraphElement.contained/UML:GraphNode/UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Stimulus/@xmi.idref" />
		<xsl:variable
			name="ActionSemanticID"
			select="key('xmi.id', $StimulusSemanticID)/UML:Stimulus.dispatchAction/*/@xmi.idref" />
		<xsl:variable name="LinkType">
			<xsl:choose>
				<xsl:when test="key('xmi.id', $ActionSemanticID)/self::UML:ReturnAction">
					Return
				</xsl:when>
				<xsl:when test="key('xmi.id', $ActionSemanticID)/@isAsynchronous = 'true'">
					Asynchronous
				</xsl:when>
				<xsl:otherwise>
					Synchronous
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<!-- The main Link group -->
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

			<xsl:variable
				name="Sender"
				select="key('xmi.id', $StimulusSemanticID)/UML:Stimulus.sender/*/@xmi.idref" />
			<xsl:variable
				name="Receiver"
				select="key('xmi.id', $StimulusSemanticID)/UML:Stimulus.receiver/*/@xmi.idref" />

			<xsl:variable
				name="Connector1"
				select="UML:GraphEdge.anchor/UML:GraphConnector[1]/@xmi.idref" />
			<xsl:variable
				name="Connector2"
				select="UML:GraphEdge.anchor/UML:GraphConnector[2]/@xmi.idref" />

			<xsl:variable
				name="Object1"
				select="key('xmi.id', $Connector1)/ancestor::UML:GraphNode[UML:GraphElement.semanticModel//UML:Object][1]/UML:GraphElement.semanticModel//UML:Object/@xmi.idref" />
			<xsl:variable
				name="Object2"
				select="key('xmi.id', $Connector2)/ancestor::UML:GraphNode[UML:GraphElement.semanticModel//UML:Object][1]/UML:GraphElement.semanticModel//UML:Object/@xmi.idref" />

			<title>
				Link line
				<xsl:value-of select="$SemanticID" />
			</title>
			<desc>
				Link:
				<xsl:value-of select="key('xmi.id', $Sender)/@name" />
				&lt;-&gt;
				<xsl:value-of select="key('xmi.id', $Receiver)/@name" />
			</desc>

			<xsl:variable name="FirstOne">
				<xsl:choose>
					<xsl:when test="$Object1 = $Object2">
						<xsl:variable
							name="Y1"
							select="UML:GraphEdge.waypoints/XMI.field[1]/XMI.field[2]" />
						<xsl:variable
							name="Y2"
							select="UML:GraphEdge.waypoints/XMI.field[last()-2]/XMI.field[2]" />
						<xsl:choose>
							<xsl:when test="$Y1 &gt; $Y2">
								receiver
							</xsl:when>
							<xsl:otherwise>
								sender
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="$Object1 = $Receiver and $Object2 = $Sender">
								receiver
							</xsl:when>
							<xsl:otherwise>
								sender
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<!-- <xsl:message>FirstOne:<xsl:value-of select="$FirstOne"/></xsl:message> -->

			<xsl:choose>
				<xsl:when test="$FirstOne = 'receiver'">
					<xsl:choose>
						<xsl:when test="$LinkType = 'Synchronous'">
							<xsl:call-template name="SynchronousArrowheadStart">
								<xsl:with-param
									name="OwnerDiagramID"
									select="@xmi.id" />
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="AsynchronousArrowheadStart">
								<xsl:with-param
									name="OwnerDiagramID"
									select="@xmi.id" />
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
					<!-- The Link line -->
					<path
						d="{$PathData}"
						fill="none">
						<xsl:choose>
							<xsl:when test="$LinkType = 'Return'">
								<xsl:attribute name="stroke-dasharray"><xsl:text>15 12</xsl:text></xsl:attribute>
								<xsl:attribute name="marker-start"><xsl:text>url(#AsynchronousArrowheadStart</xsl:text><xsl:value-of
									select="@xmi.id" />)</xsl:attribute>
							</xsl:when>
							<xsl:when test="$LinkType = 'Asynchronous'">
								<xsl:attribute name="marker-start"><xsl:text>url(#AsynchronousArrowheadStart</xsl:text><xsl:value-of
									select="@xmi.id" />)</xsl:attribute>
							</xsl:when>
							<xsl:when test="$LinkType = 'Synchronous'">
								<xsl:attribute name="marker-start"><xsl:text>url(#SynchronousArrowheadStart</xsl:text><xsl:value-of
									select="@xmi.id" />)</xsl:attribute>
							</xsl:when>
						</xsl:choose>
					</path>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="$LinkType = 'Synchronous'">
							<xsl:call-template name="SynchronousArrowheadEnd">
								<xsl:with-param
									name="OwnerDiagramID"
									select="@xmi.id" />
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="AsynchronousArrowheadEnd">
								<xsl:with-param
									name="OwnerDiagramID"
									select="@xmi.id" />
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
					<!-- The Link line -->
					<path
						d="{$PathData}"
						fill="none">
						<xsl:choose>
							<xsl:when test="$LinkType = 'Return'">
								<xsl:attribute name="stroke-dasharray"><xsl:text>15 12</xsl:text></xsl:attribute>
								<xsl:attribute name="marker-end"><xsl:text>url(#AsynchronousArrowheadEnd</xsl:text><xsl:value-of
									select="@xmi.id" />)</xsl:attribute>
							</xsl:when>
							<xsl:when test="$LinkType = 'Asynchronous'">
								<xsl:attribute name="marker-end"><xsl:text>url(#AsynchronousArrowheadEnd</xsl:text><xsl:value-of
									select="@xmi.id" />)</xsl:attribute>
							</xsl:when>
							<xsl:when test="$LinkType = 'Synchronous'">
								<xsl:attribute name="marker-end"><xsl:text>url(#SynchronousArrowheadEnd</xsl:text><xsl:value-of
									select="@xmi.id" />)</xsl:attribute>
							</xsl:when>
						</xsl:choose>
					</path>
				</xsl:otherwise>
			</xsl:choose>

			<!-- Display edge properties -->
			<xsl:call-template name="EdgeText">
				<xsl:with-param
					name="OwnerSemanticID"
					select="$SemanticID" />
			</xsl:call-template>
		</g>
	</xsl:template>

	<!-- Message line from Sequence diagrams -->
	<xsl:template name="Message_Line">

		<xsl:variable name="PathData">
			<xsl:call-template name="BuildPathData" />
		</xsl:variable>

		<xsl:variable
			name="MessageSemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:Message/@xmi.idref" />

		<xsl:variable
			name="Message"
			select="key('xmi.id', $MessageSemanticID)" />

		<!-- MessageSort in {synchCall, asynchCall} -->
		<xsl:variable
			name="MessageSort"
			select="key('xmi.id', $MessageSemanticID)/@messageSort" />

		<!-- The main Link group -->
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
				Message line:
				<xsl:value-of select="$MessageSemanticID" />
			</title>
			<desc />

			<xsl:choose>
				<xsl:when test="$MessageSort = 'synchCall'">
					<xsl:call-template name="SynchronousArrowheadEnd">
						<xsl:with-param
							name="OwnerDiagramID"
							select="@xmi.id" />
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="$MessageSort = 'asynchCall'">
					<xsl:call-template name="AsynchronousArrowheadEnd">
						<xsl:with-param
							name="OwnerDiagramID"
							select="@xmi.id" />
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					Ignoring unknown message sort.
				</xsl:otherwise>
			</xsl:choose>

			<!-- The Link line -->
			<path
				d="{$PathData}"
				fill="none">
				<xsl:choose>
					<xsl:when test="$MessageSort = 'synchCall'">
						<xsl:attribute name="marker-end"><xsl:text>url(#SynchronousArrowheadEnd</xsl:text><xsl:value-of
							select="@xmi.id" />)</xsl:attribute>
						<xsl:choose>
							<xsl:when
								test="key('xmi.id', $Message/UML2:Message.receiveEvent/UML2:EventOccurrence/@xmi.idref)/UML2:EventOccurrence.startExec">
								<!-- Call -->
							</xsl:when>
							<xsl:when
								test="key('xmi.id', $Message/UML2:Message.sendEvent/UML2:EventOccurrence/@xmi.idref)/UML2:EventOccurrence.finishExec">
								<!-- Return -->
								<xsl:attribute name="stroke-dasharray"><xsl:text>15 12</xsl:text></xsl:attribute>
							</xsl:when>
							<xsl:otherwise>
								<xsl:message>
									Ignoring unknown synchCall message type.
								</xsl:message>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$MessageSort = 'asynchCall'">
						<xsl:attribute name="marker-end"><xsl:text>url(#AsynchronousArrowheadEnd</xsl:text><xsl:value-of
							select="@xmi.id" />)</xsl:attribute>
					</xsl:when>
				</xsl:choose>
			</path>

			<!-- Display edge properties -->
			<xsl:call-template name="EdgeText">
				<xsl:with-param
					name="OwnerSemanticID"
					select="$MessageSemanticID" />
			</xsl:call-template>
		</g>
	</xsl:template>

	<!-- Transition line, displayed as a simple line with a simple arrowhead -->
	<xsl:template name="Transition_Line">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
		<xsl:variable name="PathData">
			<xsl:call-template name="BuildPathData" />
		</xsl:variable>

		<!-- The main Transition group -->
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
				Transition line
				<xsl:value-of select="$SemanticID" />
			</title>
			<desc>
				Transition:
				<xsl:value-of
					select="key('xmi.id', $SemanticID)/UML:Transition.source/*/@xmi.idref" />
				-&gt;
				<xsl:value-of
					select="key('xmi.id', $SemanticID)/UML:Transition.target/*/@xmi.idref" />
			</desc>

			<!-- The transition marker -->
			<xsl:call-template name="DirectedArrowheadEnd">
				<xsl:with-param
					name="OwnerDiagramID"
					select="@xmi.id" />
			</xsl:call-template>

			<!-- The Transition line -->
			<path
				d="{$PathData}"
				fill="none"
				marker-end="url(#DirectedArrowheadEnd{@xmi.id})">
				<xsl:if
					test="key('xmi.id', $SemanticID)/UML:Transition.source/UML:ObjectFlowState or key('xmi.id', $SemanticID)/UML:Transition.target/UML:ObjectFlowState">
					<xsl:attribute name="stroke-dasharray"><xsl:text>5</xsl:text></xsl:attribute>
				</xsl:if>
			</path>

			<!-- Display edge properties -->
			<xsl:call-template name="EdgeText">
				<xsl:with-param
					name="OwnerSemanticID"
					select="$SemanticID" />
			</xsl:call-template>
		</g>
	</xsl:template>

	<!-- RequiredInterfaceEdge line, displayed as a dashed line with a white triangle 
		marker -->
	<xsl:template name="RequiredInterfaceEdge">

		<xsl:variable name="PathData">
			<xsl:call-template name="BuildPathData" />
		</xsl:variable>

		<!-- The main RequiredInterfaceEdge group -->
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

			<title>RequiredInterfaceEdge line</title>
			<desc>RequiredInterfaceEdge</desc>

			<!-- The RequiredInterfaceEdge line -->
			<!-- The dependency marker -->
			<xsl:call-template name="DependencyArrowhead">
				<xsl:with-param
					name="OwnerDiagramID"
					select="@xmi.id" />
			</xsl:call-template>
			<path
				d="{$PathData}"
				fill="none"
				style="stroke-dasharray: 6 10"
				marker-end="url(#DependencyArrowhead{@xmi.id})" />
		</g>
	</xsl:template>

	<!-- ProvidedInterfaceEdge line, displayed as a simple line -->
	<xsl:template name="ProvidedInterfaceEdge">

		<xsl:variable name="PathData">
			<xsl:call-template name="BuildPathData" />
		</xsl:variable>

		<!-- The main ProvidedInterfaceEdge group -->
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

			<title>ProvidedInterfaceEdge line</title>
			<desc>ProvidedInterfaceEdge</desc>

			<!-- The RequiredInterfaceEdge line -->
			<path
				d="{$PathData}"
				fill="none" />
		</g>
	</xsl:template>

	<xsl:template name="EdgeText">
		<xsl:param name="OwnerSemanticID" />
		<!-- Edge properties -->
		<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
			<xsl:choose>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'StereotypeCompartment'">
					<!-- Stereotype compartment -->
					<xsl:call-template name="StereotypeCompartment">
						<xsl:with-param
							name="OwnerSemanticID"
							select="$OwnerSemanticID" />
					</xsl:call-template>
				</xsl:when>

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
					<!-- Name -->
					<xsl:call-template name="Name">
						<xsl:with-param
							name="OwnerSemanticID"
							select="$OwnerSemanticID" />
					</xsl:call-template>
				</xsl:when>

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'DirectedName'">
					<xsl:call-template name="DirectedName" />
				</xsl:when>

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'KeywordMetaclass'">
					<!-- Metaclass -> Extend / Include -->
					<xsl:call-template name="Text">
						<xsl:with-param name="String">
							<xsl:choose>
								<xsl:when test="key('xmi.id', $OwnerSemanticID)/self::UML:Extend">
									<xsl:value-of select="'extend'" />
								</xsl:when>
								<xsl:when test="key('xmi.id', $OwnerSemanticID)/self::UML:Include">
									<xsl:value-of select="'include'" />
								</xsl:when>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:AssociationEnd">
					<!-- Endpoints -->
					<xsl:variable
						name="EndpointSemanticID"
						select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
					<g
						id="{$EndpointSemanticID}"
						transform="translate({UML:GraphElement.position/XMI.field[1]}, {UML:GraphElement.position/XMI.field[2]})">
						<xsl:apply-templates
							select="."
							mode="FontStyle" />
						<xsl:apply-templates
							select="."
							mode="isVisible" />

						<title>
							<xsl:text>Endpoint </xsl:text>
							<xsl:value-of select="$EndpointSemanticID" />
						</title>
						<desc>
							<xsl:text>Endpoint</xsl:text>
						</desc>

						<!-- Contained nodes -->
						<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
							<xsl:choose>
								<xsl:when
									test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
									<xsl:call-template name="Name">
										<xsl:with-param
											name="OwnerSemanticID"
											select="$EndpointSemanticID" />
										<xsl:with-param name="TextDecoration">
											<xsl:if
												test="key('xmi.id', $EndpointSemanticID)/@targetScope = 'classifier'">
												<xsl:text>underline</xsl:text>
											</xsl:if>
										</xsl:with-param>
									</xsl:call-template>
								</xsl:when>

								<xsl:when
									test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Visibility'">
									<!-- Endpoint Visibility -->
									<!-- Main Visibility group -->
									<g
										id="{@xmi.id}"
										transform="translate({UML:GraphElement.position/XMI.field[1]}, {UML:GraphElement.position/XMI.field[2]})">
										<xsl:apply-templates
											select="."
											mode="FontStyle" />
										<xsl:apply-templates
											select="."
											mode="isVisible" />

										<title>
											<xsl:text>Visibility for </xsl:text>
											<xsl:value-of select="$EndpointSemanticID" />
										</title>
										<desc>
											<xsl:text>Visibility</xsl:text>
										</desc>

										<!-- Visibility text -->
										<xsl:call-template name="Text">
											<xsl:with-param name="String">
												<xsl:call-template name="Visibility">
													<xsl:with-param
														name="OwnerSemanticID"
														select="$EndpointSemanticID" />
												</xsl:call-template>
											</xsl:with-param>
											<xsl:with-param
												name="x"
												select="0" />
											<xsl:with-param
												name="y"
												select="0" />
										</xsl:call-template>
									</g>
								</xsl:when>

								<xsl:when
									test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Multiplicity'">
									<!-- Endpoint Multiplicity -->
									<!-- Main Multiplicity group -->
									<g
										id="{@xmi.id}"
										transform="translate({UML:GraphElement.position/XMI.field[1]}, {UML:GraphElement.position/XMI.field[2]})">
										<xsl:apply-templates
											select="."
											mode="FontStyle" />
										<xsl:apply-templates
											select="."
											mode="isVisible" />

										<title>
											<xsl:text>Multiplicity </xsl:text>
											<xsl:value-of select="$EndpointSemanticID" />
										</title>
										<desc>
											<xsl:text>Multiplicity</xsl:text>
										</desc>

										<!-- Multiplicity text -->
										<xsl:call-template name="Text">
											<xsl:with-param name="String">
												<xsl:call-template name="Multiplicity">
													<xsl:with-param
														name="OwnerSemanticID"
														select="$EndpointSemanticID" />
												</xsl:call-template>
											</xsl:with-param>
											<xsl:with-param
												name="x"
												select="0" />
											<xsl:with-param
												name="y"
												select="0" />
										</xsl:call-template>
									</g>
								</xsl:when>

								<xsl:when
									test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'ExpressionCompartment'">
									<!-- Endpoint expressions -->
									<xsl:call-template name="ExpressionCompartment">
										<xsl:with-param
											name="OwnerSemanticID"
											select="$EndpointSemanticID" />
									</xsl:call-template>
								</xsl:when>
							</xsl:choose>
						</xsl:for-each>
					</g>
				</xsl:when>

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Stimulus">
					<!-- Link Stimulus -->
					<xsl:variable
						name="StimulusSemanticID"
						select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Stimulus/@xmi.idref" />
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

						<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
							<xsl:choose>
								<xsl:when
									test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Arrow'">
									<xsl:variable
										name="ActionSemanticID"
										select="key('xmi.id', $StimulusSemanticID)/UML:Stimulus.dispatchAction/*/@xmi.idref" />
									<xsl:choose>
										<xsl:when test="key('xmi.id', $ActionSemanticID)/@isAsynchronous = 'true'">
											<xsl:call-template name="AsynchronousArrow" />
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="SynchronousArrow" />
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>

								<xsl:when
									test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'SequenceExpression'">
									<g
										id="{@xmi.id}"
										transform="translate({UML:GraphElement.position/XMI.field[1]}, {UML:GraphElement.position/XMI.field[2]})">
										<xsl:apply-templates
											select="."
											mode="FontStyle" />
										<xsl:apply-templates
											select="."
											mode="isVisible" />

										<title>
											<xsl:text>SequenceExpression for </xsl:text>
											<xsl:value-of select="$StimulusSemanticID" />
										</title>
										<desc>
											<xsl:text>SequenceExpression</xsl:text>
										</desc>

										<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
											<xsl:choose>
												<xsl:when
													test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
													<xsl:call-template name="Name">
														<xsl:with-param
															name="OwnerSemanticID"
															select="$StimulusSemanticID" />
													</xsl:call-template>
												</xsl:when>
											</xsl:choose>
										</xsl:for-each>
									</g>
								</xsl:when>

								<xsl:when
									test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'TypeSeparator'">
									<!-- Separator, ':' -->
									<xsl:apply-templates
										select="."
										mode="FontStyle" />
									<xsl:call-template name="Text">
										<xsl:with-param
											name="String"
											select="$TypeSeparator" />
									</xsl:call-template>
								</xsl:when>

								<xsl:when
									test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:DestroyAction or           UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:CreateAction or           UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:CallAction or           UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:SendAction or           UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:ReturnAction">
									<g
										id="{@xmi.id}"
										transform="translate({UML:GraphElement.position/XMI.field[1]}, {UML:GraphElement.position/XMI.field[2]})">
										<xsl:apply-templates
											select="."
											mode="FontStyle" />
										<xsl:apply-templates
											select="."
											mode="isVisible" />

										<xsl:variable
											name="ActionSemanticID"
											select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

										<title>
											<xsl:text>Stimulus Action </xsl:text>
											<xsl:value-of select="$ActionSemanticID" />
											<xsl:text> for </xsl:text>
											<xsl:value-of select="$StimulusSemanticID" />
										</title>
										<desc>
											<xsl:text>Stimulus Action</xsl:text>
										</desc>

										<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
											<xsl:choose>
												<xsl:when
													test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
													<xsl:call-template name="Name">
														<xsl:with-param
															name="OwnerSemanticID"
															select="$ActionSemanticID" />
													</xsl:call-template>
												</xsl:when>
												<xsl:when
													test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Operation">
													<xsl:call-template name="Operation" />
												</xsl:when>
												<xsl:otherwise>
													<!-- !TODO: try to solve the other cases here (if any) -->
													<text>[uml2svg: not implemented]</text>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:for-each>
									</g>
								</xsl:when>
							</xsl:choose>
						</xsl:for-each>
					</g>
				</xsl:when>

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'TransitionDescription'">
					<!-- Transition description -->
					<xsl:call-template name="TransitionDescription" />
				</xsl:when>

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NamespaceCompartment'">
					<!-- Namespace compartment -->
					<xsl:call-template name="NamespaceCompartment" />
				</xsl:when>

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'ExpressionCompartment'">
					<!-- Expression compartment -->
					<xsl:call-template name="ExpressionCompartment" />
				</xsl:when>

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'StateTransitionDescription'">
					<!-- UML2 StateTransitionDescription -->
					<xsl:call-template name="StateTransitionDescription" />
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

	<!-- Build a path data ( 'd' attribute for path element) -->
	<xsl:template name="BuildPathData">

		<xsl:variable
			name="Waypoints"
			select="UML:GraphEdge.waypoints" />
		<xsl:text>M </xsl:text>
		<xsl:for-each select="$Waypoints/XMI.field">
			<xsl:choose>
				<xsl:when test="position() = 1">
					<xsl:value-of select="./XMI.field[position()=1]" />
					<xsl:text> </xsl:text>
					<xsl:value-of select="./XMI.field[position()=2]" />
					<xsl:text> L </xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="(position() mod 3) = 1">
						<xsl:value-of select="./XMI.field[position()=1]" />
						<xsl:text> </xsl:text>
						<xsl:value-of select="./XMI.field[position()=2]" />
						<xsl:text> </xsl:text>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: PackageClassBody.xsl Package body compartment -->

	<!-- PackageClassBody -->
	<xsl:template name="PackageClassBody">

		<!-- Main PackageClassBody group -->
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

			<desc>Package body compartment</desc>

			<!-- The package's outline shape, a rectangle -->
			<rect
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

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/*">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Package or UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Model">
						<xsl:call-template name="PackageClass" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Class">
						<xsl:call-template name="Class" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Actor">
						<xsl:call-template name="Actor" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Interface">
						<xsl:call-template name="Interface" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Collaboration">
						<xsl:call-template name="Collaboration" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Comment">
						<xsl:call-template name="Comment" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Generalization">
						<xsl:call-template name="Generalization_Line" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Dependency">
						<xsl:call-template name="Dependency_Line" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Association">
						<xsl:call-template name="Association_Line" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Abstraction">
						<xsl:call-template name="Abstraction_Line" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'CommentLink'">
						<xsl:call-template name="Comment_Line" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:ClassifierRole">
						<xsl:call-template name="ClassifierRole_Line" />
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: PackageClass.xsl Displays Packages from class diagrams -->

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

	<!--********************************************************************** -->
	<!-- Template: AssociationClass.xsl Displays AssociationClass -->

	<!-- AssociationClass -->
	<xsl:template name="AssociationClass">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- The outline shape, an Association Line -->
		<xsl:call-template name="Association_Line" />

		<!-- Main AssociationClass group -->
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
				<xsl:text>AssociationClass</xsl:text>
			</desc>

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/*">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'AssociationClassNode'">
						<!-- Association Node, a Class -->
						<xsl:call-template name="Class">
							<xsl:with-param
								name="SemanticID"
								select="$SemanticID" />
						</xsl:call-template>
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'AssociationClassEdge'">
						<!-- Association Edge -->
						<xsl:call-template name="AssociationClassEdge_Line" />
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: Ellipse.xsl Displays a simple ellipse. -->

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

	<!--********************************************************************** -->
	<!-- Template: Polyline.xsl Displays a simple polyline -->

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

	<!--********************************************************************** -->
	<!-- Template: FreeText.xsl Displays Free Text elements -->

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

	<!--********************************************************************** -->
	<!-- Template: ClassDiagram.xsl Processes Class Diagrams -->

	<!-- ClassDiagram -->
	<xsl:template
		match="*[UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'ClassDiagram']">
		<title>
			<xsl:value-of select="@name" />
		</title>
		<desc>Class diagram</desc>

		<!-- Contained nodes -->
		<xsl:for-each select="UML:GraphElement.contained/*">
			<xsl:choose>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Package or UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Model">
					<xsl:call-template name="PackageClass" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Class">
					<xsl:call-template name="Class" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Actor">
					<xsl:call-template name="Actor" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Interface">
					<xsl:call-template name="Interface" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:DataType">
					<xsl:call-template name="Class" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Collaboration">
					<xsl:call-template name="Collaboration" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Comment">
					<xsl:call-template name="Comment" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'FreeText'">
					<xsl:call-template name="FreeText" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Generalization">
					<xsl:call-template name="Generalization_Line" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Dependency">
					<xsl:call-template name="Dependency_Line" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Association">
					<xsl:call-template name="Association_Line" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:AssociationClass">
					<xsl:call-template name="AssociationClass" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Abstraction">
					<xsl:call-template name="Abstraction_Line" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'CommentLink'">
					<xsl:call-template name="Comment_Line" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:ClassifierRole">
					<xsl:call-template name="ClassifierRole_Line" />
				</xsl:when>

				<xsl:when test="self::UML:Ellipse">
					<xsl:call-template name="Ellipse" />
				</xsl:when>
				<xsl:when test="self::UML:Polyline">
					<xsl:call-template name="Polyline" />
				</xsl:when>
				<xsl:when
					test="namespace-uri(../../UML:Diagram.owner/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*) = 'org.omg.xmi.namespace.UML2' and UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NameCompartment'">
					<xsl:call-template name="NameCompartment">
						<xsl:with-param
							name="OwnerSemanticID"
							select="../../@xmi.id" />
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: ExtensionPoint.xsl Displays use case extension point descriptions. -->

	<!-- ExtensionPoint -->
	<xsl:template name="ExtensionPoint">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:ExtensionPoint/@xmi.idref" />

		<!-- Main ExtensionPoint group -->
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
				<xsl:text>ExtensionPoint</xsl:text>
			</desc>

			<!-- ExtensionPoint text -->
			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
						<!-- Extension name -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="key('xmi.id', $SemanticID)/@name" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NameLocationSeparator'">
						<!-- Extension name<->location separator, ':' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$NameLocationSeparator" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Location'">
						<!-- Extension location -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="key('xmi.id', $SemanticID)/@location" />
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: ExtensionPointCompartment.xsl Displays Extension points -->

	<!-- ExtensionPointCompartment -->
	<xsl:template name="ExtensionPointCompartment">

		<!-- Main ExtensionPointCompartment group -->
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
				<xsl:text>ExtensionPointCompartment</xsl:text>
			</desc>

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Label'">
						<!-- Compartment Label -->
						<g font-weight="bold">
							<xsl:call-template name="Text">
								<xsl:with-param
									name="String"
									select="'Extension Points'" />
							</xsl:call-template>
						</g>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:ExtensionPoint">
						<!-- Extension -->
						<xsl:call-template name="ExtensionPoint" />
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: UseCase.xsl Displays Use Cases as ellipses containig the object properties. -->

	<!-- UseCase -->
	<xsl:template name="UseCase">

		<xsl:param
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- UseCase outline parameters -->
		<xsl:variable name="rx">
			<xsl:value-of select="UML:GraphNode.size/XMI.field[1] div 2" />
		</xsl:variable>
		<xsl:variable name="ry">
			<xsl:value-of select="UML:GraphNode.size/XMI.field[2] div 2" />
		</xsl:variable>

		<!-- Main UseCase group -->
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
				<xsl:text>UseCase</xsl:text>
			</desc>

			<!-- The outline shape, a filled ellipse -->
			<ellipse
				cx="{$rx}"
				cy="{$ry}"
				rx="{$rx}"
				ry="{$ry}">
				<xsl:apply-templates
					select="."
					mode="FillStyle" />
			</ellipse>

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

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'CompartmentSeparator'">
						<!-- Compartment separator -->
						<xsl:call-template name="CompartmentSeparator" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'ExtensionpointCompartment'">
						<!-- Extension points -->
						<xsl:call-template name="ExtensionPointCompartment" />
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: PackageUseCaseBody.xsl Processes UseCase Package contents -->

	<!-- PackageUseCaseBody -->
	<xsl:template name="PackageUseCaseBody">

		<!-- Main PackageUseCaseBody group -->
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

			<desc>PackageBody</desc>

			<!-- The package contents outline shape, a rectangle -->
			<rect
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

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/*">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Package or UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Model">
						<xsl:call-template name="PackageUseCase" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Actor">
						<xsl:call-template name="Actor" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:UseCase">
						<xsl:call-template name="UseCase" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Collaboration">
						<xsl:call-template name="Collaboration" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Comment">
						<xsl:call-template name="Comment" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Generalization">
						<xsl:call-template name="Generalization_Line" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Dependency">
						<xsl:call-template name="Dependency_Line" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Association">
						<xsl:call-template name="Association_Line" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Abstraction">
						<xsl:call-template name="Abstraction_Line" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'CommentLink'">
						<xsl:call-template name="Comment_Line" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:ClassifierRole">
						<xsl:call-template name="ClassifierRole_Line" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Extend">
						<xsl:call-template name="Extend_Line" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Include">
						<xsl:call-template name="Include_Line" />
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: PackageUseCase.xsl Displays Packages from use case diagrams -->

	<!-- Package -->
	<xsl:template name="PackageUseCase">

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
						<xsl:call-template name="PackageUseCaseBody" />
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: UseCaseDiagram2SVG.xsl Processes UseCase Diagrams -->

	<!-- UseCaseDiagram -->
	<xsl:template
		match="*[UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'UseCaseDiagram']">

		<title>
			<xsl:value-of select="@name" />
		</title>
		<desc>UseCase diagram</desc>

		<!-- Contained nodes -->
		<xsl:for-each select="UML:GraphElement.contained/*">
			<xsl:choose>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Package or UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Model">
					<xsl:call-template name="PackageUseCase" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Class">
					<xsl:call-template name="Class" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Actor">
					<xsl:call-template name="Actor" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:UseCase">
					<xsl:call-template name="UseCase" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Collaboration">
					<xsl:call-template name="Collaboration" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Comment">
					<xsl:call-template name="Comment" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'FreeText'">
					<xsl:call-template name="FreeText" />
				</xsl:when>

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Generalization">
					<xsl:call-template name="Generalization_Line" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Dependency">
					<xsl:call-template name="Dependency_Line" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Association">
					<xsl:call-template name="Association_Line" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Abstraction">
					<xsl:call-template name="Abstraction_Line" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'CommentLink'">
					<xsl:call-template name="Comment_Line" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:ClassifierRole">
					<xsl:call-template name="ClassifierRole_Line" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Extend">
					<xsl:call-template name="Extend_Line" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Include">
					<xsl:call-template name="Include_Line" />
				</xsl:when>

				<xsl:when test="self::UML:Ellipse">
					<xsl:call-template name="Ellipse" />
				</xsl:when>
				<xsl:when test="self::UML:Polyline">
					<xsl:call-template name="Polyline" />
				</xsl:when>

				<xsl:when
					test="namespace-uri(../../UML:Diagram.owner/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*) = 'org.omg.xmi.namespace.UML2' and UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NameCompartment'">
					<xsl:call-template name="NameCompartment">
						<xsl:with-param
							name="OwnerSemanticID"
							select="../../@xmi.id" />
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: Action.xsl Displays Actions -->

	<!-- Action -->
	<xsl:template name="Action">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- Main Action group -->
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

			<desc>
				<xsl:text>Action</xsl:text>
			</desc>

			<!-- Action text -->
			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Label'">
						<!-- Action label -->
						<xsl:call-template name="Text">
							<xsl:with-param name="String">
								<xsl:choose>
									<xsl:when test="key('xmi.id', $SemanticID)/parent::UML:State.entry">
										<xsl:text>entry</xsl:text>
									</xsl:when>
									<xsl:when test="key('xmi.id', $SemanticID)/parent::UML:State.exit">
										<xsl:text>exit</xsl:text>
									</xsl:when>
									<xsl:when test="key('xmi.id', $SemanticID)/parent::UML:State.doActivity">
										<xsl:text>do</xsl:text>
									</xsl:when>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'EffectStart'">
						<!-- Label / expression delimiter, '/' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$EffectStart" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Expression'">
						<!-- Action expression -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="key('xmi.id', $SemanticID)/UML:Action.script/UML:ActionExpression/@body" />
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: Transition.xsl Displays Transitions -->

	<!-- Transition -->
	<xsl:template name="Transition">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- Main Transition group -->
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

			<desc>
				<xsl:text>Transition</xsl:text>
			</desc>

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'TransitionDescription'">
						<!-- Transition description group -->
						<xsl:call-template name="TransitionDescription" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'StereotypeCompartment'">
						<xsl:call-template name="StereotypeCompartment">
							<xsl:with-param
								name="OwnerSemanticID"
								select="SemanticID" />
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: InternalTransitionCompartment.xsl Displays InternalTransitionCompartment -->

	<!-- InternalTransitionCompartment -->
	<xsl:template name="InternalTransitionCompartment">

		<xsl:variable
			name="SemanticID"
			select="../../UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- Main InternalTransitionCompartment group -->
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
				<xsl:text>InternalTransitionCompartment</xsl:text>
			</desc>

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:CallAction">
						<!-- Call Action -->
						<xsl:call-template name="Action" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Transition">
						<!-- Internal transition -->
						<xsl:call-template name="Transition" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:OpaqueBehavior">
						<!-- UML2 OpaqueBehavior -->
						<g
							id="{@xmi.id}"
							transform="translate({UML:GraphElement.position/XMI.field[1]}, {UML:GraphElement.position/XMI.field[2]})">
							<desc>OpaqueBehavior</desc>
							<xsl:variable
								name="OpaqueBehaviorID"
								select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:OpaqueBehavior/@xmi.idref" />
							<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
								<xsl:choose>
									<xsl:when
										test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
										<xsl:call-template name="Text">
											<xsl:with-param
												name="String"
												select="key('xmi.id', $OpaqueBehaviorID)/@name" />
										</xsl:call-template>
									</xsl:when>

									<xsl:when
										test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'OpaqueBehaviorDescription'">
										<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
											<xsl:choose>
												<xsl:when
													test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Label'">
													<xsl:variable
														name="p"
														select="substring-after(name(key('xmi.id', $OpaqueBehaviorID)/..), 'State.')" />
													<xsl:variable name="label">
														<xsl:choose>
															<xsl:when test="$p = 'doActivity'">
																do
															</xsl:when>
															<xsl:otherwise>
																<xsl:value-of select="$p" />
															</xsl:otherwise>
														</xsl:choose>
													</xsl:variable>
													<xsl:call-template name="Text">
														<xsl:with-param
															name="String"
															select="$label" />
													</xsl:call-template>
												</xsl:when>

												<xsl:when
													test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'EffectStart'">
													<!-- Effect start, '/' -->
													<xsl:call-template name="Text">
														<xsl:with-param
															name="String"
															select="$EffectStart" />
													</xsl:call-template>
												</xsl:when>

												<xsl:when
													test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
													<xsl:call-template name="Text">
														<xsl:with-param
															name="String"
															select="key('xmi.id', $OpaqueBehaviorID)/@name" />
													</xsl:call-template>
												</xsl:when>
											</xsl:choose>
										</xsl:for-each>
									</xsl:when>
								</xsl:choose>
							</xsl:for-each>
						</g>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:Transition">
						<xsl:variable
							name="TransitionSemanticID"
							select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

						<!-- The main Transition group -->
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
								Transition
								<xsl:value-of select="$TransitionSemanticID" />
							</title>
							<desc>
								Transition:
								<xsl:value-of
									select="key('xmi.id', $TransitionSemanticID)/UML:Transition.source/*/@xmi.idref" />
								-&gt;
								<xsl:value-of
									select="key('xmi.id', $TransitionSemanticID)/UML:Transition.target/*/@xmi.idref" />
							</desc>

							<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
								<xsl:choose>
									<xsl:when
										test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'StateTransitionDescription'">
										<!-- UML2 StateTransitionDescription -->
										<xsl:call-template name="StateTransitionDescription">
											<xsl:with-param
												name="ShowNulls"
												select="true()" />
										</xsl:call-template>
									</xsl:when>
								</xsl:choose>
							</xsl:for-each>
						</g>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'CompartmentSeparator'">
						<xsl:call-template name="CompartmentSeparator" />
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: SimpleState.xsl Displays SimpleState as a rounded rectangle with 
		NameCompartment and InternalTransitionCompartment -->

	<!-- SimpleState -->
	<xsl:template name="SimpleState">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- Main SimpleState group -->
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
				<xsl:text>SimpleState</xsl:text>
			</desc>

			<!-- The outline shape, a rounded rectangle -->
			<rect
				width="{UML:GraphNode.size/XMI.field[1]}"
				height="{UML:GraphNode.size/XMI.field[2]}"
				rx="8"
				ry="6">
				<xsl:apply-templates
					select="."
					mode="FillStyle" />
			</rect>

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NameCompartment'">
						<!-- Name compartment -->
						<xsl:call-template name="NameCompartment" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'CompartmentSeparator'">
						<!-- Compartment separator -->
						<xsl:call-template name="CompartmentSeparator" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'InternalTransitionCompartment'">
						<!-- Internal Transitions -->
						<xsl:call-template name="InternalTransitionCompartment" />
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->


	<!-- PseudoState -->
	<xsl:template name="PseudoState">
		<xsl:param name="JunctionShape" />
		<xsl:param
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
		<xsl:param
			name="Kind"
			select="key('xmi.id', $SemanticID)/@kind" />

		<!-- Main PseudoState group -->
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
				<xsl:text>PseudoState: </xsl:text>
				<xsl:value-of select="$Kind" />
			</desc>

			<!-- State outline variables -->
			<xsl:variable
				name="rx"
				select="UML:GraphNode.size/XMI.field[1] div 2" />
			<xsl:variable
				name="ry"
				select="UML:GraphNode.size/XMI.field[2] div 2" />

			<xsl:choose>
				<xsl:when test="$Kind = 'join' or $Kind = 'fork'">
					<!-- Rectangle shape -->
					<!-- The outline shape, a rectangle (default: black) -->
					<rect
						width="{UML:GraphNode.size/XMI.field[1]}"
						height="{UML:GraphNode.size/XMI.field[2]}">
						<xsl:apply-templates
							select="."
							mode="FillStyle">
							<xsl:with-param
								name="DefaultFill"
								select="'black'" />
						</xsl:apply-templates>
					</rect>
				</xsl:when>

				<xsl:when
					test="$Kind = 'choice' or (($Kind = 'junction') and ($JunctionShape = 'Diamond'))">
					<!-- Rhombus shape -->
					<!-- The outline shape, a rhombus (default: black) -->
					<path d="M {$rx} 0 L {$rx * 2} {$ry} {$rx} {$ry * 2} 0 {$ry} z">
						<xsl:apply-templates
							select="."
							mode="FillStyle" />
					</path>
				</xsl:when>

				<xsl:when test="$Kind = 'terminate'">
					<!-- X shape -->
					<line
						x1="0"
						y1="0"
						x2="{UML:GraphNode.size/XMI.field[1]}"
						y2="{UML:GraphNode.size/XMI.field[2]}" />
					<line
						x1="{UML:GraphNode.size/XMI.field[1]}"
						y1="0"
						x2="0"
						y2="{UML:GraphNode.size/XMI.field[2]}" />
				</xsl:when>

				<xsl:when test="$Kind = 'exitPoint'">
					<!-- A circle -->
					<ellipse
						cx="{$rx}"
						cy="{$ry}"
						rx="{$rx}"
						ry="{$ry}">
						<xsl:apply-templates
							select="."
							mode="FillStyle">
							<xsl:with-param
								name="DefaultFill"
								select="'white'" />
						</xsl:apply-templates>
					</ellipse>

					<!-- X shape - inside circle -->
					<xsl:variable
						name="pad"
						select="$rx - ($rx * 0.7071067811865475)" />
					<line
						x1="{$pad}"
						y1="{$pad}"
						x2="{UML:GraphNode.size/XMI.field[1] - $pad}"
						y2="{UML:GraphNode.size/XMI.field[2] - $pad}" />
					<line
						x1="{UML:GraphNode.size/XMI.field[1] - $pad}"
						y1="{$pad}"
						x2="{$pad}"
						y2="{UML:GraphNode.size/XMI.field[2] - $pad}" />
				</xsl:when>

				<xsl:otherwise>
					<!-- Round shape -->
					<!-- The outline shape, a circle -->
					<ellipse
						cx="{$rx}"
						cy="{$ry}"
						rx="{$rx}"
						ry="{$ry}">
						<xsl:variable name="DefaultFill">
							<xsl:choose>
								<xsl:when test="$Kind = 'junction' or $Kind = 'initial'">
									black
								</xsl:when>
								<xsl:otherwise>
									white
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:apply-templates
							select="."
							mode="FillStyle">
							<xsl:with-param
								name="DefaultFill"
								select="$DefaultFill" />
						</xsl:apply-templates>
					</ellipse>
				</xsl:otherwise>
			</xsl:choose>

			<!-- State special text -->
			<xsl:choose>
				<xsl:when test="$Kind = 'deepHistory'">
					<text
						text-anchor="middle"
						x="{$rx}"
						y="{$ry}"
						style="baseline-shift: -50%"
						fill="black"
						stroke="none">H*</text>
				</xsl:when>
				<xsl:when test="$Kind = 'shallowHistory'">
					<text
						text-anchor="middle"
						x="{$rx}"
						y="{$ry}"
						style="baseline-shift: -50%"
						fill="black"
						stroke="none">H</text>
				</xsl:when>
			</xsl:choose>

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'StereotypeCompartment'">
						<!-- State stereotypes -->
						<xsl:call-template name="StereotypeCompartment" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
						<!-- State name -->
						<xsl:call-template name="Name">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$SemanticID" />
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->


	<!-- Final State -->
	<xsl:template name="FinalState">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- Main FinalState group -->
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
				<xsl:text>FinalState</xsl:text>
			</desc>

			<!-- State outline variables -->
			<xsl:variable
				name="rx"
				select="UML:GraphNode.size/XMI.field[1] div 2" />
			<xsl:variable
				name="ry"
				select="UML:GraphNode.size/XMI.field[2] div 2" />

			<!-- The outline shape, a double circle -->
			<ellipse
				cx="{$rx}"
				cy="{$ry}"
				rx="{$rx}"
				ry="{$ry}">
				<xsl:apply-templates
					select="."
					mode="FillStyle" />
			</ellipse>
			<ellipse
				cx="{$rx}"
				cy="{$ry}"
				rx="{$rx * 0.75}"
				ry="{$ry * 0.75}"
				fill="black"
				stroke="none" />

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'StereotypeCompartment'">
						<!-- State stereotypes -->
						<xsl:call-template name="StereotypeCompartment" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
						<!-- State name -->
						<xsl:call-template name="Name">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$SemanticID" />
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->


	<!-- Synch State -->
	<xsl:template name="SynchState">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- Main SynchState group -->
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
				<xsl:text>SynchState</xsl:text>
			</desc>

			<!-- State outline variables -->
			<xsl:variable
				name="rx"
				select="UML:GraphNode.size/XMI.field[1] div 2" />
			<xsl:variable
				name="ry"
				select="UML:GraphNode.size/XMI.field[2] div 2" />

			<!-- The outline shape, a circle -->
			<ellipse
				cx="{$rx}"
				cy="{$ry}"
				rx="{$rx}"
				ry="{$ry}">
				<xsl:apply-templates
					select="."
					mode="FillStyle" />
			</ellipse>

			<!-- Synchronization bound -->
			<xsl:variable
				name="SynchBound"
				select="key('xmi.id', $SemanticID)/@bound" />
			<text
				text-anchor="middle"
				x="{$rx}"
				y="{$ry}"
				style="baseline-shift: -50%"
				fill="black"
				stroke="none">
				<xsl:choose>
					<xsl:when test="$SynchBound = 0 or $SynchBound = 'unlimited'">
						*
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$SynchBound" />
					</xsl:otherwise>
				</xsl:choose>
			</text>

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'StereotypeCompartment'">
						<!-- State stereotypes -->
						<xsl:call-template name="StereotypeCompartment" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
						<!-- State name -->
						<xsl:call-template name="Name">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$SemanticID" />
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: RegionSeparator.xsl Displays RegionSeparator lines as a dashed line -->

	<!-- RegionSeparator -->
	<xsl:template name="RegionSeparator">
		<!-- The main RegionSeparator group -->
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

			<desc>RegionSeparator</desc>

			<!-- RegionSeparator line -->
			<line
				x1="0"
				y1="0"
				x2="{UML:GraphNode.size/XMI.field[1]}"
				y2="{UML:GraphNode.size/XMI.field[2]}"
				fill="none"
				stroke-dasharray="8 8" />
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: SubStates.xsl Processes Composite state substates -->

	<!-- SubStates -->
	<xsl:template name="SubStates">

		<!-- Main SubStates group -->
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

			<desc>SubStates</desc>

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/*">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Pseudostate">
						<xsl:call-template name="PseudoState" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:FinalState">
						<xsl:call-template name="FinalState" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:SynchState">
						<xsl:call-template name="SynchState" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:SimpleState">
						<xsl:call-template name="SimpleState" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:CompositeState">
						<xsl:call-template name="CompositeState" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Comment">
						<xsl:call-template name="Comment" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Transition">
						<xsl:call-template name="Transition_Line" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'CommentLink'">
						<xsl:call-template name="Comment_Line" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'RegionSeparator'">
						<xsl:call-template name="RegionSeparator" />
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: State.xsl - UML2 -->

	<!-- State -->
	<xsl:template name="State">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- Main CompositeState group -->
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
				<xsl:text>CompositeState</xsl:text>
			</desc>

			<xsl:variable
				name="width"
				select="UML:GraphNode.size/XMI.field[1]" />
			<xsl:variable
				name="height"
				select="UML:GraphNode.size/XMI.field[2]" />

			<xsl:choose>
				<xsl:when test="key('xmi.id', $SemanticID)/UML2:State.submachine">
					<clipPath
						id="{$SemanticID}SS"
						clipPathUnits="userSpaceOnUse"
						clip-rule="evenodd">
						<path
							d="M-1 -1 h{$width + 2} v{$height + 2} h-{$width + 2}v-{$height + 2} m {$width + 34} {$height - 11} a 5 3 0 1 0 0 6 5 3 0 1 0 0 -6 m 20 0 a 5 3 0 1 0 0 6 5 3 0 1 0 0 -6"
							clip-rule="evenodd" />
					</clipPath>
					<rect
						width="{$width}"
						height="{$height}"
						rx="8"
						ry="6"
						clip-path="url(#{$SemanticID}SS)">
						<xsl:apply-templates
							select="."
							mode="FillStyle" />
					</rect>
					<path
						d="M {$width - 30} {$height - 9} h 10 M {$width - 35} {$height - 12} a 5 3 0 1 0 0 6 5 3 0 1 0 0 -6 m 20 0 a 5 3 0 1 0 0 6 5 3 0 1 0 0 -6"
						fill="none" />
				</xsl:when>
				<xsl:otherwise>
					<!-- The outline shape, a rounded rectangle -->
					<rect
						width="{$width}"
						height="{$height}"
						rx="8"
						ry="6">
						<xsl:apply-templates
							select="."
							mode="FillStyle" />
					</rect>
				</xsl:otherwise>
			</xsl:choose>

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NameCompartment'">
						<!-- Name compartment -->
						<xsl:call-template name="NameCompartment" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'CompartmentSeparator'">
						<!-- Compartment separator -->
						<xsl:call-template name="CompartmentSeparator" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'InternalTransitionCompartment'">
						<!-- Internal Transitions -->
						<xsl:call-template name="InternalTransitionCompartment" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'RegionCompartment'">
						<!-- Sub regions -->
						<xsl:call-template name="RegionCompartment" />
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: Region.xsl - UML2 -->

	<!-- Region -->
	<xsl:template name="Region">

		<!-- Main Region group -->
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

			<desc>
				<xsl:text>Region</xsl:text>
			</desc>

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/*">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:State">
						<xsl:call-template name="State" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:FinalState">
						<xsl:call-template name="FinalState" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:Pseudostate">
						<xsl:call-template name="PseudoState" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:Transition">
						<xsl:call-template name="Transition_Line" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Comment">
						<xsl:call-template name="Comment" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'CommentLink'">
						<xsl:call-template name="Comment_Line" />
					</xsl:when>

				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: RegionCompartment.xsl Displays RegionCompartment -->

	<!-- RegionCompartment -->
	<xsl:template name="RegionCompartment">

		<xsl:variable
			name="SemanticID"
			select="../../UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- Main RegionCompartment group -->
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

			<desc>
				<xsl:text>RegionCompartment</xsl:text>
			</desc>

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/*">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:CompositeState">
						<!-- Region -->
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

							<desc>
								<xsl:text>SubRegion</xsl:text>
							</desc>

							<!-- Contained nodes -->
							<xsl:for-each select="UML:GraphElement.contained/*">
								<xsl:choose>
									<xsl:when
										test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:CompositeState">
										<xsl:call-template name="CompositeState" />
									</xsl:when>

									<xsl:when
										test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:SimpleState">
										<xsl:call-template name="SimpleState" />
									</xsl:when>

									<xsl:when
										test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Pseudostate">
										<xsl:call-template name="PseudoState" />
									</xsl:when>

									<xsl:when
										test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:FinalState">
										<xsl:call-template name="FinalState" />
									</xsl:when>

									<xsl:when
										test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:SynchState">
										<xsl:call-template name="SynchState" />
									</xsl:when>

									<xsl:when
										test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Comment">
										<!-- Comment -->
										<xsl:call-template name="Comment" />
									</xsl:when>

									<xsl:when
										test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Transition">
										<!-- State transition -->
										<xsl:call-template name="Transition_Line" />
									</xsl:when>

									<xsl:when
										test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'CommentLink'">
										<!-- State transition -->
										<xsl:call-template name="Comment_Line" />
									</xsl:when>
								</xsl:choose>
							</xsl:for-each>
						</g>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'RegionSeparator'">
						<!-- Region separator -->
						<xsl:call-template name="RegionSeparator" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Transition">
						<!-- State transition -->
						<xsl:call-template name="Transition_Line" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:Region">
						<!-- UML2 Region -->
						<xsl:call-template name="Region" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:Transition">
						<xsl:call-template name="Transition_Line" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Comment">
						<xsl:call-template name="Comment" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'CommentLink'">
						<xsl:call-template name="Comment_Line" />
					</xsl:when>

				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: CompositeState.xsl Displays CompositeState as a rounded rectangle 
		with NameCompartment, InternalTransitionCompartment and substates -->

	<!-- CompositeState -->
	<xsl:template name="CompositeState">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- Main CompositeState group -->
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
				<xsl:text>CompositeState</xsl:text>
			</desc>

			<!-- The outline shape, a rounded rectangle -->
			<rect
				width="{UML:GraphNode.size/XMI.field[1]}"
				height="{UML:GraphNode.size/XMI.field[2]}"
				rx="8"
				ry="6">
				<xsl:apply-templates
					select="."
					mode="FillStyle" />
			</rect>

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NameCompartment'">
						<!-- Name compartment -->
						<xsl:call-template name="NameCompartment" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'CompartmentSeparator'">
						<!-- Compartment separator -->
						<xsl:call-template name="CompartmentSeparator" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'InternalTransitionCompartment'">
						<!-- Internal Transitions -->
						<xsl:call-template name="InternalTransitionCompartment" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'SubStateCompartment'">
						<!-- Sub states -->
						<xsl:call-template name="SubStates" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'RegionCompartment'">
						<!-- Sub regions -->
						<xsl:call-template name="RegionCompartment" />
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: StateDiagram2SVG.xsl Processes State Diagrams -->

	<!-- StateDiagram -->
	<xsl:template
		match="*[UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'StateDiagram']">

		<title>
			<xsl:value-of select="@name" />
		</title>
		<desc>State diagram</desc>

		<!-- Contained nodes -->
		<xsl:for-each select="UML:GraphElement.contained/*">
			<xsl:choose>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Pseudostate">
					<xsl:call-template name="PseudoState" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:FinalState">
					<xsl:call-template name="FinalState" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:SynchState">
					<xsl:call-template name="SynchState" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:SimpleState">
					<xsl:call-template name="SimpleState" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:CompositeState">
					<xsl:call-template name="CompositeState" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Comment">
					<xsl:call-template name="Comment" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'FreeText'">
					<xsl:call-template name="FreeText" />
				</xsl:when>

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Transition">
					<xsl:call-template name="Transition_Line" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'CommentLink'">
					<xsl:call-template name="Comment_Line" />
				</xsl:when>

				<xsl:when test="self::UML:Ellipse">
					<xsl:call-template name="Ellipse" />
				</xsl:when>
				<xsl:when test="self::UML:Polyline">
					<xsl:call-template name="Polyline" />
				</xsl:when>

				<xsl:when
					test="namespace-uri(../../UML:Diagram.owner/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*) = 'org.omg.xmi.namespace.UML2' and UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NameCompartment'">
					<xsl:call-template name="NameCompartment">
						<xsl:with-param
							name="OwnerSemanticID"
							select="../../@xmi.id" />
					</xsl:call-template>
				</xsl:when>

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:State">
					<xsl:call-template name="State" />
				</xsl:when>

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:Transition">
					<xsl:call-template name="Transition_Line" />
				</xsl:when>

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:FinalState">
					<xsl:call-template name="FinalState" />
				</xsl:when>

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:Pseudostate">
					<xsl:call-template name="PseudoState" />
				</xsl:when>

			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: InStates.xsl Displays the list of states an object flow state represents 
		in an activity diagram -->

	<!-- InStates -->
	<xsl:template name="InStates">


		<!-- Main InStates group -->
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
				<xsl:text>InStates</xsl:text>
			</desc>

			<!-- InStates text -->
			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'InStatesStart'">
						<!-- Statelist start, '[' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$InStatesStart" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*">
						<!-- State -->
						<xsl:variable
							name="SemanticID"
							select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="key('xmi.id', $SemanticID)/@name" />
							<xsl:with-param
								name="TextDecoration"
								select="'underline'" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'InStatesEnd'">
						<!-- Statelist end, ']' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$InStatesEnd" />
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: ObjectFlowState.xsl Displays object flow states from activity diagrams -->

	<!-- ObjectFlowState -->
	<xsl:template name="ObjectFlowState">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- Main ObjectFlowState group -->
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
				<xsl:text>ObjectFlowState </xsl:text>
				<xsl:value-of select="$SemanticID" />
			</title>
			<desc>
				<xsl:text>ObjectFlowState</xsl:text>
			</desc>

			<!-- The outline shape, a rectangle -->
			<rect
				width="{UML:GraphNode.size/XMI.field[1]}"
				height="{UML:GraphNode.size/XMI.field[2]}">
				<xsl:apply-templates
					select="."
					mode="FillStyle">
					<xsl:with-param
						name="SemanticID"
						select="$SemanticID" />
				</xsl:apply-templates>
			</rect>

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NameCompartment'">
						<!-- Name compartment -->
						<xsl:call-template name="NameCompartment" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'InStates'">
						<!-- List of corresponding states -->
						<xsl:call-template name="InStates" />
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: ActionState.xsl - UML2 Displays ActionState as a rounded rectangle 
		with an associated action -->

	<!-- ActionState -->
	<xsl:template name="ActionState">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- Main ActionState group -->
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
				<xsl:text>ActionState</xsl:text>
			</desc>

			<!-- Outline variables -->
			<xsl:variable name="rx">
				<xsl:choose>
					<xsl:when test="UML:GraphNode.size/XMI.field[1] &lt; 150">
						<xsl:text>10</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="UML:GraphNode.size/XMI.field[1] * 0.066" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable
				name="ry"
				select="UML:GraphNode.size/XMI.field[2] div 2" />

			<!-- The outline shape, a rounded rectangle -->
			<rect
				width="{UML:GraphNode.size/XMI.field[1]}"
				height="{UML:GraphNode.size/XMI.field[2]}"
				rx="{$rx}"
				ry="{$ry}">
				<xsl:apply-templates
					select="."
					mode="FillStyle" />
			</rect>

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'StereotypeCompartment'">
						<!-- Internal Transitions -->
						<xsl:call-template name="StereotypeCompartment" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*">
						<!-- Associated action -->
						<xsl:call-template name="Action" />
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: Pin.xsl - UML2 Some kind of object -->

	<!-- Pin -->
	<xsl:template name="Pin">

		<xsl:param
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
		<xsl:param
			name="ShowArrow"
			select="false()" />

		<!-- Main Pin group -->
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
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:InputPin">
						InputPin
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:OutputPin">
						OutputPin
					</xsl:when>
					<xsl:otherwise>
						Pin
					</xsl:otherwise>
				</xsl:choose>
			</desc>

			<xsl:variable
				name="width"
				select="UML:GraphNode.size/XMI.field[1]" />
			<xsl:variable
				name="height"
				select="UML:GraphNode.size/XMI.field[2]" />

			<!-- The outline shape, a rectangle -->
			<rect
				width="{$width}"
				height="{$height}">
				<xsl:apply-templates
					select="."
					mode="FillStyle" />
			</rect>

			<xsl:if
				test="$ShowArrow and (UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:OutputPin)">
				<xsl:variable
					name="w"
					select="$width div 8" />
				<path
					fill="none"
					d="M {$w} {$height div 2} h {$width - $w - $w} l -3 -3 m 3 3 l -3 3" />
			</xsl:if>

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/*">
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

	<!--********************************************************************** -->
	<!-- Template: CallAction.xsl Displays a CallAction as a rounded rectangle with 
		an associated action -->

	<!-- CallAction -->
	<xsl:template name="CallAction">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- Main CallAction group -->
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

			<desc>
				<xsl:text>CallAction</xsl:text>
			</desc>

			<!-- Outline variables -->
			<xsl:variable name="rx">
				<xsl:choose>
					<xsl:when test="UML:GraphNode.size/XMI.field[1] &lt; 150">
						<xsl:text>10</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="UML:GraphNode.size/XMI.field[1] * 0.066" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>

			<xsl:variable name="ry">
				<xsl:choose>
					<xsl:when test="UML:GraphNode.size/XMI.field[2] &lt; 150">
						<xsl:text>10</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="UML:GraphNode.size/XMI.field[2] * 0.066" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>

			<!-- The outline shape, a rounded rectangle -->
			<rect
				width="{UML:GraphNode.size/XMI.field[1]}"
				height="{UML:GraphNode.size/XMI.field[2]}"
				rx="{$rx}"
				ry="{$ry}">
				<xsl:apply-templates
					select="."
					mode="FillStyle" />
			</rect>

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'StereotypeCompartment'">
						<xsl:call-template name="StereotypeCompartment" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NameCompartment'">
						<xsl:call-template name="NameCompartment" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:InputPin">
						<xsl:call-template name="Pin" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:OutputPin">
						<xsl:call-template name="Pin" />
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: ActivityEdgeDescription.xml - UML2 -->

	<!-- ActivityEdgeDescription -->
	<xsl:template name="ActivityEdgeDescription">
		<xsl:param
			name="ShowNulls"
			select="false()" />

		<xsl:variable
			name="SemanticID"
			select="../../UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- Main StateTransitionDescription group -->
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

			<desc>
				<xsl:text>ActivityEdgeDescription</xsl:text>
			</desc>

			<!-- TransitionDescription text -->
			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'AEGuardStart'">
						<!-- Activity edge guard start, '[' -->
						<xsl:if
							test="$ShowNulls or not(following-sibling::UML:GraphNode/UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'AENullGuard')">
							<xsl:call-template name="Text">
								<xsl:with-param
									name="String"
									select="$AEGuardStart" />
							</xsl:call-template>
						</xsl:if>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:OpaqueExpression">
						<xsl:variable
							name="OpaqueExpressionID"
							select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:OpaqueExpression/@xmi.idref" />
						<xsl:choose>
							<xsl:when test="key('xmi.id', $OpaqueExpressionID)/@name = ''">
								<xsl:call-template name="Text">
									<xsl:with-param name="String">
										<xsl:value-of select="key('xmi.id', $OpaqueExpressionID)/@body" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="Text">
									<xsl:with-param name="String">
										<xsl:value-of select="key('xmi.id', $OpaqueExpressionID)/@name" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'AEGuardEnd'">
						<!-- Activity edge guard end, ']' -->
						<xsl:if
							test="$ShowNulls or not(preceding-sibling::UML:GraphNode/UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'AENullGuard')">
							<xsl:call-template name="Text">
								<xsl:with-param
									name="String"
									select="$AEGuardEnd" />
							</xsl:call-template>
						</xsl:if>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'WeightStart'">
						<!-- Activity edge weight start, ']' -->
						<xsl:if
							test="$ShowNulls or not(following-sibling::UML:GraphNode/UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NullWeight')">
							<xsl:call-template name="Text">
								<xsl:with-param
									name="String"
									select="$WeightStart" />
							</xsl:call-template>
						</xsl:if>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'WeightIs'">
						<!-- Activity edge weight is, ']' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$WeightIs" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'WeightEnd'">
						<!-- Activity edge weight end, ']' -->
						<xsl:if
							test="$ShowNulls or not(preceding-sibling::UML:GraphNode/UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NullWeight')">
							<xsl:call-template name="Text">
								<xsl:with-param
									name="String"
									select="$WeightEnd" />
							</xsl:call-template>
						</xsl:if>
					</xsl:when>

				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: ActivityEdge.xsl - UML2 -->

	<!-- Activity edge, displayed as a simple line with a simple arrowhead -->
	<xsl:template name="ActivityEdge">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<xsl:variable name="PathData">
			<xsl:call-template name="BuildPathData" />
		</xsl:variable>

		<!-- The main ActivityEdge group -->
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
				ActivityEdge
				<xsl:value-of select="$SemanticID" />
			</title>

			<!-- The marker -->
			<xsl:call-template name="DirectedArrowheadEnd">
				<xsl:with-param
					name="OwnerDiagramID"
					select="@xmi.id" />
			</xsl:call-template>

			<!-- The line -->
			<path
				d="{$PathData}"
				fill="none"
				marker-end="url(#DirectedArrowheadEnd{@xmi.id})" />

			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'StereotypeCompartment'">
						<!-- Stereotype compartment -->
						<xsl:call-template name="StereotypeCompartment">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$SemanticID" />
						</xsl:call-template>
					</xsl:when>

					<!-- Name -->
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
						<xsl:call-template name="Name">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$SemanticID" />
						</xsl:call-template>
					</xsl:when>

					<!-- Activity edge description -->
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'ActivityEdgeDescription'">
						<xsl:call-template name="ActivityEdgeDescription">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$SemanticID" />
						</xsl:call-template>
					</xsl:when>

				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: ExceptionHandler.xsl - UML2 -->

	<!-- ExceptionHandler edge, displayed as a simple line with a simple arrowhead -->
	<xsl:template name="ExceptionHandler">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<xsl:variable name="PathData">
			<xsl:call-template name="BuildPathData" />
		</xsl:variable>

		<!-- The main ExceptionHandler group -->
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
				ExceptionHandler
				<xsl:value-of select="$SemanticID" />
			</title>

			<!-- The marker -->
			<xsl:call-template name="DirectedArrowheadEnd">
				<xsl:with-param
					name="OwnerDiagramID"
					select="@xmi.id" />
			</xsl:call-template>

			<!-- The line -->
			<path
				d="{$PathData}"
				fill="none"
				marker-end="url(#DirectedArrowheadEnd{@xmi.id})" />

			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'StereotypeCompartment'">
						<!-- Stereotype compartment -->
						<xsl:call-template name="StereotypeCompartment">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$SemanticID" />
						</xsl:call-template>
					</xsl:when>

					<!-- Name -->
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
						<xsl:call-template name="Name">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$SemanticID" />
						</xsl:call-template>
					</xsl:when>

					<!-- ImageAdornment: a small lightning bolt -->
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'ImageAdornment'">
						<g
							id="{@xmi.id}"
							transform="translate({UML:GraphElement.position/XMI.field[1]}, {UML:GraphElement.position/XMI.field[2]})">
							<path
								fill="none"
								d="M 0 0 H {UML:GraphNode.size/XMI.field[1]} L 0 {UML:GraphNode.size/XMI.field[2]-3} H {UML:GraphNode.size/XMI.field[1]} l -3 -3 m 3 3 l -3 3" />
						</g>
					</xsl:when>

				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: SendSignalAction.xsl - UML2 Some kind of object -->

	<!-- SendSignalAction -->
	<xsl:template name="SendSignalAction">

		<xsl:param
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- Main SendSignalAction group -->
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
			<desc>SendSignalAction</desc>

			<xsl:variable
				name="width"
				select="UML:GraphNode.size/XMI.field[1]" />
			<xsl:variable
				name="height"
				select="UML:GraphNode.size/XMI.field[2]" />

			<xsl:variable name="w">
				<xsl:choose>
					<xsl:when test="$width &gt;= 100 ">
						20
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$width * 0.2" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>

			<!-- <xsl:message><xsl:value-of select="$width" /></xsl:message> <xsl:message><xsl:value-of 
				select="$width >= 100" /></xsl:message> -->

			<!-- The outline shape, a Rectangle with a strange edge -->
			<path
				d="M 0 0 h {$width - $w} l {$w} {$height div 2.0} l {- $w} {$height div 2.0} h {- $width + $w} z">
				<xsl:apply-templates
					select="."
					mode="FillStyle" />
			</path>

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/*">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'StereotypeCompartment'">
						<xsl:call-template name="StereotypeCompartment" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NameCompartment'">
						<xsl:call-template name="NameCompartment">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$SemanticID" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:InputPin">
						<xsl:call-template name="Pin" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:OutputPin">
						<xsl:call-template name="Pin" />
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: AcceptEventAction.xsl - UML2 Some kind of object -->

	<!-- AcceptEventAction -->
	<xsl:template name="AcceptEventAction">

		<xsl:param
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- Main AcceptEventAction group -->
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
			<desc>AcceptEventAction</desc>

			<xsl:variable
				name="width"
				select="UML:GraphNode.size/XMI.field[1]" />
			<xsl:variable
				name="height"
				select="UML:GraphNode.size/XMI.field[2]" />

			<xsl:variable name="w">
				<xsl:choose>
					<xsl:when test="$width &gt;= 100 ">
						20
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$width * 0.2" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>


			<xsl:choose>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/@presentation = 'EggTimer'">
					<!-- The outline shape, a Rectangle with a egg timer -->
					<path d="M 0 0 h {$width} l {- $width} {$height} h {$width} z">
						<xsl:apply-templates
							select="."
							mode="FillStyle" />
					</path>
				</xsl:when>
				<xsl:otherwise>
					<!-- The outline shape, a Rectangle with a strange edge -->
					<path
						d="M 0 0 h {$width} v {$height} h {- $width} l {$w} {- $height div 2.0} z">
						<xsl:apply-templates
							select="."
							mode="FillStyle" />
					</path>
				</xsl:otherwise>
			</xsl:choose>

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/*">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'StereotypeCompartment'">
						<xsl:call-template name="StereotypeCompartment" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NameCompartment'">
						<xsl:call-template name="NameCompartment">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$SemanticID" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
						<!-- Actor Name -->
						<xsl:call-template name="Name">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$SemanticID" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:InputPin">
						<xsl:call-template name="Pin" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:OutputPin">
						<xsl:call-template name="Pin" />
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: ActivityPartition.xsl - UML2 -->

	<!-- ActivityPartition -->
	<xsl:template name="ActivityPartition">

		<xsl:param
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- Main ActivityPartition group -->
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
			<desc>ActivityPartition</desc>

			<!-- The outline shape, a Rectangle -->
			<xsl:if test="not (UML:DiagramElement.property/UML:Property/@key = 'layout')">
				<rect
					fill="none"
					width="{UML:GraphNode.size/XMI.field[1]}"
					height="{UML:GraphNode.size/XMI.field[2]}" />
			</xsl:if>

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/*">
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

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'BodyCompartment'">
						<xsl:call-template name="Compartment">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$SemanticID" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:ActivityEdge">
						<xsl:call-template name="ActivityEdge" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:ActivityPartition">
						<xsl:call-template name="ActivityPartition" />
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: Compartment.xsl -->

	<!-- Compartment -->
	<xsl:template name="Compartment">
		<xsl:param
			name="OwnerSemanticID"
			select="../../UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
		<xsl:param
			name="Name"
			select="false()" />

		<!-- Main Compartment group -->
		<g
			id="{@xmi.id}"
			transform="translate({UML:GraphElement.position/XMI.field[1]}, {UML:GraphElement.position/XMI.field[2]})">
			<xsl:apply-templates
				select="."
				mode="FontStyle" />
			<xsl:apply-templates
				select="."
				mode="isVisible" />

			<xsl:if test="$Name">
				<xsl:call-template name="Text">
					<xsl:with-param name="String">
						<xsl:value-of select="$Name" />
					</xsl:with-param>
					<xsl:with-param name="x">
						5
					</xsl:with-param>
					<xsl:with-param name="y">
						0
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>

			<desc>
				<xsl:text>Compartment</xsl:text>
			</desc>

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/*">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:CallAction">
						<xsl:call-template name="CallAction" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:ActivityEdge">
						<xsl:call-template name="ActivityEdge" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:ExceptionHandler">
						<xsl:call-template name="ExceptionHandler" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:Pin">
						<xsl:call-template name="Pin" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:AcceptEventAction">
						<xsl:call-template name="AcceptEventAction" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:SendSignalAction">
						<xsl:call-template name="SendSignalAction" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:InitialNode">
						<xsl:call-template name="PseudoState">
							<xsl:with-param
								name="Kind"
								select="'initial'" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:ActivityFinalNode">
						<xsl:call-template name="FinalState" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:FlowFinalNode">
						<xsl:call-template name="PseudoState">
							<xsl:with-param
								name="Kind"
								select="'exitPoint'" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:ForkNode">
						<xsl:call-template name="PseudoState">
							<xsl:with-param
								name="Kind"
								select="'fork'" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:JoinNode">
						<xsl:call-template name="PseudoState">
							<xsl:with-param
								name="Kind"
								select="'join'" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:DecisionNode">
						<xsl:call-template name="PseudoState">
							<xsl:with-param
								name="Kind"
								select="'choice'" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:MergeNode">
						<xsl:call-template name="PseudoState">
							<xsl:with-param
								name="Kind"
								select="'choice'" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:ActivityPartition">
						<xsl:call-template name="ActivityPartition" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:ConditionalNode">
						<xsl:call-template name="ConditionalNode" />
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: ConditionalNode.xsl - UML2 -->

	<!-- ConditionalNode -->
	<xsl:template name="ConditionalNode">

		<xsl:param
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- Main ConditionalNode group -->
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
			<desc>ConditionalNode</desc>

			<!-- Outline variables -->
			<xsl:variable name="rx">
				<xsl:choose>
					<xsl:when test="UML:GraphNode.size/XMI.field[1] &lt; 150">
						<xsl:text>10</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="UML:GraphNode.size/XMI.field[1] * 0.066" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>

			<xsl:variable name="ry">
				<xsl:choose>
					<xsl:when test="UML:GraphNode.size/XMI.field[2] &lt; 150">
						<xsl:text>10</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="UML:GraphNode.size/XMI.field[2] * 0.066" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>

			<!-- The outline shape, a rounded corner rectangle with dashed lines -->
			<rect
				style="stroke-dasharray: 10 6"
				width="{UML:GraphNode.size/XMI.field[1]}"
				height="{UML:GraphNode.size/XMI.field[2]}"
				rx="{$rx}"
				ry="{$ry}">
				<xsl:apply-templates
					select="."
					mode="FillStyle" />
			</rect>

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/*">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NameCompartment'">
						<xsl:call-template name="NameCompartment">
							<xsl:with-param
								name="OwnerSemanticID"
								select="../../@xmi.id" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'ClauseSeparator'">
						<!-- Main clause separator group -->
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
								<xsl:text>Clause separator separator</xsl:text>
							</desc>

							<!-- Clause separator line -->
							<line
								style="stroke-dasharray: 10 6"
								x1="0"
								y1="0"
								x2="{UML:GraphNode.size/XMI.field[1]}"
								y2="0" />
						</g>

					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'TestCompartment'">
						<xsl:call-template name="Compartment">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$SemanticID" />
							<xsl:with-param
								name="Name"
								select="'if'" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'BodyCompartment'">
						<xsl:call-template name="Compartment">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$SemanticID" />
							<xsl:with-param
								name="Name"
								select="'then'" />
						</xsl:call-template>
					</xsl:when>


					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'ConditionalTestCompartment'">
						<xsl:call-template name="Compartment">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$SemanticID" />
							<xsl:with-param
								name="Name"
								select="'else'" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:InputPin">
						<xsl:call-template name="Pin" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:OutputPin">
						<xsl:call-template name="Pin">
							<xsl:with-param
								name="ShowArrow"
								select="true()" />
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: InterruptableActivityRegion.xsl - UML2 -->

	<!-- InterruptableActivityRegion -->
	<xsl:template name="InterruptableActivityRegion">

		<xsl:param
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- Main InterruptableActivityRegion group -->
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
			<desc>InterruptableActivityRegion</desc>

			<!-- Outline variables -->
			<xsl:variable name="rx">
				<xsl:choose>
					<xsl:when test="UML:GraphNode.size/XMI.field[1] &lt; 150">
						<xsl:text>10</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="UML:GraphNode.size/XMI.field[1] * 0.066" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>

			<xsl:variable name="ry">
				<xsl:choose>
					<xsl:when test="UML:GraphNode.size/XMI.field[2] &lt; 150">
						<xsl:text>10</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="UML:GraphNode.size/XMI.field[2] * 0.066" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>

			<!-- The outline shape, a rounded corner rectangle with dashed lines -->
			<rect
				style="stroke-dasharray: 10 6"
				width="{UML:GraphNode.size/XMI.field[1]}"
				height="{UML:GraphNode.size/XMI.field[2]}"
				rx="{$rx}"
				ry="{$ry}">
				<xsl:apply-templates
					select="."
					mode="FillStyle" />
			</rect>

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/*">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'BodyCompartment'">
						<xsl:call-template name="Compartment">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$SemanticID" />
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: ActivityDiagram.xsl Processes Activity Diagrams -->

	<!-- ActivityDiagram -->
	<xsl:template
		match="*[UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'ActivityDiagram']">

		<title>
			<xsl:value-of select="@name" />
		</title>
		<desc>Activity diagram</desc>

		<!-- Contained nodes -->
		<xsl:for-each select="UML:GraphElement.contained/*">
			<xsl:choose>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:ObjectFlowState">
					<xsl:call-template name="ObjectFlowState" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:ActionState">
					<xsl:call-template name="ActionState" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Pseudostate">
					<xsl:call-template name="PseudoState">
						<xsl:with-param
							name="JunctionShape"
							select="'Diamond'" />
					</xsl:call-template>
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:FinalState">
					<xsl:call-template name="FinalState" />
				</xsl:when>

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Comment">
					<xsl:call-template name="Comment" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'FreeText'">
					<xsl:call-template name="FreeText" />
				</xsl:when>

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Transition">
					<xsl:call-template name="Transition_Line" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'CommentLink'">
					<xsl:call-template name="Comment_Line" />
				</xsl:when>

				<xsl:when test="self::UML:Ellipse">
					<xsl:call-template name="Ellipse" />
				</xsl:when>
				<xsl:when test="self::UML:Polyline">
					<xsl:call-template name="Polyline" />
				</xsl:when>

				<xsl:when
					test="namespace-uri(../../UML:Diagram.owner/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*) = 'org.omg.xmi.namespace.UML2' and UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NameCompartment'">
					<xsl:call-template name="NameCompartment">
						<xsl:with-param
							name="OwnerSemanticID"
							select="../../@xmi.id" />
					</xsl:call-template>
				</xsl:when>

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:CallAction">
					<xsl:call-template name="CallAction" />
				</xsl:when>

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:ActivityEdge">
					<xsl:call-template name="ActivityEdge" />
				</xsl:when>

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:ExceptionHandler">
					<xsl:call-template name="ExceptionHandler" />
				</xsl:when>

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:Pin">
					<xsl:call-template name="Pin" />
				</xsl:when>

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:AcceptEventAction">
					<xsl:call-template name="AcceptEventAction" />
				</xsl:when>

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:SendSignalAction">
					<xsl:call-template name="SendSignalAction" />
				</xsl:when>

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:InitialNode">
					<xsl:call-template name="PseudoState">
						<xsl:with-param
							name="Kind"
							select="'initial'" />
					</xsl:call-template>
				</xsl:when>

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:ActivityFinalNode">
					<xsl:call-template name="FinalState" />
				</xsl:when>

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:FlowFinalNode">
					<xsl:call-template name="PseudoState">
						<xsl:with-param
							name="Kind"
							select="'exitPoint'" />
					</xsl:call-template>
				</xsl:when>

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:ForkNode">
					<xsl:call-template name="PseudoState">
						<xsl:with-param
							name="Kind"
							select="'fork'" />
					</xsl:call-template>
				</xsl:when>

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:JoinNode">
					<xsl:call-template name="PseudoState">
						<xsl:with-param
							name="Kind"
							select="'join'" />
					</xsl:call-template>
				</xsl:when>

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:DecisionNode">
					<xsl:call-template name="PseudoState">
						<xsl:with-param
							name="Kind"
							select="'choice'" />
					</xsl:call-template>
				</xsl:when>

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:MergeNode">
					<xsl:call-template name="PseudoState">
						<xsl:with-param
							name="Kind"
							select="'choice'" />
					</xsl:call-template>
				</xsl:when>

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:ActivityParameterNode">
					<xsl:call-template name="Pin" />
				</xsl:when>

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:ActivityPartition">
					<xsl:call-template name="ActivityPartition" />
				</xsl:when>

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:ConditionalNode">
					<xsl:call-template name="ConditionalNode" />
				</xsl:when>

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:InterruptableActivityRegion">
					<xsl:call-template name="InterruptableActivityRegion" />
				</xsl:when>

			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: Object.xsl Displays objects from collaboration diagrams -->

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

	<!--********************************************************************** -->
	<!-- Template: CollaborationDiagram.xsl Processes Collaboration Diagrams -->

	<!-- CollaborationDiagram -->
	<xsl:template
		match="*[UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'CollaborationDiagram']">

		<title>
			<xsl:value-of select="@name" />
		</title>
		<desc>Collaboration diagram</desc>

		<!-- Contained nodes -->
		<xsl:for-each select="UML:GraphElement.contained/*">
			<xsl:choose>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Object">
					<xsl:call-template name="Object" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Comment">
					<xsl:call-template name="Comment" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'FreeText'">
					<xsl:call-template name="FreeText" />
				</xsl:when>

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Link">
					<xsl:call-template name="Link_Line" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'CommentLink'">
					<xsl:call-template name="Comment_Line" />
				</xsl:when>

				<xsl:when test="self::UML:Ellipse">
					<xsl:call-template name="Ellipse" />
				</xsl:when>
				<xsl:when test="self::UML:Polyline">
					<xsl:call-template name="Polyline" />
				</xsl:when>

				<xsl:when
					test="namespace-uri(../../UML:Diagram.owner/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*) = 'org.omg.xmi.namespace.UML2' and UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NameCompartment'">
					<xsl:call-template name="NameCompartment">
						<xsl:with-param
							name="OwnerSemanticID"
							select="../../@xmi.id" />
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: ObjectSequence.xsl Displays objects from sequence diagrams -->

	<!-- Object -->
	<xsl:template name="ObjectSequence">

		<xsl:variable
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

			<xsl:variable
				name="width"
				select="UML:GraphNode.size/XMI.field[1]" />
			<xsl:variable
				name="height"
				select="UML:GraphNode.size/XMI.field[2]" />
			<xsl:variable name="headerheight">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/@presentation = 'Actor'">
						<xsl:value-of
							select="UML:GraphElement.contained/*[UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'HeaderCompartment']/UML:GraphElement.position/XMI.field[2] + UML:GraphElement.contained/*[UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'HeaderCompartment']/UML:GraphElement.contained/*[UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NameCompartment']/UML:GraphElement.position/XMI.field[2] + UML:GraphElement.contained/*[UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'HeaderCompartment']/UML:GraphElement.contained/*[UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NameCompartment']/UML:GraphNode.size/XMI.field[2]" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of
							select="UML:GraphElement.contained/*[UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'HeaderCompartment']/UML:GraphNode.size/XMI.field[2]" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>

			<line
				x1="{$width div 2}"
				y1="{$headerheight}"
				x2="{$width div 2}"
				y2="{$height}"
				stroke-dasharray="6"
				fill="none" />

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'HeaderCompartment'">
						<!-- Header compartment -->
						<xsl:choose>
							<xsl:when
								test="../../UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/@presentation = 'Actor'">
								<xsl:call-template name="ActorStickman">
									<xsl:with-param
										name="SemanticID"
										select="$SemanticID" />
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="Object">
									<xsl:with-param
										name="SemanticID"
										select="$SemanticID" />
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Activation'">
						<!-- Activation zone -->
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
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Destruction'">
						<!-- Destruction mark -->
						<xsl:variable
							name="dx"
							select="UML:GraphElement.position/XMI.field[1]" />
						<xsl:variable
							name="dy"
							select="UML:GraphElement.position/XMI.field[2]" />
						<xsl:variable
							name="dw"
							select="UML:GraphNode.size/XMI.field[1]" />
						<xsl:variable
							name="dh"
							select="UML:GraphNode.size/XMI.field[2]" />
						<path d="M {$dx} {$dy} l {$dw} {$dh} m {- $dw} 0 l {$dw} {- $dh}" />
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: ObjectSequence.xsl Displays objects from sequence diagrams -->

	<!-- Object -->
	<xsl:template name="Lifeline">

		<xsl:variable
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
				<xsl:text>Lifeline</xsl:text>
			</desc>

			<xsl:variable
				name="width"
				select="UML:GraphNode.size/XMI.field[1]" />
			<xsl:variable
				name="height"
				select="UML:GraphNode.size/XMI.field[2]" />
			<xsl:variable
				name="headerheight"
				select="UML:GraphElement.contained/*[UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'HeaderCompartment']/UML:GraphNode.size/XMI.field[2]" />

			<line
				x1="{$width div 2}"
				y1="{$headerheight}"
				x2="{$width div 2}"
				y2="{$height}"
				stroke-dasharray="6"
				fill="none" />

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'HeaderCompartment'">
						<!-- Header compartment -->
						<xsl:call-template name="Object">
							<xsl:with-param
								name="SemanticID"
								select="$SemanticID" />
						</xsl:call-template>

						<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
							<xsl:choose>
								<xsl:when
									test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Actor'">
									<xsl:call-template name="ActorStickman" />
								</xsl:when>
							</xsl:choose>
						</xsl:for-each>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:ExecutionOccurrence">
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
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:Stop">
						<!-- Destruction mark -->
						<xsl:variable
							name="dx"
							select="UML:GraphElement.position/XMI.field[1]" />
						<xsl:variable
							name="dy"
							select="UML:GraphElement.position/XMI.field[2]" />
						<xsl:variable
							name="dw"
							select="UML:GraphNode.size/XMI.field[1]" />
						<xsl:variable
							name="dh"
							select="UML:GraphNode.size/XMI.field[2]" />
						<path
							d="M {$dx} {$dy} l {$dw} {$dh} m {- $dw} 0 l {$dw} {- $dh}"
							stroke-width="2px" />
					</xsl:when>

				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: SequenceDiagram2SVG.xsl Processes Sequence Diagrams -->

	<!-- SequenceDiagram -->
	<xsl:template
		match="*[UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'SequenceDiagram']">

		<title>
			<xsl:value-of select="@name" />
		</title>
		<desc>Sequence diagram</desc>

		<!-- Contained nodes -->
		<xsl:for-each select="UML:GraphElement.contained/*">
			<xsl:choose>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Object">
					<xsl:call-template name="ObjectSequence" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Comment">
					<xsl:call-template name="Comment" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'FreeText'">
					<xsl:call-template name="FreeText" />
				</xsl:when>

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Link">
					<xsl:call-template name="LinkSequence_Line" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'CommentLink'">
					<xsl:call-template name="Comment_Line" />
				</xsl:when>

				<xsl:when test="self::UML:Ellipse">
					<xsl:call-template name="Ellipse" />
				</xsl:when>
				<xsl:when test="self::UML:Polyline">
					<xsl:call-template name="Polyline" />
				</xsl:when>

				<xsl:when
					test="namespace-uri(../../UML:Diagram.owner/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*) = 'org.omg.xmi.namespace.UML2' and UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NameCompartment'">
					<xsl:call-template name="NameCompartment">
						<xsl:with-param
							name="OwnerSemanticID"
							select="../../@xmi.id" />
					</xsl:call-template>
				</xsl:when>

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:Lifeline">
					<xsl:call-template name="Lifeline" />
				</xsl:when>

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:Message">
					<xsl:call-template name="Message_Line" />
				</xsl:when>

			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: Node.xsl Displays Node (from Deployment diagrams) as a cube. -->

	<!-- Node -->
	<xsl:template name="Node">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
		<!-- Node outline parameters -->
		<xsl:variable name="w">
			<xsl:value-of select="UML:GraphNode.size/XMI.field[1]" />
		</xsl:variable>
		<xsl:variable name="h">
			<xsl:value-of select="UML:GraphNode.size/XMI.field[2]" />
		</xsl:variable>

		<!-- Main Node group -->
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
				<xsl:text>Node</xsl:text>
			</desc>

			<!-- The outline shape, a cube -->
			<path
				d="M 0 20 L 20 0 L {$w} 0 {$w} {$h - 20} {$w - 20} {$h} 0 {$h} 0 20 {$w - 20} 20 {$w - 20} {$h} M {$w} 0 {$w - 20} 20">
				<xsl:apply-templates
					select="."
					mode="FillStyle" />
			</path>

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
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'BodyCompartment'">
						<!-- Contained nodes -->
						<g
							id="{@xmi.id}"
							transform="translate(0, 20)">

							<title>
								<xsl:text>BodyCompartment for Node </xsl:text>
								<xsl:value-of select="$SemanticID" />
							</title>
							<desc>
								<xsl:text>BodyCompartment</xsl:text>
							</desc>

							<xsl:for-each select="UML:GraphElement.contained/*">
								<xsl:choose>

									<xsl:when
										test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Component">
										<xsl:call-template name="Component" />
									</xsl:when>

									<xsl:when
										test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Dependency">
										<xsl:call-template name="Dependency_Line" />
									</xsl:when>

								</xsl:choose>
							</xsl:for-each>
						</g>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: NodeInstance.xsl Displays Node Instance (from Deployment diagrams) 
		as a cube -->

	<!-- NodeInstance -->
	<xsl:template name="NodeInstance">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- NodeInstance outline parameters -->
		<xsl:variable name="w">
			<xsl:value-of select="UML:GraphNode.size/XMI.field[1]" />
		</xsl:variable>
		<xsl:variable name="h">
			<xsl:value-of select="UML:GraphNode.size/XMI.field[2]" />
		</xsl:variable>

		<!-- Main NodeInstance group -->
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
				<xsl:text>NodeInstance</xsl:text>
			</desc>

			<!-- The outline shape, a cube -->
			<path
				d="M 0 20 L 20 0 L {$w} 0 {$w} {$h - 20} {$w - 20} {$h} 0 {$h} 0 20 {$w - 20} 20 {$w - 20} {$h} M {$w} 0 {$w - 20} 20">
				<xsl:apply-templates
					select="."
					mode="FillStyle" />
			</path>

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
							<xsl:with-param
								name="TextDecoration"
								select="'underline'" />
						</xsl:call-template>
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'BodyCompartment'">
						<!-- Contained nodes -->
						<g
							id="{@xmi.id}"
							transform="translate(0, 20)">
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
								<xsl:text>BodyCompartment for NodeInstance </xsl:text>
								<xsl:value-of select="$SemanticID" />
							</title>
							<desc>
								<xsl:text>BodyCompartment</xsl:text>
							</desc>

							<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
								<xsl:choose>

									<xsl:when
										test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:ComponentInstance">
										<xsl:call-template name="ComponentInstance" />
									</xsl:when>

									<xsl:when
										test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Dependency">
										<xsl:call-template name="Dependency_Line" />
									</xsl:when>

								</xsl:choose>
							</xsl:for-each>
						</g>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: ProvidedInterfaceNode.xsl Displays ProvidedInterfaceNode (Interface 
		balls in DeploymentDiagrams) -->

	<!-- ProvidedInterfaceNode -->
	<xsl:template name="ProvidedInterfaceNode">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- Main ProvidedInterfaceNode group -->
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
				<xsl:text>ProvidedInterfaceNode</xsl:text>
			</desc>

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Interface">
						<!-- Interface -->
						<xsl:call-template name="Interface" />
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: RequiredInterfaceNode.xsl Displays RequiredInterfaceNode (Interface 
		balls in DeploymentDiagrams) -->

	<!-- RequiredInterfaceNode -->
	<xsl:template name="RequiredInterfaceNode">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- Main RequiredInterfaceNode group -->
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
				<xsl:text>RequiredInterfaceNode</xsl:text>
			</desc>

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Interface">
						<!-- Interface -->
						<xsl:call-template name="Interface" />
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: PortNameCompartment.xsl Displays Ports PortNameCompartment -->

	<!-- PortNameCompartment -->
	<xsl:template name="PortNameCompartment">

		<xsl:variable
			name="SemanticID"
			select="../../UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- Main PortNameCompartment group -->
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
				<xsl:text>PortNameCompartment</xsl:text>
			</desc>

			<!-- Contained elements -->
			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
						<!-- Port Name -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="key('xmi.id', $SemanticID)/@name" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'TypeSeparator'">
						<!-- Name/Type separator, ':' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$TypeSeparator" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'StructuralFeatureType'">
						<!-- Port Type -->
						<xsl:variable
							name="basex"
							select="UML:GraphElement.position/XMI.field[1]" />
						<xsl:variable
							name="basey"
							select="UML:GraphElement.position/XMI.field[2]" />
						<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
							<xsl:variable
								name="TypeSemanticID"
								select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
							<xsl:call-template name="Text">
								<xsl:with-param
									name="String"
									select="key('xmi.id', $TypeSemanticID)/@name" />
								<xsl:with-param
									name="x"
									select="UML:GraphElement.position/XMI.field[1] + $basex" />
								<xsl:with-param
									name="y"
									select="UML:GraphElement.position/XMI.field[2] + $basey" />
							</xsl:call-template>
						</xsl:for-each>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'MultiplicityStart'">
						<!-- Multiplicity start, '[' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$MultiplicityStart" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Multiplicity'">
						<!-- Multiplicity -->
						<xsl:call-template name="Text">
							<xsl:with-param name="String">
								<xsl:call-template name="Multiplicity">
									<xsl:with-param
										name="OwnerSemanticID"
										select="$SemanticID" />
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'MultiplicityEnd'">
						<!-- Multiplicity end, ']' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$MultiplicityEnd" />
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: ComponentInstance.xsl Displays ComponentInstance -->

	<!-- ComponentInstance -->
	<xsl:template name="ComponentInstance">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- Main ComponentInstance group -->
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
				<xsl:text>ComponentInstance</xsl:text>
			</desc>

			<xsl:variable
				name="height"
				select="UML:GraphNode.size/XMI.field[2]" />

			<!-- The outline shape, a Rectangle with two small handles -->
			<rect
				width="{UML:GraphNode.size/XMI.field[1]}"
				height="{$height}">
				<xsl:apply-templates
					select="."
					mode="FillStyle" />
			</rect>
			<rect
				width="25"
				height="10"
				x="-12.5"
				y="{$height div 2 - 20}">
				<xsl:apply-templates
					select="."
					mode="FillStyle" />
			</rect>
			<rect
				width="25"
				height="10"
				x="-12.5"
				y="{$height div 2 + 10}">
				<xsl:apply-templates
					select="."
					mode="FillStyle" />
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
							<xsl:with-param
								name="TextDecoration"
								select="'underline'" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'BodyCompartment'">
						<!-- Contained nodes -->
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
							<desc>
								<xsl:text>Component instance body</xsl:text>
							</desc>
							<xsl:for-each select="UML:GraphElement.contained/*">
								<xsl:choose>
									<xsl:when
										test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Object">
										<xsl:call-template name="Object" />
									</xsl:when>

									<xsl:when
										test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Link">
										<xsl:call-template name="Link_Line" />
									</xsl:when>
								</xsl:choose>
							</xsl:for-each>
						</g>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: Component.xsl Processes Component Content -->

	<!-- ComponentBody -->
	<xsl:template name="ComponentBody">

		<!-- Main ComponentBody group -->
		<g
			id="{@xmi.id}"
			transform="translate({UML:GraphElement.position/XMI.field[1]}, {UML:GraphElement.position/XMI.field[2]})">
			<xsl:apply-templates
				select="."
				mode="FontStyle" />
			<xsl:apply-templates
				select="."
				mode="StrokeStyle" />

			<desc>ComponentBody</desc>

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/*">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Class">
						<xsl:call-template name="Class" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Interface">
						<xsl:call-template name="Interface" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Actor">
						<xsl:call-template name="Actor" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:DataType">
						<xsl:call-template name="Class" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Object">
						<xsl:call-template name="Object" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Node">
						<xsl:call-template name="Node" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:NodeInstance">
						<xsl:call-template name="NodeInstance" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Component">
						<xsl:call-template name="Component" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:ComponentInstance">
						<xsl:call-template name="ComponentInstance" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Comment">
						<xsl:call-template name="Comment" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'FreeText'">
						<xsl:call-template name="FreeText" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Generalization">
						<xsl:call-template name="Generalization_Line" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Dependency">
						<xsl:call-template name="Dependency_Line" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Association">
						<xsl:call-template name="Association_Line" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Abstraction">
						<xsl:call-template name="Abstraction_Line" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Link">
						<xsl:call-template name="Link_Line" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'CommentLink'">
						<xsl:call-template name="Comment_Line" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:ClassifierRole">
						<xsl:call-template name="ClassifierRole_Line" />
					</xsl:when>

					<xsl:when test="self::UML:Ellipse">
						<xsl:call-template name="Ellipse" />
					</xsl:when>
					<xsl:when test="self::UML:Polyline">
						<xsl:call-template name="Polyline" />
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: Component.xsl Displays Component -->

	<!-- Component -->
	<xsl:template name="Component">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- Main Component group -->
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
				<xsl:text>Component</xsl:text>
			</desc>

			<xsl:variable
				name="height"
				select="UML:GraphNode.size/XMI.field[2]" />

			<!-- The outline shape, a Rectangle with two small handles -->
			<rect
				width="{UML:GraphNode.size/XMI.field[1]}"
				height="{$height}">
				<xsl:apply-templates
					select="."
					mode="FillStyle" />
			</rect>
			<xsl:if test="$UmlStdVersion = '1.5'">
				<rect
					width="25"
					height="10"
					x="-12.5"
					y="{$height div 2 - 20}">
					<xsl:apply-templates
						select="."
						mode="FillStyle" />
				</rect>
				<rect
					width="25"
					height="10"
					x="-12.5"
					y="{$height div 2 + 10}">
					<xsl:apply-templates
						select="."
						mode="FillStyle" />
				</rect>
			</xsl:if>

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

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'BodyCompartment'">
						<!-- Contained nodes -->
						<xsl:call-template name="ComponentBody" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge//UML:Attribute">
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
								<xsl:text>Port for </xsl:text>
								<xsl:value-of select="$SemanticID" />
							</title>
							<desc>
								<xsl:text>Port</xsl:text>
							</desc>

							<!-- The outline shape, a Rectangle -->
							<rect
								width="{UML:GraphNode.size/XMI.field[1]}"
								height="{UML:GraphNode.size/XMI.field[2]}">
								<xsl:apply-templates
									select="."
									mode="FillStyle" />
							</rect>

							<!-- Contained nodes -->
							<xsl:for-each select="UML:GraphElement.contained/*">
								<xsl:choose>
									<xsl:when
										test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'PortNameCompartment'">
										<xsl:call-template name="PortNameCompartment" />
									</xsl:when>

									<xsl:when
										test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'StereotypeCompartment'">
										<xsl:call-template name="StereotypeCompartment" />
									</xsl:when>

									<xsl:when
										test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'RequiredInterfaceEdge'">
										<xsl:call-template name="RequiredInterfaceEdge" />
									</xsl:when>

									<xsl:when
										test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'RequiredInterfaceNode'">
										<xsl:call-template name="RequiredInterfaceNode" />
									</xsl:when>

									<xsl:when
										test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'ProvidedInterfaceEdge'">
										<xsl:call-template name="ProvidedInterfaceEdge" />
									</xsl:when>

									<xsl:when
										test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'ProvidedInterfaceNode'">
										<xsl:call-template name="ProvidedInterfaceNode" />
									</xsl:when>
								</xsl:choose>
							</xsl:for-each>
						</g>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: DeploymentDiagram2SVG.xsl Processes Deployment Diagrams -->

	<!-- DeploymentDiagram -->
	<xsl:template
		match="*[UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'DeploymentDiagram']">

		<title>
			<xsl:value-of select="@name" />
		</title>
		<desc>Deployment diagram</desc>

		<!-- Contained nodes -->
		<xsl:for-each select="UML:GraphElement.contained/*">
			<xsl:choose>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Class">
					<xsl:call-template name="Class" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Interface">
					<xsl:call-template name="Interface" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Actor">
					<xsl:call-template name="Actor" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:DataType">
					<xsl:call-template name="Class" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Object">
					<xsl:call-template name="Object" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Node">
					<xsl:call-template name="Node" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:NodeInstance">
					<xsl:call-template name="NodeInstance" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Component">
					<xsl:call-template name="Component" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:ComponentInstance">
					<xsl:call-template name="ComponentInstance" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Comment">
					<xsl:call-template name="Comment" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'FreeText'">
					<xsl:call-template name="FreeText" />
				</xsl:when>

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Generalization">
					<xsl:call-template name="Generalization_Line" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Dependency">
					<xsl:call-template name="Dependency_Line" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Association">
					<xsl:call-template name="Association_Line" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:AssociationClass">
					<xsl:call-template name="AssociationClass" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Abstraction">
					<xsl:call-template name="Abstraction_Line" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Link">
					<xsl:call-template name="Link_Line" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'CommentLink'">
					<xsl:call-template name="Comment_Line" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:ClassifierRole">
					<xsl:call-template name="ClassifierRole_Line" />
				</xsl:when>

				<xsl:when test="self::UML:Ellipse">
					<xsl:call-template name="Ellipse" />
				</xsl:when>
				<xsl:when test="self::UML:Polyline">
					<xsl:call-template name="Polyline" />
				</xsl:when>

				<xsl:when
					test="namespace-uri(../../UML:Diagram.owner/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*) = 'org.omg.xmi.namespace.UML2' and UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NameCompartment'">
					<xsl:call-template name="NameCompartment">
						<xsl:with-param
							name="OwnerSemanticID"
							select="../../@xmi.id" />
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: DiagramSize.xsl Gets the width and height for a diagram -->

	<!-- DiagramSize - non recursive wrapper template -->
	<xsl:template name="DiagramSize">

		<xsl:variable name="Diagram_BBox">
			<xsl:choose>
				<xsl:when test="UML:GraphElement.contained/*">
					<xsl:for-each select="UML:GraphElement.contained/*[position() = 1]">
						<xsl:call-template name="GetBounds" />
					</xsl:for-each>
				</xsl:when>

				<xsl:otherwise>
					<xsl:text>0 0 0 0</xsl:text> <!-- empty screen -->
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable
			name="MinX"
			select="number(substring-before($Diagram_BBox, ' '))" />
		<xsl:variable
			name="MinY"
			select="number(substring-before(substring-after($Diagram_BBox, ' '), ' '))" />
		<xsl:variable
			name="MaxX"
			select="number(substring-before(substring-after(substring-after($Diagram_BBox, ' '), ' '), ' '))" />
		<xsl:variable
			name="MaxY"
			select="number(substring-after(substring-after(substring-after($Diagram_BBox, ' '), ' '), ' '))" />

		<xsl:variable
			name="Width"
			select="$MaxX - $MinX + $ViewBoxPaddingLeft + $ViewBoxPaddingRight" />
		<xsl:variable
			name="Height"
			select="$MaxY - $MinY + $ViewBoxPaddingTop + $ViewBoxPaddingBottom" />

		<xsl:attribute name="width"><xsl:value-of select="$Width * @zoom" /></xsl:attribute>
		<xsl:attribute name="height"><xsl:value-of select="$Height * @zoom" /></xsl:attribute>
		<xsl:attribute name="viewBox">
			<xsl:value-of select="$MinX - $ViewBoxPaddingLeft" />
			<xsl:text> </xsl:text>
			<xsl:value-of select="$MinY - $ViewBoxPaddingTop" />
			<xsl:text> </xsl:text>
			<xsl:value-of select="$Width" />
			<xsl:text> </xsl:text>
			<xsl:value-of select="$Height" />
		</xsl:attribute>

		<xsl:if
			test="namespace-uri(UML:Diagram.owner/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*) = 'org.omg.xmi.namespace.UML2'">
			<rect
				x="{$MinX}"
				y="{$MinY}"
				width="{$MaxX - $MinX + $ViewBoxPaddingLeft - 1}"
				height="{$MaxY - $MinY + $ViewBoxPaddingTop - 1}"
				stroke="#808080">
				<xsl:apply-templates
					select="."
					mode="StrokeStyle" />
				<xsl:apply-templates
					select="."
					mode="FillStyle">
					<xsl:with-param
						name="DefaultFill"
						select="'#FFFFE3'" />
				</xsl:apply-templates>
			</rect>
			<xsl:if
				test="UML:DiagramElement.property/UML:Property[@key = 'show-dotted-line']/@value = 'true'">
				<rect
					x="{$MinX + 10 }"
					y="{$MinY + 10}"
					width="{$MaxX - $MinX + $ViewBoxPaddingLeft - 1 - 20}"
					height="{$MaxY - $MinY + $ViewBoxPaddingTop - 1 - 20}"
					stroke="#000000"
					fill="none"
					rx="5"
					ry="5" />
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template name="GetBounds">
		<xsl:choose>
			<xsl:when test="@isVisible = 'true'">

				<xsl:variable name="MeAndMyChildrenRelative_BBox">

					<!-- Compute bounding box for the current element depending on type (node, edge, 
						etc.) -->
					<xsl:variable name="My_BBox">
						<xsl:choose>
							<xsl:when test="self::UML:GraphEdge or self::UML:Polyline">
								<!-- GraphEdge or Polyline, check the waypoints -->
								<!-- Edge path minimum X -->
								<xsl:for-each
									select="*[substring-after(name(),'.')='waypoints']/XMI.field[position() mod 3 = 1]/XMI.field[1]">
									<xsl:sort
										select="."
										data-type="number"
										order="ascending" />
									<xsl:if test="position() = 1">
										<xsl:value-of select="." />
									</xsl:if>
								</xsl:for-each>

								<xsl:text> </xsl:text>

								<!-- Edge path minimum Y -->
								<xsl:for-each
									select="*[substring-after(name(),'.')='waypoints']/XMI.field[position() mod 3 = 1]/XMI.field[2]">
									<xsl:sort
										select="."
										data-type="number"
										order="ascending" />
									<xsl:if test="position() = 1">
										<xsl:value-of select="." />
									</xsl:if>
								</xsl:for-each>

								<xsl:text> </xsl:text>

								<!-- Edge path maximum X -->
								<xsl:for-each
									select="*[substring-after(name(),'.')='waypoints']/XMI.field[position() mod 3 = 1]/XMI.field[1]">
									<xsl:sort
										select="."
										data-type="number"
										order="descending" />
									<xsl:if test="position() = 1">
										<xsl:value-of select="." />
									</xsl:if>
								</xsl:for-each>

								<xsl:text> </xsl:text>

								<!-- Edge path maximum Y -->
								<xsl:for-each
									select="*[substring-after(name(),'.')='waypoints']/XMI.field[position() mod 3 = 1]/XMI.field[2]">
									<xsl:sort
										select="."
										data-type="number"
										order="descending" />
									<xsl:if test="position() = 1">
										<xsl:value-of select="." />
									</xsl:if>
								</xsl:for-each>
							</xsl:when>

							<xsl:when
								test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:ActivityParameterNode" />

							<xsl:when
								test="self::UML:GraphNode and not (UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:ActivityParameterNode)">
								<xsl:if
									test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:ActivityParameterNode">
									<xsl:message>
										Crap
									</xsl:message>
								</xsl:if>
								<!-- GraphNode - UML:GraphNode.size -->
								<!-- UML:GraphElement.position is added later (also to the children) -->
								<!-- Node minimum X = 0 (Node X position is added later) -->
								<xsl:value-of select="0" />
								<xsl:text> </xsl:text>
								<!-- Node minimum Y = 0 (Node Y position is added later) -->
								<xsl:value-of select="0" />
								<xsl:text> </xsl:text>
								<!-- Node maximum X = Node width (Node X position is added later) -->
								<xsl:value-of select="UML:GraphNode.size/XMI.field[1]" />
								<xsl:text> </xsl:text>
								<!-- Node maximum Y = Node height (Node Y position is added later) -->
								<xsl:value-of select="UML:GraphNode.size/XMI.field[2]" />
							</xsl:when>

							<xsl:when test="self::UML:Ellipse">
								<xsl:value-of select="UML:Ellipse.center/XMI.field[1] - @radiusX" />
								<xsl:text> </xsl:text>
								<xsl:value-of select="UML:Ellipse.center/XMI.field[2] - @radiusY" />
								<xsl:text> </xsl:text>
								<xsl:value-of select="UML:Ellipse.center/XMI.field[1] + @radiusX" />
								<xsl:text> </xsl:text>
								<xsl:value-of select="UML:Ellipse.center/XMI.field[2] + @radiusY" />
							</xsl:when>

							<xsl:otherwise>
								<!-- Keep the code "safe" in case something strange is encountered -->
								<xsl:text>Infinity Infinity -Infinity -Infinity</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>

					<!-- <xsl:message><xsl:value-of select="@xmi.id"/> My_BBox: <xsl:value-of select="$My_BBox"/></xsl:message> -->

					<xsl:choose>
						<!-- element has children -->
						<xsl:when test="UML:GraphElement.contained/*">

							<!-- Compute bounding box for children (call only the first child as the childs 
								will call each other) -->
							<xsl:variable name="Children_BBox">
								<xsl:for-each select="UML:GraphElement.contained/*[position() = 1]">
									<xsl:call-template name="GetBounds" />
								</xsl:for-each>
							</xsl:variable>

							<!-- <xsl:message><xsl:value-of select="@xmi.id"/> Children_BBox: <xsl:value-of 
								select="$Children_BBox"/></xsl:message> -->

							<!-- Split this node's BBox into the 4 components: MinX, MinY, MaxX, MaxY -->
							<xsl:variable
								name="Self_MinX"
								select="substring-before($My_BBox, ' ')" />
							<xsl:variable
								name="Self_MinY"
								select="substring-before(substring-after($My_BBox, ' '), ' ')" />
							<xsl:variable
								name="Self_MaxX"
								select="substring-before(substring-after(substring-after($My_BBox, ' '), ' '), ' ')" />
							<xsl:variable
								name="Self_MaxY"
								select="substring-after(substring-after(substring-after($My_BBox, ' '), ' '), ' ')" />

							<!-- Split the children BBox into the 4 components: MinX, MinY, MaxX, MaxY -->
							<xsl:variable
								name="Child_MinX"
								select="substring-before($Children_BBox, ' ')" />
							<xsl:variable
								name="Child_MinY"
								select="substring-before(substring-after($Children_BBox, ' '), ' ')" />
							<xsl:variable
								name="Child_MaxX"
								select="substring-before(substring-after(substring-after($Children_BBox, ' '), ' '), ' ')" />
							<xsl:variable
								name="Child_MaxY"
								select="substring-after(substring-after(substring-after($Children_BBox, ' '), ' '), ' ')" />

							<xsl:choose>
								<xsl:when test="($Child_MinX = 'Infinity') and ($Self_MinX = 'Infinity')">
									<xsl:text>Infinity</xsl:text>
								</xsl:when>
								<xsl:when
									test="($Child_MinX = 'Infinity') or (number($Self_MinX) &lt;= number($Child_MinX))">
									<xsl:value-of select="number($Self_MinX)" />
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="number($Child_MinX)" />
								</xsl:otherwise>
							</xsl:choose>

							<xsl:text> </xsl:text>

							<xsl:choose>
								<xsl:when test="($Child_MinY = 'Infinity') and ($Self_MinY = 'Infinity')">
									<xsl:text>Infinity</xsl:text>
								</xsl:when>
								<xsl:when
									test="($Child_MinY = 'Infinity') or (number($Self_MinY) &lt;= number($Child_MinY))">
									<xsl:value-of select="number($Self_MinY)" />
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="number($Child_MinY)" />
								</xsl:otherwise>
							</xsl:choose>

							<xsl:text> </xsl:text>

							<xsl:choose>
								<xsl:when test="($Child_MaxX = '-Infinity') and ($Self_MaxX = '-Infinity')">
									<xsl:text>-Infinity</xsl:text>
								</xsl:when>
								<xsl:when
									test="($Child_MaxX = '-Infinity') or (number($Child_MaxX) &lt; number($Self_MaxX))">
									<xsl:value-of select="number($Self_MaxX)" />
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="number($Child_MaxX)" />
								</xsl:otherwise>
							</xsl:choose>

							<xsl:text> </xsl:text>

							<xsl:choose>
								<xsl:when test="($Child_MaxY = '-Infinity') and ($Self_MaxY = '-Infinity')">
									<xsl:text>-Infinity</xsl:text>
								</xsl:when>
								<xsl:when
									test="($Child_MaxY = '-Infinity') or (number($Child_MaxY) &lt; number($Self_MaxY))">
									<xsl:value-of select="number($Self_MaxY) " />
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="number($Child_MaxY) " />
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>

						<xsl:otherwise> <!-- element has no children -->
							<xsl:value-of select="$My_BBox" />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable> <!-- MeAndMyChildrenRelative_BBox -->

				<!-- <xsl:message><xsl:value-of select="@xmi.id"/> MeAndMyChildrenRelative_BBox: 
					<xsl:value-of select="$MeAndMyChildrenRelative_BBox"/></xsl:message> -->

				<xsl:variable name="MeAndMyChildren_BBox">
					<xsl:choose>
						<xsl:when test="UML:GraphElement.position">
							<xsl:variable
								name="Relative_MinX"
								select="substring-before($MeAndMyChildrenRelative_BBox, ' ')" />
							<xsl:variable
								name="Relative_MinY"
								select="substring-before(substring-after($MeAndMyChildrenRelative_BBox, ' '), ' ')" />
							<xsl:variable
								name="Relative_MaxX"
								select="substring-before(substring-after(substring-after($MeAndMyChildrenRelative_BBox, ' '), ' '), ' ')" />
							<xsl:variable
								name="Relative_MaxY"
								select="substring-after(substring-after(substring-after($MeAndMyChildrenRelative_BBox, ' '), ' '), ' ')" />
							<xsl:value-of
								select="number($Relative_MinX) + number(UML:GraphElement.position/XMI.field[1])" />
							<xsl:text> </xsl:text>
							<xsl:value-of
								select="number($Relative_MinY) + number(UML:GraphElement.position/XMI.field[2])" />
							<xsl:text> </xsl:text>
							<xsl:value-of
								select="number($Relative_MaxX) + number(UML:GraphElement.position/XMI.field[1])" />
							<xsl:text> </xsl:text>
							<xsl:value-of
								select="number($Relative_MaxY) + number(UML:GraphElement.position/XMI.field[2])" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$MeAndMyChildrenRelative_BBox" />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>


				<!-- <xsl:message><xsl:value-of select="@xmi.id"/> MeAndMyChildren_BBox: <xsl:value-of 
					select="$MeAndMyChildren_BBox"/></xsl:message> -->

				<xsl:choose>
					<xsl:when test="following-sibling::*">
						<!-- Compute bounding box for the rest of the siblings (they call each other 
							in turn) -->
						<xsl:variable name="FollowingSiblings_BBox">
							<xsl:for-each select="following-sibling::*[position() = 1]">
								<xsl:call-template name="GetBounds" />
							</xsl:for-each>
						</xsl:variable>

						<!-- <xsl:message><xsl:value-of select="@xmi.id"/> FollowingSiblings_BBox: 
							<xsl:value-of select="$FollowingSiblings_BBox"/></xsl:message> -->

						<!-- Split this element's BBox into the 4 components: MinX, MinY, MaxX, MaxY -->
						<xsl:variable
							name="MeAndChildren_MinX"
							select="substring-before($MeAndMyChildren_BBox, ' ')" />
						<xsl:variable
							name="MeAndChildren_MinY"
							select="substring-before(substring-after($MeAndMyChildren_BBox, ' '), ' ')" />
						<xsl:variable
							name="MeAndChildren_MaxX"
							select="substring-before(substring-after(substring-after($MeAndMyChildren_BBox, ' '), ' '), ' ')" />
						<xsl:variable
							name="MeAndChildren_MaxY"
							select="substring-after(substring-after(substring-after($MeAndMyChildren_BBox, ' '), ' '), ' ')" />

						<!-- Split the following siblings' BBox into the 4 components: MinX, MinY, 
							MaxX, MaxY -->
						<xsl:variable
							name="Following_MinX"
							select="substring-before($FollowingSiblings_BBox, ' ')" />
						<xsl:variable
							name="Following_MinY"
							select="substring-before(substring-after($FollowingSiblings_BBox, ' '), ' ')" />
						<xsl:variable
							name="Following_MaxX"
							select="substring-before(substring-after(substring-after($FollowingSiblings_BBox, ' '), ' '), ' ')" />
						<xsl:variable
							name="Following_MaxY"
							select="substring-after(substring-after(substring-after($FollowingSiblings_BBox, ' '), ' '), ' ')" />

						<xsl:choose>
							<xsl:when
								test="($Following_MinX = 'Infinity') and ($MeAndChildren_MinX = 'Infinity')">
								<xsl:text>Infinity</xsl:text>
							</xsl:when>
							<xsl:when
								test="($Following_MinX = 'Infinity') or (number($MeAndChildren_MinX) &lt;= number($Following_MinX))">
								<xsl:value-of select="number($MeAndChildren_MinX)" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="number($Following_MinX)" />
							</xsl:otherwise>
						</xsl:choose>

						<xsl:text> </xsl:text>

						<xsl:choose>
							<xsl:when
								test="($Following_MinY = 'Infinity') and ($MeAndChildren_MinY = 'Infinity')">
								<xsl:text>Infinity</xsl:text>
							</xsl:when>
							<xsl:when
								test="($Following_MinY = 'Infinity') or (number($MeAndChildren_MinY) &lt;= number($Following_MinY))">
								<xsl:value-of select="number($MeAndChildren_MinY)" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="number($Following_MinY)" />
							</xsl:otherwise>
						</xsl:choose>

						<xsl:text> </xsl:text>

						<xsl:choose>
							<xsl:when
								test="($Following_MaxX = '-Infinity') and ($MeAndChildren_MaxX = '-Infinity')">
								<xsl:text>-Infinity</xsl:text>
							</xsl:when>
							<xsl:when
								test="($Following_MaxX = '-Infinity') or (number($MeAndChildren_MaxX) &gt;= number($Following_MaxX))">
								<xsl:value-of select="number($MeAndChildren_MaxX)" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="number($Following_MaxX)" />
							</xsl:otherwise>
						</xsl:choose>

						<xsl:text> </xsl:text>

						<xsl:choose>
							<xsl:when
								test="($Following_MaxY = '-Infinity') and ($MeAndChildren_MaxY = '-Infinity')">
								<xsl:text>-Infinity</xsl:text>
							</xsl:when>
							<xsl:when
								test="($Following_MaxY = '-Infinity') or (number($MeAndChildren_MaxY) &gt;= number($Following_MaxY))">
								<xsl:value-of select="number($MeAndChildren_MaxY)" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="number($Following_MaxY)" />
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>

					<xsl:otherwise> <!-- element has no siblings -->
						<xsl:value-of select="$MeAndMyChildren_BBox" />
					</xsl:otherwise>

				</xsl:choose>
			</xsl:when>

			<xsl:otherwise> <!-- invisible element (has to call its siblings though) -->
				<xsl:choose>
					<xsl:when test="following-sibling::*">
						<xsl:for-each select="following-sibling::*[position() = 1]">
							<xsl:call-template name="GetBounds" />
						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>Infinity Infinity -Infinity -Infinity</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: MakeArrowScript.xsl Outputs the script that handles the Stimuli Arrows 
		directions -->

	<!-- MakeArrowScript -->
	<xsl:template name="MakeArrowScript">
		<script type="text/ecmascript">
			<xsl:text disable-output-escaping="yes">&lt;![CDATA[
	function OrientArrows(){
		var descriptions = document.getElementsByTagName('desc');
		for(i = 0; i &lt; descriptions.length; i++){
			if((descriptions.item(i).childNodes.item(0).nodeValue == 'SynchronousArrow') || (descriptions.item(i).childNodes.item(0).nodeValue == 'AsynchronousArrow')){
				var parentg = descriptions.item(i).parentNode;
				var rotate = getStimulusArrowRotation(parentg);
				transform = parentg.getAttribute('transform');
				transform += ' rotate(' + rotate + ')';
				parentg.setAttribute('transform', transform);
			}
		}
	}

	function getStimulusArrowRotation(Node){
		var pathparentg = Node.parentNode.parentNode;
		var path;
		for(k = 0; k &lt; pathparentg.childNodes.length; k++){
			if(pathparentg.childNodes.item(k).localName == 'path'){
				pathdata = pathparentg.childNodes.item(k).getAttribute('d');
				break;
			}
		}

		pathsegments = pathdata.split(' ');
		var pathpoints = new Array();
		pathpoints[0] = pathsegments[1];
		pathpoints[1] = pathsegments[2];
		for(k = 4; k &lt; pathsegments.length - 1; k++){
			pathpoints[pathpoints.length] = pathsegments[k];
		}

		var MinDistance = null;
		var Rotation = 0;
		transform = Node.getAttribute('transform');
		parentTransform = Node.parentNode.getAttribute('transform');
		xp = parseFloat(transform.split('(')[1].split(',')[0]) + parseFloat(parentTransform.split('(')[1].split(',')[0]);
		yp = parseFloat(transform.split(',')[1].split(')')[0]) + parseFloat(parentTransform.split(',')[1].split(')')[0]);

		for(k = 0; k &lt; pathpoints.length / 2 - 1; k++){
			xa = pathpoints[2*k];
			ya = pathpoints[2*k+1];
			xb = pathpoints[2*k+2];
			yb = pathpoints[2*k+3];
			if(xa == xb){
				d = Math.abs(xa - xp);
				if((d &lt; MinDistance) || (MinDistance == null)){
					MinDistance = d;
					if(ya &lt; yb) Rotation = -90;
					else Rotation = 90;
				}
			}
			else{
				m = (yb-ya)/(xb-xa);
				n = ya - xa*m;
				y = (m*m*yp - m*xp - n)/(m*m-1);
				x = m*y-m*yp+xp;
				if((xa &lt; xb &amp;&amp; xa &lt;= x &amp;&amp; x &lt;= xb) || (xb &lt; xa &amp;&amp; xb &lt;= x &amp;&amp; x &lt;= xa)){
					d = Math.sqrt((x-xp)*(x-xp) + (y-yp)*(y-yp));
				}
				else{
					DistanceToA = Math.sqrt((xp-xa)*(xp-xa) + (yp-ya)*(yp-ya));
					DistanceToB = Math.sqrt((xp-xb)*(xp-xb) + (yp-yb)*(yp-yb));
					d = DistanceToA &lt; DistanceToB ? DistanceToA : DistanceToB;
				}
				if((d &lt; MinDistance) || (MinDistance == null)){
					MinDistance = d;
					Rotation = Math.atan(m) * 180 / Math.PI;
					if(xa &lt; xb){
						Rotation += 180;
					}
				}
			}
		}
		return Rotation;
	}
		]]&gt;</xsl:text>
		</script>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: MakeTreeScript.xsl Outputs the script that handles the tree -->

	<!-- MakeTreeScript -->
	<xsl:template name="MakeTreeScript">
		<!-- Main TreeScript group -->
		<rect
			id="BackgroundRect"
			width="100%"
			height="100%"
			fill="#FFF"
			stroke="none" />
		<script type="text/ecmascript">
			<xsl:text disable-output-escaping="yes">&lt;![CDATA[
	function show(id){
		document.getElementById(id).setAttribute('display', 'inline');
		document.getElementById(id+'S').childNodes.item(0).nodeValue = "-";
		document.getElementById(id+'S').setAttribute('onclick', 'hide("' + id + '")');
		UpdateScrollbars();
	}
	function hide(id){
		document.getElementById(id).setAttribute('display', 'none');
		document.getElementById(id+'S').childNodes.item(0).nodeValue = "+";
		document.getElementById(id+'S').setAttribute('onclick', 'show("' + id + '")');
		UpdateScrollbars();
	}

	function treeNodeClick(id){
		if(document.getElementById(id).getAttribute('display') == 'none'){
			show(id);
		}
		else {
			hide(id);
		}
	}

	function UpdateScrollbars(){
		var TreeViewBox = document.getElementById('DiagramTreeSVG').getAttribute('viewBox');
		var TreeViewRect = svgDocument.documentElement.createSVGRect();
		var viewBoxParams = TreeViewBox.split(/\s*,\s*|\s+/);
		TreeViewRect.x = parseFloat(viewBoxParams[0]);
		TreeViewRect.y = parseFloat(viewBoxParams[1]);
		TreeViewRect.width = parseFloat(viewBoxParams[2]);
		TreeViewRect.height = parseFloat(viewBoxParams[3]);
		var TreeBBox = document.getElementById('DiagramTreeSVG').getBBox();
		TreeScroller.UpdateScrollbars(TreeBBox, TreeViewRect);
	}

	var CurrentDiagramID = null;
	function showDiagram(ID){
		if(CurrentDiagramID != null){
			document.getElementById(CurrentDiagramID).setAttribute('display', 'none');
			document.getElementById(CurrentDiagramID + 'T').setAttribute('fill', '#FFFFE3');
			document.getElementById(CurrentDiagramID + 'T').setAttribute('onmouseover', "document.getElementById('" + CurrentDiagramID + "T').setAttribute('fill', '#FFF')");
			document.getElementById(CurrentDiagramID + 'T').setAttribute('onmouseout', "document.getElementById('" + CurrentDiagramID + "T').setAttribute('fill', '#FFFFE3')");
		}
		document.getElementById(ID).setAttribute('display', 'inline');
		CurrentDiagramID = ID;
		document.getElementById(CurrentDiagramID + 'T').setAttribute('fill', '#FFE089');
		document.getElementById(CurrentDiagramID + 'T').setAttribute('onmouseover', "");
		document.getElementById(CurrentDiagramID + 'T').setAttribute('onmouseout', "");
	}

//----------------------------------------------------
//     Compute the minimum of 2 numbers
//----------------------------------------------------
function Minimum(Param1, Param2){
 return parseFloat((Param1 &lt; Param2) ? Param1 : Param2);
}

//----------------------------------------------------
//     Compute the maximum of 2 numbers
//----------------------------------------------------
function Maximum(Param1, Param2){
 return parseFloat((Param1 &gt; Param2) ? Param1 : Param2);
}

		]]&gt;</xsl:text>
		</script>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: MakeTree.xsl Outputs the diagram tree -->

	<!-- MakeTreeScript -->
	<xsl:template name="MakeTree">
		<script type="text/ecmascript">
			<xsl:text disable-output-escaping="yes">&lt;![CDATA[
/*****
*
*   AntiZoomAndPan.js
*
*   copyright 2002, Kevin Lindsey
*
*****/

AntiZoomAndPan.VERSION = "1.2"

/*****
*
*   constructor
*
*****/
function AntiZoomAndPan() {
    this.init();
}

/*****
*
*   init
*
*****/
AntiZoomAndPan.prototype.init = function() {
	if(window.svgDocument == null){
		svgDocument = document;
	}
    var svgRoot = svgDocument.documentElement;

    // Initialize properties;
    this.svgNodes = new Array();
    this.x_trans  = 0;
    this.y_trans  = 0;
    this.scale    = 1;
    this.lastTM   = svgRoot.createSVGMatrix();

    // Setup event listeners to capture zoom and scroll events
    svgRoot.addEventListener('SVGZoom',   this, false);
    svgRoot.addEventListener('SVGScroll', this, false);
    svgRoot.addEventListener('SVGResize', this, false);
};

/*****
*
*   appendNode
*
*****/
AntiZoomAndPan.prototype.appendNode = function(svgNode) {
    // Add node to a array
    this.svgNodes.push(svgNode);
};

/*****
*
*   removeNode
*
*****/
AntiZoomAndPan.prototype.removeNode = function(svgNode) {
    // Remove node if found
    for ( var i = 0; i &lt; this.svgNodes.length; i++ ) {
        if ( this.svgNodes[i] === svgNode ) {
            this.svgNodes.splice(i, 1);
            break;
        }
    }
};

/*****
*
*   Event Handlers
*
*****/

/*****
*
*   handleEvent
*
*****/
AntiZoomAndPan.prototype.handleEvent = function(e) {
    var type = e.type;

    if ( this[type] == null )
        throw new Error("Unsupported event type: " + type);

    this[type](e);
};


/*****
*
*   SVGZoom
*
*****/
AntiZoomAndPan.prototype.SVGZoom = function(e) {
    // Update current transform
    this.update();
};


/*****
*
*   SVGScroll
*
*****/
AntiZoomAndPan.prototype.SVGScroll = function(e) {
    // Update current transform
    this.update();
};

/*****
*
*   SVGResize
*
*****/

AntiZoomAndPan.prototype.SVGResize = function(e) {
    // Update current transform
    this.update();
};

/*****
*
*   update
*
*****/
AntiZoomAndPan.prototype.update = function() {
	if ( this.svgNodes.length &gt; 0 ) {
		var svgRoot = svgDocument.documentElement;
		var viewbox = ( window.ViewBox != null )
			? new ViewBox(svgRoot)
			: null;
		var matrix  = ( viewbox != null )
			? viewbox.getTM()
			: svgRoot.createSVGMatrix();
		var trans   = svgRoot.currentTranslate;

		// Set the scale factor to leave object at original scale
		matrix = matrix.scale( 1.0 / svgRoot.currentScale);

		// Get the current pan settings
		matrix = matrix.translate(-trans.x, -trans.y);

		// Apply combined transforms to all managed nodes
		for ( var i = 0; i &lt; this.svgNodes.length; i++ ) {
			var node = this.svgNodes[i];
			var CTM  = matrix.multiply( this.lastTM.multiply(node.getCTM()) );
			var transform = "matrix(" + [ CTM.a, CTM.b, CTM.c, CTM.d, CTM.e, CTM.f ].join(",") + ")";
			this.svgNodes[i].setAttributeNS(null, "transform", transform);
		}
    }

	var TreeViewBox = document.getElementById('DiagramTreeSVG').getAttribute('viewBox');
	var viewBoxParams = TreeViewBox.split(/\s*,\s*|\s+/);

	var innerHeight;
	if(window.innerHeight){
		innerHeight = window.innerHeight;
	}
	else if(svgDocument.documentElement.height){
		innerHeight = svgDocument.documentElement.height.baseVal.value;
	}

	svgDocument.getElementById("DiagramTreeSVG").setAttribute('viewBox', viewBoxParams[0] + ' ' +  viewBoxParams[1] + ' 200 ' + (innerHeight));
	TreeScroller.ResizeScrollbars(innerHeight);
	UpdateScrollbars();
	this.lastTM = matrix.inverse();
};
		]]&gt;
		</xsl:text>
		</script>

		<script>
			<xsl:text disable-output-escaping="yes">&lt;![CDATA[
        var azap = new AntiZoomAndPan();

        function init(evt) {
            if ( window.svgDocument == null ){
                svgDocument = window.evt.target.ownerDocument;
            }
            var Tree = svgDocument.getElementById("DiagramTree");
            azap.appendNode(Tree);
            azap.appendNode(svgDocument.getElementById("BackgroundRect"));

/*            var Diagrams = svgDocument.getElementsByTagName("svg");
			for(var i = 0; i &lt; Diagrams.length; i++){
				var Diagram = Diagrams.item(i);
				var id = Diagram.getAttribute('id');
				if(id AND id != 'DiagramTreeSVG'){
					azap.appendNode(Diagram);
					Diagram.setAttribute('zoomAndPan', 'disable');
				}
            }*/

            var innerHeight;
            if(window.innerHeight){
                innerHeight = window.innerHeight;
            }
            else if(svgDocument.documentElement.height){
                innerHeight = svgDocument.documentElement.height.baseVal.value;
            }
            svgDocument.getElementById("DiagramTreeSVG").setAttribute('viewBox', '0 0 200 ' + (innerHeight));

            // This update is needed to initialize all mananged nodes
            // Really this is a hack to get around this "feature" of the code
            azap.update();
            clinit(evt)
        }
		]]&gt;
		</xsl:text>
		</script>

		<script>
			<xsl:text disable-output-escaping="yes">&lt;![CDATA[
/*-----------------------------------------
|  Slightly inspired from Kevin Lindsey's ViewBox.svg
| http://www.kevlindev.com/gui/utilities/viewbox/index.htm
-------------------------------------------*/

var svgns = "http://www.w3.org/2000/svg";
var svgRoot;
var viewBox;

function clinit(evt) {
    if ( window.svgDocument == null )
        svgDocument = evt.target.ownerDocument;
    svgRoot         = svgDocument.documentElement;
    viewBox         = new ViewBox(svgRoot);
}

function ScreenToClient(parent, e) {
    var trans  = svgRoot.getCurrentTranslate();
    var scale  = svgRoot.getCurrentScale();
    var m      = viewBox.getTM();
    var p1     = svgRoot.createSVGPoint();
    var p2, p3;
    m = m.scale( 1/scale );
    m = m.translate(-trans.x, -trans.y);
    p1.x = e.clientX;
    p1.y = e.clientY;
    p2 = p1.matrixTransform(m);
    p3 = Transform2Parent(parent, p2);
    return p3;
}

function Transform2Parent(node, point){
  if(node == svgDocument){
    return point;
  }
  point = Transform2Parent(node.parentNode, point);
  var x = node.getAttribute('x') ? parseFloat(node.getAttribute('x')) : 0;
  var y = node.getAttribute('y') ? parseFloat(node.getAttribute('y')) : 0;
  point.x -= x;
  point.y -= y;
  var v = node.getAttribute('viewBox');
  if(v){
    var params = v.split(/\s*,\s*|\s+/);
    var vx  = parseFloat( params[0] );
    var vy  = parseFloat( params[1] );
    var vwidth  = parseFloat( params[2] );
    var width   = parseFloat( node.getAttribute('width'));
    point.x += vx;
    point.y += vy;
    if(width){
      point.x = point.x * (vwidth / width);
      point.y = point.y * (vwidth / width);
    }
  }
  point = point.matrixTransform(node.getCTM().inverse());
  return point;
}
		]]&gt;
		</xsl:text>
		</script>

		<script>
			<xsl:text disable-output-escaping="yes">&lt;![CDATA[
/*****
*
*   ViewBox.js
*
*   copyright 2002, Kevin Lindsey
*
*****/

ViewBox.VERSION = "1.0";


/*****
*
*   constructor
*
*****/
function ViewBox(svgNode) {
    if ( arguments.length &gt; 0 ) {
        this.init(svgNode);
    }
}

/*****
*
*   init
*
*****/
ViewBox.prototype.init = function(svgNode) {
    var viewBox = svgNode.getAttributeNS(null, "viewBox");
    var preserveAspectRatio = svgNode.getAttributeNS(null, "preserveAspectRatio");
    
    if ( viewBox != "" ) {
		var params = viewBox.split(/\s*,\s*|\s+/);

        this.x      = parseFloat( params[0] );
        this.y      = parseFloat( params[1] );
    } else {
        // NOTE: Need to put an SVGResize event handler on the svgNode to keep
        // these values in sync with the window size or should add additional
        // logic (probably a flag) to getTM() so it will know to use the window
        // dimensions instead of this object's width and height properties
        this.x      = 0;
        this.y      = 0;
    }

    this.setPAR(preserveAspectRatio);
};


/*****
*
*   getTM
*
*****/
ViewBox.prototype.getTM = function() {
    var svgRoot      = svgDocument.documentElement;
    var matrix       = svgDocument.documentElement.createSVGMatrix();
    var windowWidth  = svgRoot.getAttributeNS(null, "width");
    var windowHeight = svgRoot.getAttributeNS(null, "height");

    var innerWidth;
    if(window.innerWidth){
      innerWidth = window.innerWidth;
    }
    else if(svgDocument.documentElement.width){
      innerWidth = svgDocument.documentElement.width.baseVal.value;
    }

    var innerHeight;
    if(window.innerHeight){
      innerHeight = window.innerHeight;
    }
    else if(svgDocument.documentElement.height){
      innerHeight = svgDocument.documentElement.height.baseVal.value;
    }

    windowWidth  = ( windowWidth  != "" ) ? parseFloat(windowWidth)  : innerWidth;
    windowHeight = ( windowHeight != "" ) ? parseFloat(windowHeight) : innerHeight;

    var x_ratio = innerWidth  / windowWidth;
    var y_ratio = innerHeight / windowHeight;

    matrix = matrix.translate(this.x, this.y);
    if ( this.alignX == "none" ) {
        matrix = matrix.scaleNonUniform( x_ratio, y_ratio );
    } else {
        if ( x_ratio &lt; y_ratio &amp;&amp; this.meetOrSlice == "meet" ||
             x_ratio &gt; y_ratio &amp;&amp; this.meetOrSlice == "slice"   )
        {
            var x_trans = 0;
            var x_diff  = windowWidth*y_ratio - this.width;

            if ( this.alignX == "Mid" )
                x_trans = -x_diff/2;
            else if ( this.alignX == "Max" )
                x_trans = -x_diff;
            
            matrix = matrix.translate(x_trans, 0);
            matrix = matrix.scale( y_ratio );
        }
        else if ( x_ratio &gt; y_ratio &amp;&amp; this.meetOrSlice == "meet" ||
                  x_ratio &lt; y_ratio &amp;&amp; this.meetOrSlice == "slice"   )
        {
            var y_trans = 0;
            var y_diff  = windowHeight*x_ratio - this.height;

            if ( this.alignY == "Mid" )
                y_trans = -y_diff/2;
            else if ( this.alignY == "Max" )
                y_trans = -y_diff;
            
            matrix = matrix.translate(0, y_trans);
            matrix = matrix.scale( x_ratio );
        }
        else
        {
            // x_ratio == y_ratio so, there is no need to translate
            // We can scale by either value
            matrix = matrix.scale( x_ratio );
        }
    }

    return matrix;
}


/*****
*
*   get/set methods
*
*****/

/*****
*
*   setPAR
*
*****/
ViewBox.prototype.setPAR = function(PAR) {
    // NOTE: This function needs to use default values when encountering
    // unrecognized values
    if ( PAR ) {
        var params = PAR.split(/\s+/);
        var align  = params[0];

        if ( align == "none" ) {
            this.alignX = "none";
            this.alignY = "none";
        } else {
            this.alignX = align.substring(1,4);
            this.alignY = align.substring(5,9);
        }

        if ( params.length == 2 ) {
            this.meetOrSlice = params[1];
        } else {
            this.meetOrSlice = "meet";
        }
    } else {
        this.align  = "xMidYMid";
        this.alignX = "Mid";
        this.alignY = "Mid";
        this.meetOrSlice = "meet";
    }
};
		]]&gt;
		</xsl:text>
		</script>

		<script>
			<xsl:text disable-output-escaping="yes">&lt;![CDATA[
/***********************************************
Scroller
Handles scrolling
************************************************/
var SCROLLBAR_WIDTH = 15;
var SCROLLBAR_MIN_LENGTH = 5;
var SCROLL_DELTA = 20;
var PADDING = 10;

function Scroller(GlobalName, Target, WIDTH, HEIGHT, ContainerID){
 this.GlobalName = GlobalName;
 this.Target = Target;
 this.TargetWidth = WIDTH;
 this.TargetHeight = HEIGHT;
 this.FocusCursor = false;
 // Generate Scrollbars

 // VERTICAL SCROLLBAR
 this.vScroll = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'g');
 this.vScroll.setAttribute('transform', 'translate(' + (this.TargetWidth - SCROLLBAR_WIDTH) + ', 0)');
 this.vScroll.setAttribute('id', 'vScroll');
 this.vScroll.setAttribute('display', 'none');
 
 this.UpBtn = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'g');
 this.UpBtnBk = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'rect');
 this.UpBtnBk.setAttribute('stroke', 'none');
 this.UpBtnBk.setAttribute('fill', '#444');
 this.UpBtnBk.setAttribute('width', SCROLLBAR_WIDTH);
 this.UpBtnBk.setAttribute('y', 0.5);
 this.UpBtnBk.setAttribute('height', SCROLLBAR_WIDTH-1);
 this.UpBtn.appendChild(this.UpBtnBk);
 this.UpBtnTopLeft = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'path');
 this.UpBtnTopLeft.setAttribute('stroke', '#FFFFE3');
 this.UpBtnTopLeft.setAttribute('stroke-width', '1px');
 this.UpBtnTopLeft.setAttribute('fill', 'none');
 this.UpBtnTopLeft.setAttribute('d', "M 0 " + (SCROLLBAR_WIDTH-1) + " V 0.5 h " + SCROLLBAR_WIDTH);
 this.UpBtn.appendChild(this.UpBtnTopLeft);
 this.UpBtnBottomRight = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'path');
 this.UpBtnBottomRight.setAttribute('stroke', '#000');
 this.UpBtnBottomRight.setAttribute('stroke-width', '2px');
 this.UpBtnBottomRight.setAttribute('fill', 'none');
 this.UpBtnBottomRight.setAttribute('d', "M 0 " + (SCROLLBAR_WIDTH-1) + " h " + SCROLLBAR_WIDTH + " V 0.5");
 this.UpBtn.appendChild(this.UpBtnBottomRight);
 this.UpBtn.setAttribute('onmousedown', this.GlobalName+'.UpBtnMouseDown()');
 var UpArr = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'path');
 UpArr.setAttribute('stroke', '#764');
 UpArr.setAttribute('stroke-width', '0.75px');
 UpArr.setAttribute('fill', '#FFFFE3');
 UpArr.setAttribute('d', 'M ' + SCROLLBAR_WIDTH/2 + ' ' + SCROLLBAR_WIDTH/4 + ' l ' + (-SCROLLBAR_WIDTH/4) + ' ' + SCROLLBAR_WIDTH/2 +
  ' h ' +  SCROLLBAR_WIDTH/2 + ' z');
 this.UpBtn.appendChild(UpArr);
 
 this.DownBtn = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'g');
 this.DownBtn.setAttribute('transform', 'translate(0, ' + (this.TargetHeight - SCROLLBAR_WIDTH) + ')');
 this.DownBtnBk = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'rect');
 this.DownBtnBk.setAttribute('stroke', 'none');
 this.DownBtnBk.setAttribute('fill', '#444');
 this.DownBtnBk.setAttribute('width', SCROLLBAR_WIDTH);
 this.DownBtnBk.setAttribute('y', 0.5);
 this.DownBtnBk.setAttribute('height', SCROLLBAR_WIDTH-1);
 this.DownBtn.appendChild(this.DownBtnBk);
 this.DownBtnTopLeft = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'path');
 this.DownBtnTopLeft.setAttribute('stroke', '#FFFFE3');
 this.DownBtnTopLeft.setAttribute('stroke-width', '1px');
 this.DownBtnTopLeft.setAttribute('fill', 'none');
 this.DownBtnTopLeft.setAttribute('d', "M 0 " + (SCROLLBAR_WIDTH-1) + " V 0.5 h " + SCROLLBAR_WIDTH);
 this.DownBtn.appendChild(this.DownBtnTopLeft);
 this.DownBtnBottomRight = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'path');
 this.DownBtnBottomRight.setAttribute('stroke', '#000');
 this.DownBtnBottomRight.setAttribute('stroke-width', '2px');
 this.DownBtnBottomRight.setAttribute('fill', 'none');
 this.DownBtnBottomRight.setAttribute('d', "M 0 " + (SCROLLBAR_WIDTH-1) + " h " + SCROLLBAR_WIDTH + " V 0.5");
 this.DownBtn.appendChild(this.DownBtnBottomRight);
 this.DownBtn.setAttribute('onmousedown', this.GlobalName+'.DownBtnMouseDown()');
 var DownArr = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'path');
 DownArr.setAttribute('stroke', '#764');
 DownArr.setAttribute('stroke-width', '0.75px');
 DownArr.setAttribute('fill', '#FFFFE3');
 DownArr.setAttribute('d', 'M ' + SCROLLBAR_WIDTH/2 + ' ' + 3*SCROLLBAR_WIDTH/4 + ' l ' + (-SCROLLBAR_WIDTH/4) + ' ' + (-SCROLLBAR_WIDTH/2) +
  ' h ' +  SCROLLBAR_WIDTH/2 + ' z');
 this.DownBtn.appendChild(DownArr);

 this.vScrollB = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'g');
 this.vScrollB.setAttribute('transform', 'translate(0, ' + SCROLLBAR_WIDTH + ')');
 this.vScroll.appendChild(this.vScrollB);
 
 this.vScrollBk = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'rect');
 this.vScrollBk.setAttribute('id', 'vScrollBk');
 this.vScrollBk.setAttribute('stroke', '#333');
 this.vScrollBk.setAttribute('fill', '#333');
 this.vScrollBk.setAttribute('stroke-width', '1px');
 this.vScrollBk.setAttribute('width', SCROLLBAR_WIDTH);
 this.vScrollBk.setAttribute('height', this.TargetHeight - SCROLLBAR_WIDTH);
 this.vScrollBk.setAttribute('onclick', this.GlobalName+'.vScrollBkClick(evt)');
 this.vScrollB.appendChild(this.vScrollBk);

 this.vScrollBt = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'g');

 this.vScrollBtBk = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'rect');
 this.vScrollBtBk.setAttribute('stroke', 'none');
 this.vScrollBtBk.setAttribute('fill', '#444');
 this.vScrollBtBk.setAttribute('width', SCROLLBAR_WIDTH);
 this.vScrollBtBk.setAttribute('height', SCROLLBAR_MIN_LENGTH);
 
 this.vScrollBtTopLeft = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'path');
 this.vScrollBtTopLeft.setAttribute('stroke', '#FFFFE3');
 this.vScrollBtTopLeft.setAttribute('stroke-width', '1px');
 this.vScrollBtTopLeft.setAttribute('fill', 'none');
 this.vScrollBtTopLeft.setAttribute('d', "M 0 " + SCROLLBAR_MIN_LENGTH + " v " + (-SCROLLBAR_MIN_LENGTH) + " h " + SCROLLBAR_WIDTH);

 this.vScrollBtBottomRight = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'path');
 this.vScrollBtBottomRight.setAttribute('stroke', '#000');
 this.vScrollBtBottomRight.setAttribute('stroke-width', '2px');
 this.vScrollBtBottomRight.setAttribute('fill', 'none');
 this.vScrollBtBottomRight.setAttribute('d', "M 0 " + SCROLLBAR_MIN_LENGTH + " h " + SCROLLBAR_WIDTH + " v " + (-SCROLLBAR_MIN_LENGTH));

 this.vScrollBt.appendChild(this.vScrollBtBk);
 this.vScrollBt.appendChild(this.vScrollBtTopLeft);
 this.vScrollBt.appendChild(this.vScrollBtBottomRight);

 this.vScrollB.appendChild(this.vScrollBt);
 this.vScroll.appendChild(this.UpBtn);
 this.vScroll.appendChild(this.DownBtn);
 this.vScrollBt.setAttribute('onmousedown', this.GlobalName+'.vScrollBtMouseDown(evt)');
 
 // HORIZONTAL SCROLLBAR

 this.hScroll = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'g');
 this.hScroll.setAttribute('transform', 'translate(0, ' + (this.TargetHeight - SCROLLBAR_WIDTH) + ')');
 this.hScroll.setAttribute('id', 'hScroll');
 this.hScroll.setAttribute('display', 'none');
 
 this.LeftBtn = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'g');
 this.LeftBtnBk = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'rect');
 this.LeftBtnBk.setAttribute('stroke', 'none');
 this.LeftBtnBk.setAttribute('fill', '#444');
 this.LeftBtnBk.setAttribute('x', 0.5);
 this.LeftBtnBk.setAttribute('width', SCROLLBAR_WIDTH-1);
 this.LeftBtnBk.setAttribute('height', SCROLLBAR_WIDTH);
 this.LeftBtn.appendChild(this.LeftBtnBk);
 this.LeftBtnTopLeft = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'path');
 this.LeftBtnTopLeft.setAttribute('stroke', '#FFFFE3');
 this.LeftBtnTopLeft.setAttribute('stroke-width', '1px');
 this.LeftBtnTopLeft.setAttribute('fill', 'none');
 this.LeftBtnTopLeft.setAttribute('d', "M 0.5 " + SCROLLBAR_WIDTH + " V 0 h " + (SCROLLBAR_WIDTH-1));
 this.LeftBtn.appendChild(this.LeftBtnTopLeft);
 this.LeftBtnBottomRight = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'path');
 this.LeftBtnBottomRight.setAttribute('stroke', '#000');
 this.LeftBtnBottomRight.setAttribute('stroke-width', '2px');
 this.LeftBtnBottomRight.setAttribute('fill', 'none');
 this.LeftBtnBottomRight.setAttribute('d', "M 0.5 " + SCROLLBAR_WIDTH + " h " + (SCROLLBAR_WIDTH-1) + " V 0");
 this.LeftBtn.appendChild(this.LeftBtnBottomRight);
 this.LeftBtn.setAttribute('onmousedown', this.GlobalName+'.LeftBtnMouseDown()');
 var LeftArr = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'path');
 LeftArr.setAttribute('stroke', '#764');
 LeftArr.setAttribute('stroke-width', '0.75px');
 LeftArr.setAttribute('fill', '#FFFFE3');
 LeftArr.setAttribute('d', 'M ' + SCROLLBAR_WIDTH/4 + ' ' + SCROLLBAR_WIDTH/2 + ' l ' + SCROLLBAR_WIDTH/2 + ' ' + (-SCROLLBAR_WIDTH/4) +
  ' v ' +  SCROLLBAR_WIDTH/2 + ' z');
 this.LeftBtn.appendChild(LeftArr);

 this.RightBtn = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'g');
 this.RightBtn.setAttribute('transform', 'translate(' + (this.TargetWidth - SCROLLBAR_WIDTH) + ', 0)');
 this.RightBtnBk = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'rect');
 this.RightBtnBk.setAttribute('stroke', 'none');
 this.RightBtnBk.setAttribute('fill', '#444');
 this.RightBtnBk.setAttribute('x', 0.5);
 this.RightBtnBk.setAttribute('width', SCROLLBAR_WIDTH-1);
 this.RightBtnBk.setAttribute('height', SCROLLBAR_WIDTH);
 this.RightBtn.appendChild(this.RightBtnBk);
 this.RightBtnTopLeft = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'path');
 this.RightBtnTopLeft.setAttribute('stroke', '#FFFFE3');
 this.RightBtnTopLeft.setAttribute('stroke-width', '1px');
 this.RightBtnTopLeft.setAttribute('fill', 'none');
 this.RightBtnTopLeft.setAttribute('d', "M 0.5 " + SCROLLBAR_WIDTH + " V 0 h " + (SCROLLBAR_WIDTH-1));
 this.RightBtn.appendChild(this.RightBtnTopLeft);
 this.RightBtnBottomRight = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'path');
 this.RightBtnBottomRight.setAttribute('stroke', '#000');
 this.RightBtnBottomRight.setAttribute('stroke-width', '2px');
 this.RightBtnBottomRight.setAttribute('fill', 'none');
 this.RightBtnBottomRight.setAttribute('d', "M 0.5 " + SCROLLBAR_WIDTH + " h " + (SCROLLBAR_WIDTH-1) + " V 0");
 this.RightBtn.appendChild(this.RightBtnBottomRight);
 this.RightBtn.setAttribute('onmousedown', this.GlobalName+'.RightBtnMouseDown()');
 var RightArr = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'path');
 RightArr.setAttribute('stroke', '#764');
 RightArr.setAttribute('stroke-width', '0.75px');
 RightArr.setAttribute('fill', '#FFFFE3');
 RightArr.setAttribute('d', 'M ' + 3*SCROLLBAR_WIDTH/4 + ' ' + SCROLLBAR_WIDTH/2 + ' l ' + (-SCROLLBAR_WIDTH/2) + ' ' +(-SCROLLBAR_WIDTH/4) +
  ' v ' +  SCROLLBAR_WIDTH/2 + ' z');
 this.RightBtn.appendChild(RightArr);
 
 this.hScrollB = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'g');
 this.hScrollB.setAttribute('transform', 'translate(' + SCROLLBAR_WIDTH + ', 0)');
 this.hScroll.appendChild(this.hScrollB);
 
 this.hScrollBk = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'rect');
 this.hScrollBk.setAttribute('id', 'hScrollBk');
 this.hScrollBk.setAttribute('stroke', '#333');
 this.hScrollBk.setAttribute('fill', '#333');
 this.hScrollBk.setAttribute('stroke-width', '1px');
 this.hScrollBk.setAttribute('width', this.TargetWidth - SCROLLBAR_WIDTH);
 this.hScrollBk.setAttribute('height', SCROLLBAR_WIDTH);
 this.hScrollBk.setAttribute('onclick', this.GlobalName+'.hScrollBkClick(evt)');
 this.hScrollB.appendChild(this.hScrollBk);

 this.hScrollBt = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'g');
 
 this.hScrollBtBk = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'rect');
 this.hScrollBtBk.setAttribute('stroke', 'none');
 this.hScrollBtBk.setAttribute('fill', '#444');
 this.hScrollBtBk.setAttribute('width', SCROLLBAR_MIN_LENGTH);
 this.hScrollBtBk.setAttribute('height', SCROLLBAR_WIDTH);
 
 this.hScrollBtTopLeft = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'path');
 this.hScrollBtTopLeft.setAttribute('stroke', '#FFFFE3');
 this.hScrollBtTopLeft.setAttribute('stroke-width', '1px');
 this.hScrollBtTopLeft.setAttribute('fill', 'none');
 this.hScrollBtTopLeft.setAttribute('d', "M 0 " + SCROLLBAR_WIDTH + " v " + (-SCROLLBAR_WIDTH) + " h " + SCROLLBAR_MIN_LENGTH);

 this.hScrollBtBottomRight = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'path');
 this.hScrollBtBottomRight.setAttribute('stroke', '#000');
 this.hScrollBtBottomRight.setAttribute('stroke-width', '2px');
 this.hScrollBtBottomRight.setAttribute('fill', 'none');
 this.hScrollBtBottomRight.setAttribute('d', "M 0 " + SCROLLBAR_WIDTH + " h " + SCROLLBAR_MIN_LENGTH + " v " + (-SCROLLBAR_WIDTH));
 
 this.hScrollBt.appendChild(this.hScrollBtBk);
 this.hScrollBt.appendChild(this.hScrollBtTopLeft);
 this.hScrollBt.appendChild(this.hScrollBtBottomRight);

 this.hScrollB.appendChild(this.hScrollBt);
 this.hScroll.appendChild(this.LeftBtn);
 this.hScroll.appendChild(this.RightBtn);
 this.hScrollBt.setAttribute('onmousedown', this.GlobalName+'.hScrollBtMouseDown(evt)');

 this.MeetRect = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'rect');
 this.MeetRect.setAttribute('stroke', '#333');
 this.MeetRect.setAttribute('fill', '#333');
 this.MeetRect.setAttribute('stroke-width', '1px');
 this.MeetRect.setAttribute('width', SCROLLBAR_WIDTH);
 this.MeetRect.setAttribute('height', SCROLLBAR_WIDTH);
 this.MeetRect.setAttribute('x', this.TargetWidth-SCROLLBAR_WIDTH);
 this.MeetRect.setAttribute('y', this.TargetHeight-SCROLLBAR_WIDTH);
 this.MeetRect.setAttribute('display', 'none');

 this.hScroll.setAttribute('onclick', 'evt.stopPropagation()');
 this.vScroll.setAttribute('onclick', 'evt.stopPropagation()');
 this.workspace = svgDocument.getElementById(ContainerID);
 this.workspace.appendChild(this.hScroll);
 this.workspace.appendChild(this.vScroll);
 this.workspace.appendChild(this.MeetRect);
}

//----------------------------------------------------
//    The user clicks on the horizontal scroll background
//----------------------------------------------------
Scroller.prototype.hScrollBkClick = function(evt){
  var newx = ScreenToClient(this.hScrollBk, evt).x
  var btnx = Maximum(0, newx - parseFloat(this.hScrollBtBk.getAttribute('width')) / 2);
  btnx = Minimum(btnx, parseFloat(this.hScrollBk.getAttribute('width')) - parseFloat(this.hScrollBtBk.getAttribute('width')));
  this.hScrollBt.setAttribute('transform', 'translate(' + btnx + ', 0)');
  this.TranslateViewBoxX(btnx / parseFloat(this.hScrollBk.getAttribute('width')));
  evt.stopPropagation();
}

//----------------------------------------------------
//    The user clicks on the vertical scroll background
//----------------------------------------------------
Scroller.prototype.vScrollBkClick = function(evt){
  var newy = ScreenToClient(this.vScrollBk, evt).y
  var btny = Maximum(0, newy - parseFloat(this.vScrollBtBk.getAttribute('height')) / 2);
  btny = Minimum(btny, parseFloat(this.vScrollBk.getAttribute('height')) - parseFloat(this.vScrollBtBk.getAttribute('height')));
  this.vScrollBt.setAttribute('transform', 'translate(0, ' + btny + ')');
  this.TranslateViewBoxY(btny / parseFloat(this.vScrollBk.getAttribute('height')));
  evt.stopPropagation();
}

//----------------------------------------------------
//    The user presses the mouse button on the horizontal scroll button
//----------------------------------------------------
Scroller.prototype.hScrollBtMouseDown = function(evt){
  this.clickX = ScreenToClient(this.hScrollBt, evt).x;
  window.Dragging = this;
  this.scrolling = 'h';
  evt.stopPropagation();
}

//----------------------------------------------------
//    The user presses the mouse button on the vertical scroll button
//----------------------------------------------------
Scroller.prototype.vScrollBtMouseDown = function(evt){
  this.clickY = ScreenToClient(this.vScrollBt, evt).y;
  window.Dragging = this;
  this.scrolling = 'v';
  evt.stopPropagation();
}

//----------------------------------------------------
//    Mouse dragging
//----------------------------------------------------
Scroller.prototype.MouseMove = function (evt){
  if(this.scrolling == 'h'){
    var newx = ScreenToClient(this.hScrollBk, evt).x;
    var btnx = Maximum(0, newx - this.clickX);
    btnx = Minimum(btnx, parseFloat(this.hScrollBk.getAttribute('width')) - parseFloat(this.hScrollBtBk.getAttribute('width')));
    this.hScrollBt.setAttribute('transform', 'translate(' + btnx + ', 0)');
    this.TranslateViewBoxX(btnx / parseFloat(this.hScrollBk.getAttribute('width')));
  }
  else if(this.scrolling == 'v'){
    var newy = ScreenToClient(this.vScrollBk, evt).y;
    var btny = Maximum(0, newy - this.clickY);
    btny = Minimum(btny, parseFloat(this.vScrollBk.getAttribute('height')) - parseFloat(this.vScrollBtBk.getAttribute('height')));
    this.vScrollBt.setAttribute('transform', 'translate(0, ' + btny + ')');
    this.TranslateViewBoxY(btny / parseFloat(this.vScrollBk.getAttribute('height')));
  }
  evt.stopPropagation();
}

//----------------------------------------------------
//    The user presses the scroll left arrow
//----------------------------------------------------
Scroller.prototype.LeftBtnMouseDown = function(){
  var transform = this.hScrollBt.getAttribute('transform');
  var btnx = parseFloat(transform.substring(transform.indexOf('(')+1, transform.indexOf(',')));
  var newx = Maximum(0, btnx - SCROLL_DELTA);
  this.hScrollBt.setAttribute('transform', 'translate(' + newx + ', 0)');
  this.TranslateViewBoxX(newx / parseFloat(this.hScrollBk.getAttribute('width')));
}

//----------------------------------------------------
//    The user presses the scroll right arrow
//----------------------------------------------------
Scroller.prototype.RightBtnMouseDown = function(){
  var transform = this.hScrollBt.getAttribute('transform');
  var btnx = parseFloat(transform.substring(transform.indexOf('(')+1, transform.indexOf(',')));
  var newx = Minimum(btnx + SCROLL_DELTA,
      parseFloat(this.hScrollBk.getAttribute('width')) - parseFloat(this.hScrollBtBk.getAttribute('width')));
  this.hScrollBt.setAttribute('transform', 'translate(' + newx + ', 0)');
  this.TranslateViewBoxX(newx / parseFloat(this.hScrollBk.getAttribute('width')));
}

//----------------------------------------------------
//    The user presses the scroll up arrow
//----------------------------------------------------
Scroller.prototype.UpBtnMouseDown = function(){
  var transform = this.vScrollBt.getAttribute('transform');
  var btny = parseFloat(transform.substring(transform.indexOf(' ')+1, transform.indexOf(')')));
  var newy = Maximum(0, btny - SCROLL_DELTA);
  this.vScrollBt.setAttribute('transform', 'translate(0, ' + newy + ')');
  this.TranslateViewBoxY(newy / parseFloat(this.vScrollBk.getAttribute('height')));
}

//----------------------------------------------------
//    The user presses the scroll down arrow
//----------------------------------------------------
Scroller.prototype.DownBtnMouseDown = function(){
  var transform = this.vScrollBt.getAttribute('transform');
  var btny = parseFloat(transform.substring(transform.indexOf(' ')+1, transform.indexOf(')')));
  var newy = Minimum(btny + SCROLL_DELTA,
      parseFloat(this.vScrollBk.getAttribute('height')) - parseFloat(this.vScrollBtBk.getAttribute('height')));
  this.vScrollBt.setAttribute('transform', 'translate(0, ' + newy +')');
  this.TranslateViewBoxY(newy / parseFloat(this.vScrollBk.getAttribute('height')));
}

//----------------------------------------------------
//    Update scrollbar
//----------------------------------------------------
Scroller.prototype.UpdateScrollbars = function (workareaBBox, viewBox){
  this.PutInside(viewBox, workareaBBox);
  if(((workareaBBox.width &gt; (viewBox.width - SCROLLBAR_WIDTH)) &amp;&amp; (workareaBBox.height &gt; (viewBox.height - SCROLLBAR_WIDTH))) ||
     (workareaBBox.width &gt; viewBox.width)){
   if (workareaBBox.height &gt; viewBox.height - SCROLLBAR_WIDTH){
     var bkwidth = viewBox.width - 3*SCROLLBAR_WIDTH
     this.hScrollBk.setAttribute('width', bkwidth);
     this.RightBtn.setAttribute('transform', 'translate(' + (this.TargetWidth - 2*SCROLLBAR_WIDTH) + ', 0)');
     var hScrollWidth = Maximum(SCROLLBAR_MIN_LENGTH,
        ((viewBox.width-SCROLLBAR_WIDTH) * bkwidth / workareaBBox.width));
     var hScrollX = (viewBox.x * bkwidth / workareaBBox.width);
     this.hScrollBtBk.setAttribute('width', hScrollWidth);
     this.hScrollBtTopLeft.setAttribute('d', "M 0 " + SCROLLBAR_WIDTH + " v " + (-SCROLLBAR_WIDTH) + " h " + hScrollWidth);
     this.hScrollBtBottomRight.setAttribute('d', "M 0 " + SCROLLBAR_WIDTH + " h " + hScrollWidth + " v " + (-SCROLLBAR_WIDTH));
     this.hScrollBt.setAttribute('transform', 'translate(' + hScrollX + ', 0)');
     this.hScroll.setAttribute('display', 'inline');

     var bkheight = viewBox.height - 3*SCROLLBAR_WIDTH;
     this.vScrollBk.setAttribute('height', bkheight);
     this.DownBtn.setAttribute('transform', 'translate(0, ' + (this.TargetHeight - 2*SCROLLBAR_WIDTH) + ')');
     var vScrollHeight = Maximum(SCROLLBAR_MIN_LENGTH,
        ((viewBox.height - SCROLLBAR_WIDTH) * bkheight / workareaBBox.height));
     var vScrollY = (viewBox.y * bkheight / workareaBBox.height);
     this.vScrollBtBk.setAttribute('height', vScrollHeight);
     this.vScrollBtTopLeft.setAttribute('d', "M 0 " + vScrollHeight + " v " + (-vScrollHeight) + " h " + SCROLLBAR_WIDTH);
     this.vScrollBtBottomRight.setAttribute('d', "M 0 " + vScrollHeight + " h " + SCROLLBAR_WIDTH + " v " + (-vScrollHeight));
     this.vScrollBt.setAttribute('transform', 'translate(0, ' + vScrollY + ')');
     this.vScroll.setAttribute('display', 'inline');

      this.MeetRect.setAttribute('display', 'inline');
      return;
   }
   else{
     var bkwidth = viewBox.width - 2* SCROLLBAR_WIDTH;
     this.hScrollBk.setAttribute('width', bkwidth);
     this.RightBtn.setAttribute('transform', 'translate(' + (this.TargetWidth - SCROLLBAR_WIDTH) + ', 0)');
     var hScrollWidth = Maximum(SCROLLBAR_MIN_LENGTH,
        (viewBox.width * bkwidth / workareaBBox.width));
     var hScrollX = (viewBox.x * bkwidth / workareaBBox.width);
     this.hScrollBtBk.setAttribute('width', hScrollWidth);
     this.hScrollBtTopLeft.setAttribute('d', "M 0 " + SCROLLBAR_WIDTH + " v " + (-SCROLLBAR_WIDTH) + " h " + hScrollWidth);
     this.hScrollBtBottomRight.setAttribute('d', "M 0 " + SCROLLBAR_WIDTH + " h " + hScrollWidth + " v " + (-SCROLLBAR_WIDTH));
     this.hScrollBt.setAttribute('transform', 'translate(' + hScrollX + ', 0)');
     this.hScroll.setAttribute('display', 'inline');
   }
  }
  else{
    this.hScroll.setAttribute('display', 'none');
  }
  if (workareaBBox.height &gt; viewBox.height){
    var bkheight = viewBox.height - 2*SCROLLBAR_WIDTH;
    this.DownBtn.setAttribute('transform', 'translate(0, ' + (this.TargetHeight - SCROLLBAR_WIDTH) + ')');
    this.vScrollBk.setAttribute('height', bkheight);
    var vScrollHeight = Maximum(SCROLLBAR_MIN_LENGTH,
       (viewBox.height * bkheight / workareaBBox.height));
    var vScrollY = (viewBox.y * bkheight / workareaBBox.height);
    this.vScrollBtBk.setAttribute('height', vScrollHeight);
    this.vScrollBtTopLeft.setAttribute('d', "M 0 " + vScrollHeight + " v " + (-vScrollHeight) + " h " + SCROLLBAR_WIDTH);
    this.vScrollBtBottomRight.setAttribute('d', "M 0 " + vScrollHeight + " h " + SCROLLBAR_WIDTH + " v " + (-vScrollHeight));
    this.vScrollBt.setAttribute('transform', 'translate(0, ' + vScrollY + ')');
    this.vScroll.setAttribute('display', 'inline');
  }
  else{
    this.vScroll.setAttribute('display', 'none');
  }
  this.MeetRect.setAttribute('display', 'none');
}

//------------------------------------
//    Mouse Up
//----------------------------------------------------
Scroller.prototype.MouseUp = function (evt){
  window.Dragging = null;
  evt.stopPropagation();
}

//----------------------------------------------------
//    Translate the viewbox on the X axis
//----------------------------------------------------
Scroller.prototype.TranslateViewBoxX = function(newX){
  var viewBox = this.TaiewBox = this.Target.getAttribute('viewBox');
  var viewBoxParams = viewBox.split(/\s*,\s*|\s+/);
  var workareaHeight = this.Target.getBBox().height + PADDING;
  var workareaWidth = this.Target.getBBox().width + PADDING;
  var newX = newX * workareaWidth;

  this.Target.setAttribute('viewBox', newX + ' ' + viewBoxParams[1] + ' ' + viewBoxParams[2] + ' ' + viewBoxParams[3]);
}

//----------------------------------------------------
//    Translate the viewbox on the Y axis
//----------------------------------------------------
Scroller.prototype.TranslateViewBoxY = function(newY){
  var viewBox = this.Target.getAttribute('viewBox');
  var viewBoxParams = viewBox.split(/\s*,\s*|\s+/);
  var workareaHeight = this.Target.getBBox().height + PADDING;
  var workareaWidth = this.Target.getBBox().width + PADDING;
  var newY = newY * workareaHeight;

  this.Target.setAttribute('viewBox', viewBoxParams[0] + ' ' + newY + ' ' + viewBoxParams[2] + ' ' + viewBoxParams[3]);
}

//----------------------------------------------------
//    Translate the viewbox so that the viewbox doesn't get out of the bbox
//----------------------------------------------------
Scroller.prototype.PutInside = function(viewRect, bbox){
  var Modified = false;
  if(((viewRect.x + viewRect.width) &gt; bbox.width) &amp;&amp; (viewRect.x != 0)){
    if (bbox.height &gt; viewRect.height){
      viewRect.x = Maximum(0, bbox.width - viewRect.width + SCROLLBAR_WIDTH);
    }
    else{
      viewRect.x = Maximum(0, bbox.width - viewRect.width);
    }
    Modified = true;
  }
  if(((viewRect.y + viewRect.height) &gt; bbox.height) &amp;&amp; (viewRect.y != 0)){
    if (bbox.width &gt; viewRect.width){
      viewRect.y = Maximum(0, bbox.height - viewRect.height + SCROLLBAR_WIDTH);
    }
    else{
      viewRect.y = Maximum(0, bbox.height - viewRect.height);
    }
    Modified = true;
  }
  if(Modified == true){
    this.Target.setAttribute('viewBox', viewRect.x + ' ' + viewRect.y + ' ' + viewRect.width + ' ' + viewRect.height);
  }
}

Scroller.prototype.ResizeScrollbars = function(Height){
 this.TargetHeight = Height;

 this.DownBtn.setAttribute('transform', 'translate(0, ' + (this.TargetHeight - SCROLLBAR_WIDTH) + ')');
 this.hScroll.setAttribute('transform', 'translate(0, ' + (this.TargetHeight - SCROLLBAR_WIDTH) + ')');
 this.MeetRect.setAttribute('y', this.TargetHeight-SCROLLBAR_WIDTH);
}

if(window.innerHeight){
  TreeScroller = new Scroller('TreeScroller', svgDocument.getElementById('DiagramTreeSVG'), 200, window.innerHeight, 'DiagramTree');
}
else if(svgDocument.documentElement.height){
  TreeScroller = new Scroller('TreeScroller', svgDocument.getElementById('DiagramTreeSVG'), 200,
    svgDocument.documentElement.height.baseVal.value, 'DiagramTree');
}
else{
}
		]]&gt;
		</xsl:text>
		</script>
		<!-- Main Tree group -->
		<g id="DiagramTree">
			<!-- Background -->
			<rect
				width="200"
				height="100%"
				fill="black"
				stroke="#444"
				stroke-width="2" />
			<svg
				id="DiagramTreeSVG"
				width="200"
				font-weight="bold"
				font-size="13"
				fill="#FFFFE3"
				onload="init();"
				viewBox="0 0 200 500">
				<!-- Origin, used for correct scrolling -->
				<rect
					width="0.1px"
					height="0.1px"
					style="opacity: 0; fill: #000" />
				<!-- Tree root -->
				<a>
					<text stroke="none">
						<tspan
							id="TreeRootS"
							x="10"
							dy="20"
							onclick="show('TreeRoot')">+</tspan>
						<tspan
							x="20"
							dy="0"
							onclick="treeNodeClick('TreeRoot')">
							<xsl:value-of select="//UML:Model/@name" />
						</tspan>
						<tspan
							id="TreeRoot"
							display="none">

							<!-- Contained Class diagrams -->
							<xsl:if
								test="/XMI/XMI.content/UML:Diagram[UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'ClassDiagram']">
								<tspan
									id="ClassDiagramsS"
									x="20"
									dy="20"
									onclick="show('ClassDiagrams')">+</tspan>
								<tspan
									x="30"
									dy="0"
									onclick="treeNodeClick('ClassDiagrams')">Class Diagrams</tspan>
								<tspan
									id="ClassDiagrams"
									display="none">
									<xsl:for-each
										select="/XMI/XMI.content/UML:Diagram[UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'ClassDiagram']">
										<tspan
											id="{@xmi.id}T"
											x="40"
											dy="20"
											onclick="showDiagram('{@xmi.id}')"
											onmouseover="document.getElementById('{@xmi.id}T').setAttribute('fill', '#FFF')"
											onmouseout="document.getElementById('{@xmi.id}T').setAttribute('fill', '#FFFFE3')">
											<xsl:value-of select="@name" />
										</tspan>
									</xsl:for-each>
								</tspan>
							</xsl:if>

							<!-- Contained UseCase diagrams -->
							<xsl:if
								test="/XMI/XMI.content/UML:Diagram[UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'UseCaseDiagram']">
								<tspan
									id="UseCaseDiagramsS"
									x="20"
									dy="20"
									onclick="show('UseCaseDiagrams')">+</tspan>
								<tspan
									x="30"
									dy="0"
									onclick="treeNodeClick('UseCaseDiagrams')">UseCase Diagrams</tspan>
								<tspan
									id="UseCaseDiagrams"
									display="none">
									<xsl:for-each
										select="/XMI/XMI.content/UML:Diagram[UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'UseCaseDiagram']">
										<tspan
											id="{@xmi.id}T"
											x="40"
											dy="20"
											onclick="showDiagram('{@xmi.id}')"
											onmouseover="document.getElementById('{@xmi.id}T').setAttribute('fill', '#FFF')"
											onmouseout="document.getElementById('{@xmi.id}T').setAttribute('fill', '#FFFFE3')">
											<xsl:value-of select="@name" />
										</tspan>
									</xsl:for-each>
								</tspan>
							</xsl:if>

							<!-- Contained State diagrams -->
							<xsl:if
								test="/XMI/XMI.content/UML:Diagram[UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'StateDiagram']">
								<tspan
									id="StateDiagramsS"
									x="20"
									dy="20"
									onclick="show('StateDiagrams')">+</tspan>
								<tspan
									x="30"
									dy="0"
									onclick="treeNodeClick('StateDiagrams')">State Diagrams</tspan>
								<tspan
									id="StateDiagrams"
									display="none">
									<xsl:for-each
										select="/XMI/XMI.content/UML:Diagram[UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'StateDiagram']">
										<tspan
											id="{@xmi.id}T"
											x="40"
											dy="20"
											onclick="showDiagram('{@xmi.id}')"
											onmouseover="document.getElementById('{@xmi.id}T').setAttribute('fill', '#FFF')"
											onmouseout="document.getElementById('{@xmi.id}T').setAttribute('fill', '#FFFFE3')">
											<xsl:value-of select="@name" />
										</tspan>
									</xsl:for-each>
								</tspan>
							</xsl:if>

							<!-- Contained Activity diagrams -->
							<xsl:if
								test="/XMI/XMI.content/UML:Diagram[UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'ActivityDiagram']">
								<tspan
									id="ActivityDiagramsS"
									x="20"
									dy="20"
									onclick="show('ActivityDiagrams')">+</tspan>
								<tspan
									x="30"
									dy="0"
									onclick="treeNodeClick('ActivityDiagrams')">Activity Diagrams</tspan>
								<tspan
									id="ActivityDiagrams"
									display="none">
									<xsl:for-each
										select="/XMI/XMI.content/UML:Diagram[UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'ActivityDiagram']">
										<tspan
											id="{@xmi.id}T"
											x="40"
											dy="20"
											onclick="showDiagram('{@xmi.id}')"
											onmouseover="document.getElementById('{@xmi.id}T').setAttribute('fill', '#FFF')"
											onmouseout="document.getElementById('{@xmi.id}T').setAttribute('fill', '#FFFFE3')">
											<xsl:value-of select="@name" />
										</tspan>
									</xsl:for-each>
								</tspan>
							</xsl:if>

							<!-- Contained Collaboration diagrams -->
							<xsl:if
								test="/XMI/XMI.content/UML:Diagram[UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'CollaborationDiagram']">
								<tspan
									id="CollaborationDiagramsS"
									x="20"
									dy="20"
									onclick="show('CollaborationDiagrams')">+</tspan>
								<tspan
									x="30"
									dy="0"
									onclick="treeNodeClick('CollaborationDiagrams')">Collaboration Diagrams</tspan>
								<tspan
									id="CollaborationDiagrams"
									display="none">
									<xsl:for-each
										select="/XMI/XMI.content/UML:Diagram[UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'CollaborationDiagram']">
										<tspan
											id="{@xmi.id}T"
											x="40"
											dy="20"
											onclick="showDiagram('{@xmi.id}')"
											onmouseover="document.getElementById('{@xmi.id}T').setAttribute('fill', '#FFF')"
											onmouseout="document.getElementById('{@xmi.id}T').setAttribute('fill', '#FFFFE3')">
											<xsl:value-of select="@name" />
										</tspan>
									</xsl:for-each>
								</tspan>
							</xsl:if>

							<!-- Contained Sequence diagrams -->
							<xsl:if
								test="/XMI/XMI.content/UML:Diagram[UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'SequenceDiagram']">
								<tspan
									id="SequenceDiagramsS"
									x="20"
									dy="20"
									onclick="show('SequenceDiagrams')">+</tspan>
								<tspan
									x="30"
									dy="0"
									onclick="treeNodeClick('SequenceDiagrams')">Sequence Diagrams</tspan>
								<tspan
									id="SequenceDiagrams"
									display="none">
									<xsl:for-each
										select="/XMI/XMI.content/UML:Diagram[UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'SequenceDiagram']">
										<tspan
											id="{@xmi.id}T"
											x="40"
											dy="20"
											onclick="showDiagram('{@xmi.id}')"
											onmouseover="document.getElementById('{@xmi.id}T').setAttribute('fill', '#FFF')"
											onmouseout="document.getElementById('{@xmi.id}T').setAttribute('fill', '#FFFFE3')">
											<xsl:value-of select="@name" />
										</tspan>
									</xsl:for-each>
								</tspan>
							</xsl:if>

							<!-- Contained Deployment diagrams -->
							<xsl:if
								test="/XMI/XMI.content/UML:Diagram[UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'DeploymentDiagram']">
								<tspan
									id="DeploymentDiagramsS"
									x="20"
									dy="20"
									onclick="show('DeploymentDiagrams')">+</tspan>
								<tspan
									x="30"
									dy="0"
									onclick="treeNodeClick('DeploymentDiagrams')">Deployment Diagrams</tspan>
								<tspan
									id="DeploymentDiagrams"
									display="none">
									<xsl:for-each
										select="/XMI/XMI.content/UML:Diagram[UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'DeploymentDiagram']">
										<tspan
											id="{@xmi.id}T"
											x="40"
											dy="20"
											onclick="showDiagram('{@xmi.id}')"
											onmouseover="document.getElementById('{@xmi.id}T').setAttribute('fill', '#FFF')"
											onmouseout="document.getElementById('{@xmi.id}T').setAttribute('fill', '#FFFFE3')">
											<xsl:value-of select="@name" />
										</tspan>
									</xsl:for-each>
								</tspan>
							</xsl:if>
						</tspan>
					</text>
				</a>
			</svg>
		</g>
	</xsl:template>

	<!--********************************************************************** -->
	<!-- Template: Main.xsl Main uml2svg template -->

	<xsl:param name="SelectedDiagram" />
	<xsl:param name="SelectedDiagramId" />
	<xsl:param name="SelectedDiagramNumber" />

	<xsl:key
		name="xmi.id"
		match="UML:*|UML2:*"
		use="@xmi.id" />

	<xsl:template match="text()" />

	<xsl:template match="/XMI">
		<xsl:variable name="ArrowsNeeded">
			<xsl:if test=".//*[@typeInfo = 'Arrow']">
				true
			</xsl:if>
		</xsl:variable>

		<svg
			font-family="sans-serif"
			font-size="11px"
			stroke="black"
			fill-rule="nonzero"
			onmousemove="if(window.Dragging) window.Dragging.MouseMove(evt);"
			onmouseup="if(window.Dragging) window.Dragging.MouseUp(evt);">
			<xsl:if test="$ArrowsNeeded='true'">
				<xsl:attribute name="onload">OrientArrows()</xsl:attribute>
			</xsl:if>

			<!-- A Diagram Name, Number or Id, if only one diagram is to be processed -->
			<xsl:choose>
				<xsl:when test="$SelectedDiagram">
					<!-- If the user specified a certain diagram by name, look for that diagram 
						and process it -->
					<xsl:for-each select="//UML:Diagram[@name=$SelectedDiagram]">
						<xsl:call-template name="DiagramSelector" />
					</xsl:for-each>
				</xsl:when>

				<xsl:when test="$SelectedDiagramNumber">
					<!-- If the user specified a certain diagram by number, look for that diagram 
						and process it -->
					<xsl:for-each select="//UML:Diagram[position() = $SelectedDiagramNumber]">
						<xsl:call-template name="DiagramSelector" />
					</xsl:for-each>
				</xsl:when>

				<xsl:when test="$SelectedDiagramId">
					<!-- If the user specified a certain diagram by Id, look for that diagram and 
						process it -->
					<xsl:for-each select="key('xmi.id', $SelectedDiagramId)">
						<xsl:call-template name="DiagramSelector" />
					</xsl:for-each>
				</xsl:when>

				<xsl:when test="count(/XMI/XMI.content/UML:Diagram) = 1">
					<!-- If there is only one diagram -->
					<xsl:for-each select="/XMI/XMI.content/UML:Diagram">
						<xsl:call-template name="DiagramSelector" />
					</xsl:for-each>
				</xsl:when>

				<xsl:otherwise>
					<!-- If no diagram was specified, process all the diagrams -->
					<xsl:call-template name="MakeTreeScript" />
					<xsl:for-each select="/XMI/XMI.content/UML:Diagram">
						<svg>
							<xsl:call-template name="DiagramSelector">
								<xsl:with-param
									name="multipleDiagrams"
									select="'true'" />
							</xsl:call-template>
						</svg>
					</xsl:for-each>
					<xsl:call-template name="MakeTree" />
				</xsl:otherwise>
			</xsl:choose>

			<xsl:if test="$ArrowsNeeded='true'">
				<xsl:call-template name="MakeArrowScript" />
			</xsl:if>
		</svg>
	</xsl:template>

	<xsl:template name="DiagramSelector">
		<xsl:param
			name="multipleDiagrams"
			select="'false'" />

		<xsl:attribute name="id"><xsl:value-of select="@xmi.id" /></xsl:attribute>
		<xsl:apply-templates
			select="."
			mode="FontStyle" />
		<xsl:apply-templates
			select="."
			mode="StrokeStyle" />
		<xsl:if test="$multipleDiagrams = 'true'">
			<xsl:attribute name="display">none</xsl:attribute>
			<xsl:attribute name="x"><xsl:value-of select="$TreeWidth" /></xsl:attribute>
		</xsl:if>
		<xsl:call-template name="DiagramSize" />

		<xsl:apply-templates select="." />

	</xsl:template>
</xsl:stylesheet>