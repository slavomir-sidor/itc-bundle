<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: PortNameCompartment.xsl Displays Ports PortNameCompartment -->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:import href="../Common/Globals.xsl" />
	<xsl:import href="../Common/Styling.xsl" />
	<xsl:import href="../Common/Text.xsl" />
	<xsl:import href="../Common/Multiplicity.xsl" />

	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

	<!-- PortNameCompartment -->
	<xsl:template name="PortNameCompartment">

		<xsl:variable
			name="SemanticID"
			select="../../UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- Main PortNameCompartment group -->
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
				<xsl:text>PortNameCompartment</xsl:text>
			</desc>

			<!-- Contained elements -->
			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
						<!-- Port Name -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="key('xmi.id', $SemanticID)/@name" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'TypeSeparator'">
						<!-- Name/Type separator, ':' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$TypeSeparator" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'StructuralFeatureType'">
						<!-- Port Type -->
						<xsl:variable
							name="basex"
							select="UML:GraphElement.position/XMI.field[1]" />
						<xsl:variable
							name="basey"
							select="UML:GraphElement.position/XMI.field[2]" />
						<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
							<xsl:variable
								name="TypeSemanticID"
								select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
							<xsl:call-template name="Text">
								<xsl:with-param
									name="String"
									select="key('xmi.id', $TypeSemanticID)/@name" />
								<xsl:with-param
									name="x"
									select="UML:GraphElement.position/XMI.field[1] + $basex" />
								<xsl:with-param
									name="y"
									select="UML:GraphElement.position/XMI.field[2] + $basey" />
							</xsl:call-template>
						</xsl:for-each>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'MultiplicityStart'">
						<!-- Multiplicity start, '[' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$MultiplicityStart" />
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
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'MultiplicityEnd'">
						<!-- Multiplicity end, ']' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$MultiplicityEnd" />
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>
</xsl:stylesheet>
