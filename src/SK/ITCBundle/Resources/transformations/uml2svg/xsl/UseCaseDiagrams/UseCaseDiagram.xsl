<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: UseCaseDiagram2SVG.xsl Processes UseCase Diagrams -->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:import href="../UseCaseDiagrams/PackageUseCase.xsl" />
	<xsl:import href="../ClassDiagrams/Class.xsl" />
	<xsl:import href="../UseCaseDiagrams/Actor.xsl" />
	<xsl:import href="../UseCaseDiagrams/UseCase.xsl" />
	<xsl:import href="../UseCaseDiagrams/Collaboration.xsl" />
	<xsl:import href="../Common/Comment.xsl" />
	<xsl:import href="../Common/Lines.xsl" />
	<xsl:import href="../Common/Ellipse.xsl" />
	<xsl:import href="../Common/Polyline.xsl" />
	<xsl:import href="../Common/FreeText.xsl" />
	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

	<!-- UseCaseDiagram -->
	<xsl:template
		match="*[UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'UseCaseDiagram']">

		<title>
			<xsl:value-of select="@name" />
		</title>
		<desc>UseCase diagram</desc>

		<!-- Contained nodes -->
		<xsl:for-each select="UML:GraphElement.contained/*">
			<xsl:choose>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Package or UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Model">
					<xsl:call-template name="PackageUseCase" />
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
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:UseCase">
					<xsl:call-template name="UseCase" />
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
					test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'FreeText'">
					<xsl:call-template name="FreeText" />
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
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Extend">
					<xsl:call-template name="Extend_Line" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Include">
					<xsl:call-template name="Include_Line" />
				</xsl:when>

				<xsl:when test="self::UML:Ellipse">
					<xsl:call-template name="Ellipse" />
				</xsl:when>
				<xsl:when test="self::UML:Polyline">
					<xsl:call-template name="Polyline" />
				</xsl:when>

				<xsl:when
					test="namespace-uri(../../UML:Diagram.owner/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*) = 'org.omg.xmi.namespace.UML2' and UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NameCompartment'">
					<xsl:call-template name="NameCompartment">
						<xsl:with-param
							name="OwnerSemanticID"
							select="../../@xmi.id" />
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>