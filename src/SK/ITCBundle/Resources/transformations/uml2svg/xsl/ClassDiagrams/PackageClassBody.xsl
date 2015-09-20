<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: PackageClassBody.xsl Package body compartment -->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:import href="../Common/Styling.xsl" />
	<xsl:import href="../ClassDiagrams/Class.xsl" />
	<xsl:import href="../ClassDiagrams/Interface.xsl" />
	<xsl:import href="../UseCaseDiagrams/Actor.xsl" />
	<xsl:import href="../UseCaseDiagrams/Collaboration.xsl" />
	<xsl:import href="../Common/Comment.xsl" />
	<xsl:import href="../Common/Lines.xsl" />
	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

	<!-- PackageClassBody -->
	<xsl:template name="PackageClassBody">

		<!-- Main PackageClassBody group -->
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

			<desc>Package body compartment</desc>

			<!-- The package's outline shape, a rectangle -->
			<rect
				width="{UML:GraphNode.size/XMI.field[1]}"
				height="{UML:GraphNode.size/XMI.field[2]}">
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
			</rect>

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/*">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Package or UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Model">
						<xsl:call-template name="PackageClass" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Class">
						<xsl:call-template name="Class" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Actor">
						<xsl:call-template name="Actor" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Interface">
						<xsl:call-template name="Interface" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Collaboration">
						<xsl:call-template name="Collaboration" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Comment">
						<xsl:call-template name="Comment" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Generalization">
						<xsl:call-template name="Generalization_Line" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Dependency">
						<xsl:call-template name="Dependency_Line" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Association">
						<xsl:call-template name="Association_Line" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Abstraction">
						<xsl:call-template name="Abstraction_Line" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'CommentLink'">
						<xsl:call-template name="Comment_Line" />
					</xsl:when>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:ClassifierRole">
						<xsl:call-template name="ClassifierRole_Line" />
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>
</xsl:stylesheet>