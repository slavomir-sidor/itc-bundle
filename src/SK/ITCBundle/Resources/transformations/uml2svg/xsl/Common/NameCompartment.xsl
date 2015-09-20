<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: NameCompartment.xsl Displays element properties (stereotypes, name, 
	namespace, constraints) -->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:import href="Styling.xsl" />
	<xsl:import href="StereotypeCompartment.xsl" />
	<xsl:import href="Name.xsl" />
	<xsl:import href="NameAndType.xsl" />
	<xsl:import href="NamespaceCompartment.xsl" />
	<xsl:import href="ExpressionCompartment.xsl" />
	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

	<!-- NameCompartment -->
	<xsl:template name="NameCompartment">
		<xsl:param
			name="OwnerSemanticID"
			select="../../UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
		<xsl:param
			name="TextDecoration"
			select="''" />
		
		<!-- Main NameCompartment group -->
		<g
			id="{@xmi.id}"
			transform="translate({UML:GraphElement.position/XMI.field[1]}, {UML:GraphElement.position/XMI.field[2]})">
			<xsl:apply-templates
				select="."
				mode="FontStyle" />
			<xsl:apply-templates
				select="."
				mode="isVisible" />


			<xsl:if
				test="local-name(key('xmi.id', $OwnerSemanticID)) = 'ActivityPartition' and ((../../../../UML:DiagramElement.property/UML:Property[@key = 'layout']/@value = 'horizontal') or ((../../../../UML:DiagramElement.property/UML:Property[@key = 'layout']/@value = 'matrix') and ../../UML:DiagramElement.property/UML:Property[@key = 'column']/@value = '0'))">
				<xsl:attribute name="transform">translate(<xsl:value-of
					select="UML:GraphElement.position/XMI.field[1]" />, <xsl:value-of
					select="UML:GraphElement.position/XMI.field[2]" />) rotate(-90)</xsl:attribute>
			</xsl:if>

			<desc>
				<xsl:text>NameCompartment</xsl:text>
			</desc>

			<xsl:if test="local-name(key('xmi.id', $OwnerSemanticID)) = 'Diagram'">
				<!-- The outline shape - a rectangle with a missing bottom-right edge -->
				<xsl:variable
					name="width"
					select="UML:GraphNode.size/XMI.field[1]" />
				<xsl:variable
					name="height"
					select="UML:GraphNode.size/XMI.field[2]" />
				<path d="M 0 0 h {$width} v {$height - 8} l -8 8 h {-$width+8} z">
					<xsl:apply-templates
						select="."
						mode="FillStyle" />
				</path>
			</xsl:if>

			<xsl:if test="local-name(key('xmi.id', $OwnerSemanticID)) = 'ActivityPartition'">
				<rect
					width="{UML:GraphNode.size/XMI.field[1]}"
					height="{UML:GraphNode.size/XMI.field[2]}">
					<xsl:apply-templates
						select="."
						mode="FillStyle" />
				</rect>
			</xsl:if>
			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'StereotypeCompartment'">
						<!-- Stereotype compartment -->
						<xsl:call-template name="StereotypeCompartment">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$OwnerSemanticID" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
						<!-- Name -->
						<xsl:variable name="FontWeight">
							<xsl:if
								test="../../../../UML:GraphElement.semanticModel//UML:Class or ../../../../UML:GraphElement.semanticModel//*[@presentation = 'Classifier'] or ../../../../UML:GraphElement.semanticModel//UML:Interface or ../../../../UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'AssociationClassNode'">
								<xsl:text>bold</xsl:text>
							</xsl:if>
						</xsl:variable>
						<xsl:call-template name="Name">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$OwnerSemanticID" />
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
							<xsl:with-param
								name="FontWeight"
								select="$FontWeight" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NameAndType'">
						<!-- Name and Type -->
						<xsl:call-template name="NameAndType">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$OwnerSemanticID" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NamespaceCompartment'">
						<!-- Namespace compartment -->
						<xsl:call-template name="NamespaceCompartment">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$OwnerSemanticID" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'ExpressionCompartment'">
						<!-- Expression compartment -->
						<xsl:call-template name="ExpressionCompartment">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$OwnerSemanticID" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'TypeSeparator'">
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$TypeSeparator" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'SubmachineType'">
						<g
							id="{@xmi.id}"
							transform="translate({UML:GraphElement.position/XMI.field[1]}, {UML:GraphElement.position/XMI.field[2]})">
							<xsl:apply-templates
								select="."
								mode="FontStyle" />
							<xsl:apply-templates
								select="."
								mode="isVisible" />

							<desc>
								<xsl:text>SubmachineType</xsl:text>
							</desc>

							<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
								<xsl:choose>
									<xsl:when
										test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:StateMachine">
										<xsl:variable
											name="StateMachineID"
											select="	UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:StateMachine/@xmi.idref" />
										<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
											<xsl:choose>
												<xsl:when
													test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
													<xsl:call-template name="Name">
														<xsl:with-param
															name="OwnerSemanticID"
															select="$StateMachineID" />
													</xsl:call-template>
												</xsl:when>
											</xsl:choose>
										</xsl:for-each>
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
