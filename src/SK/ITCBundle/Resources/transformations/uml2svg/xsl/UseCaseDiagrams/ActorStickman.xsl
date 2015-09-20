<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: ActorStickman.xsl Displays an Actor as a Stickman -->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:import href="../Common/Styling.xsl" />
	<xsl:import href="../Common/Name.xsl" />
	<xsl:import href="../Common/NameCompartment.xsl" />
	<xsl:import href="../Common/NamespaceCompartment.xsl" />
	<xsl:import href="../Common/StereotypeCompartment.xsl" />
	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

	<!-- ActorStickman -->
	<xsl:template name="ActorStickman">

		<xsl:param
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Actor/@xmi.idref" />

		<!-- Actor outline variables -->
		<xsl:variable name="Width">
			<xsl:value-of select="UML:GraphNode.size/XMI.field[1]" />
		</xsl:variable>
		<xsl:variable name="Height">
			<xsl:value-of select="UML:GraphNode.size/XMI.field[2]" />
		</xsl:variable>

		<!-- Main Actor group -->
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
			<xsl:if
				test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement[@typeInfo='HeaderCompartment'] and ../../UML:GraphElement.semanticModel//UML:Object"> <!-- Actor in sequence diagram -->
				<!-- Active? -->
				<xsl:for-each
					select="key('xmi.id', $SemanticID)/UML:ModelElement.taggedValue/UML:TaggedValue">
					<xsl:variable
						name="idref"
						select=".//*[@xmi.idref]/@xmi.idref" />
					<xsl:if
						test="(key('xmi.id', $idref)/@name = 'isActive') and (UML:TaggedValue.dataValue = 'true')">
						<xsl:attribute name="stroke-width"><xsl:text>3px</xsl:text></xsl:attribute>
					</xsl:if>
				</xsl:for-each>
			</xsl:if>

			<title>
				<xsl:value-of select="key('xmi.id', $SemanticID)/@name" />
			</title>
			<desc>
				<xsl:text>Actor</xsl:text>
			</desc>

			<!-- Actor outline, a stickman -->
			<!-- Head -->
			<ellipse
				cx="{$Width div 2}"
				cy="{$Height div 8}"
				rx="{$Width * 3 div 16}"
				ry="{$Height div 8}">
				<xsl:choose>
					<!-- Actor in sequence diagram -->
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement[@typeInfo='HeaderCompartment'] and ../../UML:GraphElement.semanticModel//UML:Object">
						<xsl:apply-templates
							select="../.."
							mode="FillStyle" />
						<xsl:apply-templates
							select="."
							mode="FillStyle">
							<xsl:with-param
								name="DefaultFill"
								select="'none'" />
						</xsl:apply-templates>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates
							select="."
							mode="FillStyle" />
					</xsl:otherwise>
				</xsl:choose>
			</ellipse>

			<!-- Body -->
			<line
				x1="{$Width div 2}"
				x2="{$Width div 2}"
				y1="{$Height div 4}"
				y2="{$Height * 2 div 3} " />

			<!-- Arms -->
			<line
				x1="0"
				x2="{$Width}"
				y1="{$Height div 3}"
				y2="{$Height div 3}" />

			<!-- Left leg -->
			<line
				x1="0"
				x2="{$Width div 2}"
				y1="{$Height}"
				y2="{$Height * 2 div 3}" />

			<!-- Right leg -->
			<line
				x1="{$Width}"
				x2="{$Width div 2}"
				y1="{$Height}"
				y2="{$Height * 2 div 3}" />

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
						<!-- Actor Name -->
						<xsl:call-template name="Name">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$SemanticID" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NameCompartment'">
						<!-- Actor Name -->
						<xsl:call-template name="NameCompartment">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$SemanticID" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NamespaceCompartment'">
						<!-- Actor Namespace -->
						<xsl:call-template name="NamespaceCompartment">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$SemanticID" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'StereotypeCompartment'">
						<!-- Actor Stereotypes -->
						<xsl:call-template name="StereotypeCompartment">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$SemanticID" />
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>
</xsl:stylesheet>
