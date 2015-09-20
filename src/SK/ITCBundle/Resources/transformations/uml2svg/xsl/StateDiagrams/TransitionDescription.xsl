<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: TransitionDescription.xsl Displays Transition Description -->
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

	<!-- TransitionDescription -->
	<xsl:template name="TransitionDescription">

		<xsl:variable
			name="SemanticID"
			select="../../UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- Main TransitionDescription group -->
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
				<xsl:text>TransitionDescription</xsl:text>
			</desc>

			<!-- TransitionDescription text -->
			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:CallEvent">
						<!-- Event Trigger -->
						<g
							id="{@xmi.id}"
							transform="translate({UML:GraphElement.position/XMI.field[1]}, {UML:GraphElement.position/XMI.field[2]})">
							<desc>CallEvent</desc>
							<xsl:variable
								name="CallEventSemanticID"
								select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
							<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
								<xsl:choose>
									<xsl:when
										test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
										<xsl:call-template name="Text">
											<xsl:with-param name="String">
												<xsl:choose>
													<xsl:when test="key('xmi.id', $CallEventSemanticID)/@name">
														<xsl:value-of select="key('xmi.id', $CallEventSemanticID)/@name" />
													</xsl:when>
													<xsl:otherwise>
														<xsl:text>anonymous</xsl:text>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:with-param>
										</xsl:call-template>
									</xsl:when>
								</xsl:choose>
							</xsl:for-each>
						</g>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'GuardStart'">
						<!-- Guard start, '[' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$GuardStart" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Guard">
						<!-- Transition guard -->
						<g
							id="{@xmi.id}"
							transform="translate({UML:GraphElement.position/XMI.field[1]}, {UML:GraphElement.position/XMI.field[2]})">
							<desc>Guard</desc>
							<xsl:variable
								name="GuardSemanticID"
								select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
							<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
								<xsl:choose>
									<xsl:when
										test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Expression'">
										<xsl:call-template name="Text">
											<xsl:with-param
												name="String"
												select="key('xmi.id', $GuardSemanticID)/UML:Guard.expression/UML:BooleanExpression/@body" />
										</xsl:call-template>
									</xsl:when>
								</xsl:choose>
							</xsl:for-each>
						</g>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'GuardEnd'">
						<!-- Guard end, ']' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$GuardEnd" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'EffectStart'">
						<!-- Effect start, '/' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$EffectStart" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:CallAction">
						<!-- Call Action -->
						<g
							id="{@xmi.id}"
							transform="translate({UML:GraphElement.position/XMI.field[1]}, {UML:GraphElement.position/XMI.field[2]})">
							<xsl:apply-templates
								select="."
								mode="FontStyle" />
							<xsl:apply-templates
								select="."
								mode="isVisible" />
							<xsl:variable
								name="CallActionSemanticID"
								select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
							<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
								<xsl:choose>
									<xsl:when
										test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Expression'">
										<xsl:call-template name="Text">
											<xsl:with-param
												name="String"
												select="key('xmi.id', $CallActionSemanticID)/UML:Action.script/UML:ActionExpression/@body" />
										</xsl:call-template>
									</xsl:when>
								</xsl:choose>
							</xsl:for-each>
						</g>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>
</xsl:stylesheet>
