<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: ObjectSequence.xsl Displays objects from sequence diagrams -->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:import href="../Common/Styling.xsl" />
	<xsl:import href="../CollaborationDiagrams/Object.xsl" />
	<xsl:import href="../UseCaseDiagrams/ActorStickman.xsl" />
	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

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
</xsl:stylesheet>
