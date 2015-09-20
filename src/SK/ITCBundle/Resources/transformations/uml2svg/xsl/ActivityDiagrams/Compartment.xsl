<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: Compartment.xsl -->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:import href="../ActivityDiagrams/CallAction.xsl" />
	<xsl:import href="../ActivityDiagrams/Pin.xsl" />
	<xsl:import href="../ActivityDiagrams/ActivityEdge.xsl" />
	<xsl:import href="../ActivityDiagrams/ExceptionHandler.xsl" />
	<xsl:import href="../ActivityDiagrams/SendSignalAction.xsl" />
	<xsl:import href="../ActivityDiagrams/AcceptEventAction.xsl" />
	<xsl:import href="../ActivityDiagrams/ActivityPartition.xsl" />
	<xsl:import href="../ActivityDiagrams/ConditionalNode.xsl" />
	<xsl:import href="../Common/Styling.xsl" />
	<xsl:import href="../Common/Text.xsl" />
	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

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
</xsl:stylesheet>
