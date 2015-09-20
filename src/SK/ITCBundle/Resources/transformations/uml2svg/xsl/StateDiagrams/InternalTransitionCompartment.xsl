<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: InternalTransitionCompartment.xsl Displays InternalTransitionCompartment -->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:import href="../Common/Styling.xsl" />
	<xsl:import href="../Common/Lines.xsl" />
	<xsl:import href="../ActivityDiagrams/Action.xsl" />
	<xsl:import href="../StateDiagrams/Transition.xsl" />
	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

	<!-- InternalTransitionCompartment -->
	<xsl:template name="InternalTransitionCompartment">

		<xsl:variable
			name="SemanticID"
			select="../../UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- Main InternalTransitionCompartment group -->
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

			<title>
				<xsl:value-of select="key('xmi.id', $SemanticID)/@name" />
			</title>
			<desc>
				<xsl:text>InternalTransitionCompartment</xsl:text>
			</desc>

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:CallAction">
						<!-- Call Action -->
						<xsl:call-template name="Action" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Transition">
						<!-- Internal transition -->
						<xsl:call-template name="Transition" />
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

									<xsl:when
										test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'OpaqueBehaviorDescription'">
										<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
											<xsl:choose>
												<xsl:when
													test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Label'">
													<xsl:variable
														name="p"
														select="substring-after(name(key('xmi.id', $OpaqueBehaviorID)/..), 'State.')" />
													<xsl:variable name="label">
														<xsl:choose>
															<xsl:when test="$p = 'doActivity'">
																do
															</xsl:when>
															<xsl:otherwise>
																<xsl:value-of select="$p" />
															</xsl:otherwise>
														</xsl:choose>
													</xsl:variable>
													<xsl:call-template name="Text">
														<xsl:with-param
															name="String"
															select="$label" />
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
													test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
													<xsl:call-template name="Text">
														<xsl:with-param
															name="String"
															select="key('xmi.id', $OpaqueBehaviorID)/@name" />
													</xsl:call-template>
												</xsl:when>
											</xsl:choose>
										</xsl:for-each>
									</xsl:when>
								</xsl:choose>
							</xsl:for-each>
						</g>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:Transition">
						<xsl:variable
							name="TransitionSemanticID"
							select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

						<!-- The main Transition group -->
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

							<title>
								Transition
								<xsl:value-of select="$TransitionSemanticID" />
							</title>
							<desc>
								Transition:
								<xsl:value-of
									select="key('xmi.id', $TransitionSemanticID)/UML:Transition.source/*/@xmi.idref" />
								-&gt;
								<xsl:value-of
									select="key('xmi.id', $TransitionSemanticID)/UML:Transition.target/*/@xmi.idref" />
							</desc>

							<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
								<xsl:choose>
									<xsl:when
										test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'StateTransitionDescription'">
										<!-- UML2 StateTransitionDescription -->
										<xsl:call-template name="StateTransitionDescription">
											<xsl:with-param
												name="ShowNulls"
												select="true()" />
										</xsl:call-template>
									</xsl:when>
								</xsl:choose>
							</xsl:for-each>
						</g>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'CompartmentSeparator'">
						<xsl:call-template name="CompartmentSeparator" />
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>
</xsl:stylesheet>
