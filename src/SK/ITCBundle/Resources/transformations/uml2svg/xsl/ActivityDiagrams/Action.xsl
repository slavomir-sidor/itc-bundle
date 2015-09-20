<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: Action.xsl Displays Actions -->
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

	<!-- Action -->
	<xsl:template name="Action">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- Main Action group -->
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
				<xsl:text>Action</xsl:text>
			</desc>

			<!-- Action text -->
			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Label'">
						<!-- Action label -->
						<xsl:call-template name="Text">
							<xsl:with-param name="String">
								<xsl:choose>
									<xsl:when test="key('xmi.id', $SemanticID)/parent::UML:State.entry">
										<xsl:text>entry</xsl:text>
									</xsl:when>
									<xsl:when test="key('xmi.id', $SemanticID)/parent::UML:State.exit">
										<xsl:text>exit</xsl:text>
									</xsl:when>
									<xsl:when test="key('xmi.id', $SemanticID)/parent::UML:State.doActivity">
										<xsl:text>do</xsl:text>
									</xsl:when>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'EffectStart'">
						<!-- Label / expression delimiter, '/' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$EffectStart" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Expression'">
						<!-- Action expression -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="key('xmi.id', $SemanticID)/UML:Action.script/UML:ActionExpression/@body" />
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>
</xsl:stylesheet>
