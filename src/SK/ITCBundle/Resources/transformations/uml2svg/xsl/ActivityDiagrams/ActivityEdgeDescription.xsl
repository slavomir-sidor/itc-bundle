<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: ActivityEdgeDescription.xml - UML2 -->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:import href="../Common/Globals.xsl" />
	<xsl:import href="../Common/Styling.xsl" />
	<xsl:import href="../Common/Text.xsl" />

	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

	<!-- ActivityEdgeDescription -->
	<xsl:template name="ActivityEdgeDescription">
		<xsl:param
			name="ShowNulls"
			select="false()" />

		<xsl:variable
			name="SemanticID"
			select="../../UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- Main StateTransitionDescription group -->
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
				<xsl:text>ActivityEdgeDescription</xsl:text>
			</desc>

			<!-- TransitionDescription text -->
			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'AEGuardStart'">
						<!-- Activity edge guard start, '[' -->
						<xsl:if
							test="$ShowNulls or not(following-sibling::UML:GraphNode/UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'AENullGuard')">
							<xsl:call-template name="Text">
								<xsl:with-param
									name="String"
									select="$AEGuardStart" />
							</xsl:call-template>
						</xsl:if>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:OpaqueExpression">
						<xsl:variable
							name="OpaqueExpressionID"
							select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:OpaqueExpression/@xmi.idref" />
						<xsl:choose>
							<xsl:when test="key('xmi.id', $OpaqueExpressionID)/@name = ''">
								<xsl:call-template name="Text">
									<xsl:with-param name="String">
										<xsl:value-of select="key('xmi.id', $OpaqueExpressionID)/@body" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="Text">
									<xsl:with-param name="String">
										<xsl:value-of select="key('xmi.id', $OpaqueExpressionID)/@name" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'AEGuardEnd'">
						<!-- Activity edge guard end, ']' -->
						<xsl:if
							test="$ShowNulls or not(preceding-sibling::UML:GraphNode/UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'AENullGuard')">
							<xsl:call-template name="Text">
								<xsl:with-param
									name="String"
									select="$AEGuardEnd" />
							</xsl:call-template>
						</xsl:if>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'WeightStart'">
						<!-- Activity edge weight start, ']' -->
						<xsl:if
							test="$ShowNulls or not(following-sibling::UML:GraphNode/UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NullWeight')">
							<xsl:call-template name="Text">
								<xsl:with-param
									name="String"
									select="$WeightStart" />
							</xsl:call-template>
						</xsl:if>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'WeightIs'">
						<!-- Activity edge weight is, ']' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$WeightIs" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'WeightEnd'">
						<!-- Activity edge weight end, ']' -->
						<xsl:if
							test="$ShowNulls or not(preceding-sibling::UML:GraphNode/UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NullWeight')">
							<xsl:call-template name="Text">
								<xsl:with-param
									name="String"
									select="$WeightEnd" />
							</xsl:call-template>
						</xsl:if>
					</xsl:when>

				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>
</xsl:stylesheet>
