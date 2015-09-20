<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: SubStates.xsl Processes Composite state substates -->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:import href="../Common/Styling.xsl" />
	<xsl:import href="../StateDiagrams/SimpleState.xsl" />
	<xsl:import href="../Common/Comment.xsl" />
	<xsl:import href="../Common/Lines.xsl" />
	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

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
</xsl:stylesheet>