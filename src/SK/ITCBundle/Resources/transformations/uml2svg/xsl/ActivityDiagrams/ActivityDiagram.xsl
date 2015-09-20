<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: ActivityDiagram.xsl Processes Activity Diagrams -->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:import href="../ActivityDiagrams/ObjectFlowState.xsl" />
	<xsl:import href="../ActivityDiagrams/ActionState.xsl" />
	<xsl:import href="../ActivityDiagrams/CallAction.xsl" />
	<xsl:import href="../ActivityDiagrams/Pin.xsl" />
	<xsl:import href="../ActivityDiagrams/ActivityEdge.xsl" />
	<xsl:import href="../ActivityDiagrams/ExceptionHandler.xsl" />
	<xsl:import href="../ActivityDiagrams/SendSignalAction.xsl" />
	<xsl:import href="../ActivityDiagrams/AcceptEventAction.xsl" />
	<xsl:import href="../ActivityDiagrams/ConditionalNode.xsl" />
	<xsl:import href="../ActivityDiagrams/InterruptableActivityRegion.xsl" />
	<xsl:import href="../ActivityDiagrams/ActivityPartition.xsl" />
	<xsl:import href="../StateDiagrams/PseudoState.xsl" />
	<xsl:import href="../StateDiagrams/FinalState.xsl" />
	<xsl:import href="../Common/Comment.xsl" />
	<xsl:import href="../Common/Lines.xsl" />
	<xsl:import href="../Common/Ellipse.xsl" />
	<xsl:import href="../Common/Polyline.xsl" />
	<xsl:import href="../Common/FreeText.xsl" />
	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

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
</xsl:stylesheet>