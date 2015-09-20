<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: InStates.xsl Displays the list of states an object flow state represents 
	in an activity diagram -->
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

	<!-- InStates -->
	<xsl:template name="InStates">


		<!-- Main InStates group -->
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
				<xsl:text>InStates</xsl:text>
			</desc>

			<!-- InStates text -->
			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'InStatesStart'">
						<!-- Statelist start, '[' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$InStatesStart" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*">
						<!-- State -->
						<xsl:variable
							name="SemanticID"
							select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="key('xmi.id', $SemanticID)/@name" />
							<xsl:with-param
								name="TextDecoration"
								select="'underline'" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'InStatesEnd'">
						<!-- Statelist end, ']' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$InStatesEnd" />
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>
</xsl:stylesheet>
