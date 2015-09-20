<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: RegionCompartment.xsl Displays RegionCompartment -->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:import href="../Common/Styling.xsl" />
	<xsl:import href="../StateDiagrams/SimpleState.xsl" />
	<xsl:import href="../StateDiagrams/PseudoState.xsl" />
	<xsl:import href="../StateDiagrams/FinalState.xsl" />
	<xsl:import href="../StateDiagrams/SynchState.xsl" />
	<xsl:import href="../StateDiagrams/RegionSeparator.xsl" />
	<xsl:import href="../StateDiagrams/Region.xsl" />
	<xsl:import href="../Common/Lines.xsl" />
	<xsl:import href="../Common/Comment.xsl" />

	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

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
</xsl:stylesheet>
