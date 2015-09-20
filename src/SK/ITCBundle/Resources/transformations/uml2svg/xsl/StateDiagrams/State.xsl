<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: State.xsl - UML2 -->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:import href="../Common/Styling.xsl" />
	<xsl:import href="../Common/NameCompartment.xsl" />
	<xsl:import href="../Common/CompartmentSeparator.xsl" />
	<xsl:import href="../StateDiagrams/InternalTransitionCompartment.xsl" />
	<xsl:import href="../StateDiagrams/RegionCompartment.xsl" />
	<xsl:import href="../StateDiagrams/SubStates.xsl" />
	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

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
</xsl:stylesheet>
