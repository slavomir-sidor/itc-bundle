<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: StimuliArrows.xsl Displays Arrows for stimuli (in Collaboration diagrams) -->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:import href="../Common/Styling.xsl" />
	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

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
</xsl:stylesheet>
