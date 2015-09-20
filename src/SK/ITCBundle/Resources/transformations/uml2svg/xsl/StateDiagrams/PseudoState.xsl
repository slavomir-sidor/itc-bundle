<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:import href="../Common/Styling.xsl" />
	<xsl:import href="../Common/StereotypeCompartment.xsl" />
	<xsl:import href="../Common/Name.xsl" />

	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

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
</xsl:stylesheet>