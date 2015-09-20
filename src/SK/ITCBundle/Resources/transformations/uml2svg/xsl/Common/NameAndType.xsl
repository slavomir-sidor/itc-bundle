<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: NameAndType.xsl Displays name and type of an object (all is underlined) -->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:import href="Globals.xsl" />
	<xsl:import href="Styling.xsl" />
	<xsl:import href="Text.xsl" />
	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

	<!-- NameAndType -->
	<xsl:template name="NameAndType">
		<xsl:param
			name="OwnerSemanticID"
			select="../../../../UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- Main NameAndType group -->
		<g
			id="{@xmi.id}"
			transform="translate({UML:GraphElement.position/XMI.field[1]}, {UML:GraphElement.position/XMI.field[2]})">
			<xsl:apply-templates
				select="."
				mode="FontStyle" />
			<xsl:apply-templates
				select="."
				mode="isVisible" />

			<title>
				<xsl:text>NameAndType for </xsl:text>
				<xsl:value-of select="$OwnerSemanticID" />
			</title>
			<desc>
				<xsl:text>NameAndType</xsl:text>
			</desc>

			<!-- NameAndType text should be underlined -->

			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
						<!-- Name -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="key('xmi.id', $OwnerSemanticID)/@name" />
							<xsl:with-param
								name="Space"
								select="'preserve'" />
							<xsl:with-param
								name="TextDecoration"
								select="'underline'" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'TypeSeparator'">
						<!-- Type separators, ':' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$TypeSeparator" />
							<xsl:with-param
								name="TextDecoration"
								select="'underline'" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*">
						<!-- Type -->
						<xsl:variable name="TypeID">
							<xsl:value-of
								select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
						</xsl:variable>
						<xsl:variable
							name="x1"
							select="UML:GraphElement.position/XMI.field[1]" />
						<xsl:variable
							name="y1"
							select="UML:GraphElement.position/XMI.field[2]" />
						<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
							<xsl:choose>
								<xsl:when
									test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
									<!-- Type Name -->
									<xsl:call-template name="Text">
										<xsl:with-param
											name="String"
											select="key('xmi.id', $TypeID)/@name" />
										<xsl:with-param
											name="Space"
											select="'preserve'" />
										<xsl:with-param
											name="x"
											select="UML:GraphElement.position/XMI.field[1] + $x1" />
										<xsl:with-param
											name="y"
											select="UML:GraphElement.position/XMI.field[2] + $y1" />
										<xsl:with-param
											name="TextDecoration"
											select="'underline'" />
									</xsl:call-template>
								</xsl:when>
							</xsl:choose>
						</xsl:for-each>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>
</xsl:stylesheet>
