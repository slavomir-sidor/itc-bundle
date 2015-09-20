<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: Operation.xsl Displays Operations -->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:import href="../Common/Styling.xsl" />
	<xsl:import href="../Common/StereotypeCompartment.xsl" />
	<xsl:import href="../Common/ExpressionCompartment.xsl" />
	<xsl:import href="../Common/Visibility.xsl" />
	<xsl:import href="../ClassDiagrams/Parameter.xsl" />
	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

	<!-- Operation -->
	<xsl:template name="Operation">

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

		<!-- Main Operation group -->
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
				<xsl:text>Operation </xsl:text>
				<xsl:value-of select="key('xmi.id', $SemanticID)/@name" />
			</title>
			<desc>
				<xsl:text>Operation</xsl:text>
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
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'ParameterStart'">
						<!-- Parameter Start, '(' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$ParameterStart" />
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Parameter">
						<!-- Parameter -->
						<xsl:call-template name="Parameter">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$SemanticID" />
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'ParameterSeparator'">
						<!-- Parameter Separator, ',' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$ParameterSeparator" />
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'ParameterEnd'">
						<!-- Parameter End, ')' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$ParameterEnd" />
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

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Argument">
						<!-- Argument -->
						<xsl:variable
							name="ArgumentID"
							select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Argument/@xmi.idref" />
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="key('xmi.id', $ArgumentID)/UML:Argument.value/UML:Expression/@body" />
							<xsl:with-param
								name="Space"
								select="'preserve'" />
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>


					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo= 'Assignment'">
						<!-- Assignment -->
						<xsl:call-template name="Text">
							<xsl:with-param name="String">
								<xsl:text>:=</xsl:text>
							</xsl:with-param>
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:OpaqueExpression">
						<xsl:variable
							name="OpaqueExpressionID"
							select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:OpaqueExpression/@xmi.idref" />
						<xsl:variable
							name="OpaqueExpressionBody"
							select="key('xmi.id', $OpaqueExpressionID)/@body" />

						<xsl:call-template name="Text">
							<xsl:with-param name="String">
								<xsl:value-of select="$OpaqueExpressionBody" />
							</xsl:with-param>
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
