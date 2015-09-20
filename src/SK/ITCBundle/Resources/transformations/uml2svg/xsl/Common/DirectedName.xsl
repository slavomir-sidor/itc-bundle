<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: DirectedName.xsl * used in: Sequence Diagrams -->

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
	<xsl:template name="DirectedName">
		<xsl:param
			name="OwnerSemanticID"
			select="../../UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- Main DirectedName group -->
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
				<xsl:text>DirectedName for </xsl:text>
				<xsl:value-of select="$OwnerSemanticID" />
			</title>
			<desc>
				<xsl:text>DirectedName</xsl:text>
			</desc>

			<!-- NameAndType text should be underlined -->

			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'MessageOrdering'">
						<xsl:variable
							name="Message"
							select="key('xmi.id', $OwnerSemanticID)" />

						<xsl:variable
							name="ExecutionOccurrenceID"
							select="(key('xmi.id', $Message/UML2:Message.receiveEvent/UML2:EventOccurrence/@xmi.idref)/UML2:EventOccurrence.startExec | key('xmi.id', $Message/UML2:Message.sendEvent/UML2:EventOccurrence/@xmi.idref)/UML2:EventOccurrence.finishExec)/UML2:ExecutionOccurrence[1]/@xmi.idref" />

						<xsl:if test="$ExecutionOccurrenceID">
							<xsl:variable
								name="ExecutionOccurrence"
								select="key('xmi.id', $ExecutionOccurrenceID)" />

							<xsl:variable name="Count">
								<xsl:value-of
									select="count($ExecutionOccurrence/preceding-sibling::UML2:ExecutionOccurrence)+1" />
							</xsl:variable>

							<xsl:call-template name="Text">
								<xsl:with-param
									name="String"
									select="concat($Count,')')" />
							</xsl:call-template>
						</xsl:if>
					</xsl:when>


					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'MessageSeparator'">
						<!-- Message separator: '.' -->
						<xsl:call-template name="Text">
							<xsl:with-param
								name="String"
								select="$MessageSeparator" />
							<xsl:with-param
								name="FontWeight"
								select="'bold'" />
						</xsl:call-template>
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
						<xsl:call-template name="Name" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Signature'">
						<g
							id="{@xmi.id}"
							transform="translate({UML:GraphElement.position/XMI.field[1]}, {UML:GraphElement.position/XMI.field[2]})">
							<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
								<xsl:choose>
									<xsl:when
										test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Operation">
										<xsl:call-template name="Operation" />
									</xsl:when>
								</xsl:choose>
							</xsl:for-each>
						</g>
					</xsl:when>

				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>
</xsl:stylesheet>
