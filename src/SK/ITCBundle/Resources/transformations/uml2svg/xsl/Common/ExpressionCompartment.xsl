<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: ExpressionCompartment.xsl An expression compartment is a comma separated 
	list of expressions (constraints) contained between braces { ... , ... } -->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:import href="Globals.xsl" />
	<xsl:import href="Styling.xsl" />

	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

	<!-- Expression compartment -->
	<xsl:template name="ExpressionCompartment">
		<xsl:param
			name="OwnerSemanticID"
			select="../../../../UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
		<xsl:param
			name="TextDecoration"
			select="''" />

		<!-- Main expression compartment group -->
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
				<xsl:text>Expression compartment for </xsl:text>
				<xsl:value-of select="key('xmi.id', $OwnerSemanticID)/@name" />
			</title>
			<desc>
				<xsl:text>Expression compartment</xsl:text>
			</desc>

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'ExpressionStart'">
						<!-- Expression start, '{' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$ExpressionStart" />
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*">
						<!-- Expressions -->
						<xsl:variable
							name="ConstraintSemanticID"
							select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="key('xmi.id', $ConstraintSemanticID)/UML:Constraint.body/*/@body" />
							<xsl:with-param
								name="Space"
								select="'preserve'" />
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'ExpressionSeparator'">
						<!-- Expression separators, ',' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$ExpressionSeparator" />
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Ordering'">
						<!-- Ordering -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="key('xmi.id', $OwnerSemanticID)/@ordering" />
							<xsl:with-param
								name="TextDecoration"
								select="$TextDecoration" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'ExpressionEnd'">
						<!-- Expression end, '}' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$ExpressionEnd" />
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
