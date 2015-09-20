<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: Parameter.xsl Displays parameters as [kind] name:type -->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:import href="../Common/Styling.xsl" />
	<xsl:import href="../Common/Text.xsl" />
	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

	<!-- Parameter -->
	<xsl:template name="Parameter">
		<xsl:param name="OwnerSemanticID" />
		<xsl:param
			name="TextDecoration"
			select="''" />

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

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
				<xsl:text>Parameter </xsl:text>
				<xsl:value-of select="key('xmi.id', $SemanticID)/@name" />
			</title>
			<desc>
				<xsl:text>Parameter</xsl:text>
			</desc>

			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Kind'">
						<!-- Kind -->
						<xsl:call-template name="Text">
							<xsl:with-param name="String">
								<xsl:value-of select="key('xmi.id', $SemanticID)/@kind" />
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
								name="Space"
								select="'preserve'" />
							<xsl:with-param
								name="String"
								select="key('xmi.id', $SemanticID)/@name" />
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
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*">
						<!-- Type -->
						<xsl:variable
							name="TypeID"
							select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
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
										<xsl:with-param name="String">
											<xsl:value-of select="key('xmi.id', $TypeID)/@name" />
										</xsl:with-param>
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
											select="$TextDecoration" />
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
