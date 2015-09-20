<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: Main.xsl Main uml2svg template -->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML"
	xmlns:UML2="org.omg.xmi.namespace.UML2"
	exclude-result-prefixes="UML">
	<xsl:import href="Common/Globals.xsl" />
	<xsl:import href="ClassDiagrams/ClassDiagram.xsl" />
	<xsl:import href="UseCaseDiagrams/UseCaseDiagram.xsl" />
	<xsl:import href="StateDiagrams/StateDiagram.xsl" />
	<xsl:import href="ActivityDiagrams/ActivityDiagram.xsl" />
	<xsl:import href="CollaborationDiagrams/CollaborationDiagram.xsl" />
	<xsl:import href="SequenceDiagrams/SequenceDiagram.xsl" />
	<xsl:import href="DeploymentDiagrams/DeploymentDiagram.xsl" />
	<xsl:import href="System/DiagramSize.xsl" />
	<xsl:import href="System/MakeArrowScript.xsl" />
	<xsl:import href="System/MakeTreeScript.xsl" />
	<xsl:import href="System/MakeTree.xsl" />

	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

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
