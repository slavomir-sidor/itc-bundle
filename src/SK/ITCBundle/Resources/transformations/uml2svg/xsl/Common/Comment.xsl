<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: Comment.xsl Displays a (usually) yellow rectangle with the upper right 
	corner bent. -->
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
</xsl:stylesheet>
