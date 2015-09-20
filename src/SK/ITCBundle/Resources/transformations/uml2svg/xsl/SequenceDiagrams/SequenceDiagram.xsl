<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: SequenceDiagram2SVG.xsl Processes Sequence Diagrams -->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML"
	xmlns:UML2="org.omg.xmi.namespace.UML2">
	<xsl:import href="../SequenceDiagrams/ObjectSequence.xsl" />
	<xsl:import href="../SequenceDiagrams/Lifeline.xsl" />
	<xsl:import href="../Common/Comment.xsl" />
	<xsl:import href="../Common/Lines.xsl" />
	<xsl:import href="../Common/Ellipse.xsl" />
	<xsl:import href="../Common/Polyline.xsl" />
	<xsl:import href="../Common/FreeText.xsl" />
	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

	<!-- SequenceDiagram -->
	<xsl:template
		match="*[UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'SequenceDiagram']">

		<title>
			<xsl:value-of select="@name" />
		</title>
		<desc>Sequence diagram</desc>

		<!-- Contained nodes -->
		<xsl:for-each select="UML:GraphElement.contained/*">
			<xsl:choose>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Object">
					<xsl:call-template name="ObjectSequence" />
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
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Link">
					<xsl:call-template name="LinkSequence_Line" />
				</xsl:when>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'CommentLink'">
					<xsl:call-template name="Comment_Line" />
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

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:Lifeline">
					<xsl:call-template name="Lifeline" />
				</xsl:when>

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:Message">
					<xsl:call-template name="Message_Line" />
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>