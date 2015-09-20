<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: StateTransitionDescription.xsl - UML2 -->
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

	<!-- StateTransitionDescription -->
	<xsl:template name="StateTransitionDescription">
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
				<xsl:text>StateTransitionDescription</xsl:text>
			</desc>

			<!-- TransitionDescription text -->
			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:CallTrigger">
						<!-- UML2 CallTrigger -->
						<g
							id="{@xmi.id}"
							transform="translate({UML:GraphElement.position/XMI.field[1]}, {UML:GraphElement.position/XMI.field[2]})">
							<desc>CallTrigger</desc>
							<xsl:variable
								name="CallTriggerID"
								select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:CallTrigger/@xmi.idref" />
							<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
								<xsl:choose>
									<xsl:when
										test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
										<xsl:call-template name="Text">
											<xsl:with-param
												name="String"
												select="key('xmi.id', $CallTriggerID)/@name" />
										</xsl:call-template>
									</xsl:when>
								</xsl:choose>
							</xsl:for-each>
						</g>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NullTrigger'">
						<xsl:if test="$ShowNulls">
							<xsl:call-template name="Text">
								<xsl:with-param
									name="String"
									select="'&lt;trigger&gt;'" />
							</xsl:call-template>
						</xsl:if>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'TriggerSeparator'">
						<!-- Trigger separator, '|' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$TriggerSeparator" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'GuardStart'">
						<!-- Guard start, '[' -->
						<xsl:if
							test="$ShowNulls or not(following-sibling::UML:GraphNode/UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NullGuard'
						                  or preceding-sibling::UML:GraphNode/UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NullGuard')">
							<xsl:call-template name="Text">
								<xsl:with-param
									name="String"
									select="$GuardStart" />
							</xsl:call-template>
						</xsl:if>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:Constraint">
						<!-- UML2 Constraint -->
						<g
							id="{@xmi.id}"
							transform="translate({UML:GraphElement.position/XMI.field[1]}, {UML:GraphElement.position/XMI.field[2]})">
							<desc>Constraint</desc>
							<xsl:variable
								name="ConstraintID"
								select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:Constraint/@xmi.idref" />
							<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
								<xsl:choose>
									<xsl:when
										test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
										<xsl:call-template name="Text">
											<xsl:with-param
												name="String"
												select="key('xmi.id', $ConstraintID)/@name" />
										</xsl:call-template>
									</xsl:when>
								</xsl:choose>
							</xsl:for-each>
						</g>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NullGuard'">
						<xsl:if test="$ShowNulls">
							<xsl:call-template name="Text">
								<xsl:with-param
									name="String"
									select="'&lt;guard&gt;'" />
							</xsl:call-template>
						</xsl:if>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'GuardEnd'">
						<!-- Guard end, ']' -->
						<xsl:if
							test="$ShowNulls or not(following-sibling::UML:GraphNode/UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NullGuard'
						                  or preceding-sibling::UML:GraphNode/UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NullGuard')">
							<xsl:call-template name="Text">
								<xsl:with-param
									name="String"
									select="$GuardEnd" />
							</xsl:call-template>
						</xsl:if>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'EffectStart'">
						<!-- Effect start, '/' -->
						<xsl:if
							test="$ShowNulls or not(following-sibling::UML:GraphNode/UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NullEffect'
						                  or preceding-sibling::UML:GraphNode/UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NullEffect')">
							<xsl:call-template name="Text">
								<xsl:with-param
									name="String"
									select="$EffectStart" />
							</xsl:call-template>
						</xsl:if>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:OpaqueBehavior">
						<!-- UML2 OpaqueBehavior -->
						<g
							id="{@xmi.id}"
							transform="translate({UML:GraphElement.position/XMI.field[1]}, {UML:GraphElement.position/XMI.field[2]})">
							<desc>OpaqueBehavior</desc>
							<xsl:variable
								name="OpaqueBehaviorID"
								select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:OpaqueBehavior/@xmi.idref" />
							<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
								<xsl:choose>
									<xsl:when
										test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
										<xsl:call-template name="Text">
											<xsl:with-param
												name="String"
												select="key('xmi.id', $OpaqueBehaviorID)/@name" />
										</xsl:call-template>
									</xsl:when>
								</xsl:choose>
							</xsl:for-each>
						</g>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NullEffect'">
						<xsl:if test="$ShowNulls">
							<xsl:call-template name="Text">
								<xsl:with-param
									name="String"
									select="'&lt;effect&gt;'" />
							</xsl:call-template>
						</xsl:if>
					</xsl:when>

				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>
</xsl:stylesheet>
