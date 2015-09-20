<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: Attribute.xsl Displays Attributes -->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:import href="../Common/Globals.xsl" />
	<xsl:import href="../Common/Styling.xsl" />
	<xsl:import href="../Common/Name.xsl" />
	<xsl:import href="../Common/StereotypeCompartment.xsl" />
	<xsl:import href="../Common/ExpressionCompartment.xsl" />
	<xsl:import href="../Common/Visibility.xsl" />
	<xsl:import href="../Common/Multiplicity.xsl" />
	<xsl:import href="../Common/Text.xsl" />

	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

	<!-- Attribute -->
	<xsl:template name="Attribute">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
		<xsl:variable name="TextDecoration">
			<xsl:choose>
				<xsl:when test="key('xmi.id', $SemanticID)/@ownerScope = 'classifier'">
					<xsl:text>underline</xsl:text>
				</xsl:when>
				<xsl:otherwise></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<!-- Main Attribute group -->
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
			<xsl:if test="key('xmi.id', $SemanticID)/@isAbstract = 'true'">
				<xsl:attribute name="font-style">italic</xsl:attribute>
			</xsl:if>

			<title>
				<xsl:text>Attribute </xsl:text>
				<xsl:value-of select="key('xmi.id', $SemanticID)/@name" />
			</title>
			<desc>
				<xsl:text>Attribute</xsl:text>
			</desc>

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/*">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'StereotypeCompartment'">
						<!-- Stereotype compartment -->
						<xsl:call-template name="StereotypeCompartment">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$SemanticID" />
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Derived'">
						<!-- Derived, '/' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$Derived" />
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Visibility'">
						<!-- Visibility -->
						<xsl:call-template name="Text">
							<xsl:with-param name="String">
								<xsl:call-template name="Visibility">
									<xsl:with-param
										name="OwnerSemanticID"
										select="$SemanticID" />
								</xsl:call-template>
							</xsl:with-param>
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
						<!-- Name -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="key('xmi.id', $SemanticID)/@name" />
							<xsl:with-param
								name="Space"
								select="'preserve'" />
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'TypeSeparator'">
						<!-- Type separator, ':' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$TypeSeparator" />
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'StructuralFeatureType'">
						<!-- StructuralFeatureType -->
						<xsl:variable
							name="x1"
							select="UML:GraphElement.position/XMI.field[1]" />
						<xsl:variable
							name="y1"
							select="UML:GraphElement.position/XMI.field[2]" />
						<xsl:for-each select="UML:GraphElement.contained/*">
							<xsl:choose>
								<xsl:when
									test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*">
									<!-- Type -->
									<xsl:variable name="TypeID">
										<xsl:value-of
											select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
									</xsl:variable>
									<xsl:variable
										name="x2"
										select="UML:GraphElement.position/XMI.field[1]" />
									<xsl:variable
										name="y2"
										select="UML:GraphElement.position/XMI.field[2]" />
									<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
										<xsl:choose>
											<xsl:when
												test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
												<!-- Type Name -->
												<xsl:call-template name="Text">
													<xsl:with-param name="String">
														<xsl:value-of select="key('xmi.id', $TypeID)/@name" />
													</xsl:with-param>
													<xsl:with-param
														name="Space"
														select="'preserve'" />
													<xsl:with-param
														name="x"
														select="UML:GraphElement.position/XMI.field[1] + $x1 + $x2" />
													<xsl:with-param
														name="y"
														select="UML:GraphElement.position/XMI.field[2] + $y1 + $y2" />
													<xsl:with-param
														name="TextDecoration"
														select="$TextDecoration" />
												</xsl:call-template>
											</xsl:when>
										</xsl:choose>
									</xsl:for-each>
								</xsl:when>
							</xsl:choose>
						</xsl:for-each>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'MultiplicityStart'">
						<!-- MultiplicityStart, '[' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$MultiplicityStart" />
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Multiplicity'">
						<!-- Multiplicity -->
						<xsl:call-template name="Text">
							<xsl:with-param name="String">
								<xsl:call-template name="Multiplicity">
									<xsl:with-param
										name="OwnerSemanticID"
										select="$SemanticID" />
								</xsl:call-template>
							</xsl:with-param>
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'MultiplicityEnd'">
						<!-- MultiplicityEnd, ']' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$MultiplicityEnd" />
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Ordering'">
						<!-- Ordering -->
						<xsl:call-template name="Text">
							<xsl:with-param name="String">
								<xsl:value-of select="key('xmi.id', $SemanticID)/@ordering" />
							</xsl:with-param>
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'InitialValueSeparator'">
						<!-- InitialValueSeparator, '=' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$InitialValueSeparator" />
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'InitialValue'">
						<!-- InitialValue -->
						<xsl:call-template name="Text">
							<xsl:with-param name="String">
								<xsl:value-of
									select="key('xmi.id', $SemanticID)/UML:Attribute.initialValue/*/@body" />
							</xsl:with-param>
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'ExpressionCompartment'">
						<!-- Expression compartment -->
						<xsl:call-template name="ExpressionCompartment">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$SemanticID" />
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>
</xsl:stylesheet>
