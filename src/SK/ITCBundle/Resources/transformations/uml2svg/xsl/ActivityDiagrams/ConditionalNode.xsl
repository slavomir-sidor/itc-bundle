<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: ConditionalNode.xsl - UML2 -->

<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:import href="../Common/Styling.xsl" />
	<xsl:import href="../ActivityDiagrams/Compartment.xsl" />


	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

	<!-- ConditionalNode -->
	<xsl:template name="ConditionalNode">

		<xsl:param
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- Main ConditionalNode group -->
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
			<desc>ConditionalNode</desc>

			<!-- Outline variables -->
			<xsl:variable name="rx">
				<xsl:choose>
					<xsl:when test="UML:GraphNode.size/XMI.field[1] &lt; 150">
						<xsl:text>10</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="UML:GraphNode.size/XMI.field[1] * 0.066" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>

			<xsl:variable name="ry">
				<xsl:choose>
					<xsl:when test="UML:GraphNode.size/XMI.field[2] &lt; 150">
						<xsl:text>10</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="UML:GraphNode.size/XMI.field[2] * 0.066" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>

			<!-- The outline shape, a rounded corner rectangle with dashed lines -->
			<rect
				style="stroke-dasharray: 10 6"
				width="{UML:GraphNode.size/XMI.field[1]}"
				height="{UML:GraphNode.size/XMI.field[2]}"
				rx="{$rx}"
				ry="{$ry}">
				<xsl:apply-templates
					select="."
					mode="FillStyle" />
			</rect>

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/*">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NameCompartment'">
						<xsl:call-template name="NameCompartment">
							<xsl:with-param
								name="OwnerSemanticID"
								select="../../@xmi.id" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'ClauseSeparator'">
						<!-- Main clause separator group -->
						<g
							id="{@xmi.id}"
							transform="translate({UML:GraphElement.position/XMI.field[1]}, {UML:GraphElement.position/XMI.field[2]})">
							<xsl:apply-templates
								select="."
								mode="StrokeStyle" />
							<xsl:apply-templates
								select="."
								mode="isVisible" />

							<desc>
								<xsl:text>Clause separator separator</xsl:text>
							</desc>

							<!-- Clause separator line -->
							<line
								style="stroke-dasharray: 10 6"
								x1="0"
								y1="0"
								x2="{UML:GraphNode.size/XMI.field[1]}"
								y2="0" />
						</g>

					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'TestCompartment'">
						<xsl:call-template name="Compartment">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$SemanticID" />
							<xsl:with-param
								name="Name"
								select="'if'" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'BodyCompartment'">
						<xsl:call-template name="Compartment">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$SemanticID" />
							<xsl:with-param
								name="Name"
								select="'then'" />
						</xsl:call-template>
					</xsl:when>


					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'ConditionalTestCompartment'">
						<xsl:call-template name="Compartment">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$SemanticID" />
							<xsl:with-param
								name="Name"
								select="'else'" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:InputPin">
						<xsl:call-template name="Pin" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:OutputPin">
						<xsl:call-template name="Pin">
							<xsl:with-param
								name="ShowArrow"
								select="true()" />
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>
</xsl:stylesheet>
