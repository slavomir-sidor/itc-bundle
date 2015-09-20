<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: Lines.xsl Templates used for displaying lines -->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:import href="Globals.xsl" />
	<xsl:import href="Styling.xsl" />
	<xsl:import href="Arrowheads.xsl" />
	<xsl:import href="Visibility.xsl" />
	<xsl:import href="Multiplicity.xsl" />
	<xsl:import href="StereotypeCompartment.xsl" />
	<xsl:import href="ExpressionCompartment.xsl" />
	<xsl:import href="DirectedName.xsl" />
	<xsl:import href="../StateDiagrams/TransitionDescription.xsl" />
	<xsl:import href="../StateDiagrams/StateTransitionDescription.xsl" />
	<xsl:import href="../CollaborationDiagrams/StimuliArrows.xsl" />
	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

	<!-- Generalization line, displayed as a simple line with an empty triangle at the 
		endpoint -->
	<xsl:template name="Generalization_Line">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
		<xsl:variable name="PathData">
			<xsl:call-template name="BuildPathData" />
		</xsl:variable>

		<!-- The main generalization group -->
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
				Generalization line
				<xsl:value-of select="$SemanticID" />
			</title>
			<desc>
				Generalization:
				<xsl:value-of
					select="key('xmi.id', $SemanticID)/UML:Generalization.child/*/@xmi.idref" />
				-&gt;
				<xsl:value-of
					select="key('xmi.id', $SemanticID)/UML:Generalization.parent/*/@xmi.idref" />
			</desc>

			<!-- The generalization marker -->
			<xsl:call-template name="GeneralizationArrowhead">
				<xsl:with-param
					name="OwnerDiagramID"
					select="@xmi.id" />
			</xsl:call-template>

			<path
				d="{$PathData}"
				fill="none"
				marker-end="url(#GeneralizationArrowhead{@xmi.id})" />

			<!-- Display edge properties -->
			<xsl:call-template name="EdgeText">
				<xsl:with-param
					name="OwnerSemanticID"
					select="$SemanticID" />
			</xsl:call-template>
		</g>
	</xsl:template>

	<!-- Dependency line, displayed as a dashed line with a simple arrowhead at the 
		endpoint -->
	<xsl:template name="Dependency_Line">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
		<xsl:variable name="PathData">
			<xsl:call-template name="BuildPathData" />
		</xsl:variable>

		<!-- The main Dependency group -->
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
				Dependency line
				<xsl:value-of select="$SemanticID" />
			</title>
			<desc>
				Dependency:
				<xsl:value-of
					select="key('xmi.id', $SemanticID)/UML:Dependency.client/*/@xmi.idref" />
				-&gt;
				<xsl:value-of
					select="key('xmi.id', $SemanticID)/UML:Dependency.supplier/*/@xmi.idref" />
			</desc>

			<!-- The dependency marker -->
			<xsl:call-template name="DependencyArrowhead">
				<xsl:with-param
					name="OwnerDiagramID"
					select="@xmi.id" />
			</xsl:call-template>
			<path
				d="{$PathData}"
				fill="none"
				style="stroke-dasharray: 6 10"
				marker-end="url(#DependencyArrowhead{@xmi.id})" />

			<!-- Display edge properties -->
			<xsl:call-template name="EdgeText">
				<xsl:with-param
					name="OwnerSemanticID"
					select="$SemanticID" />
			</xsl:call-template>
		</g>
	</xsl:template>

	<!-- Association line, displayed as a simple line -->
	<!-- Multiple semantics: aggregation, composition, direction -->
	<xsl:template name="Association_Line">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
		<xsl:variable name="PathData">
			<xsl:call-template name="BuildPathData" />
		</xsl:variable>

		<!-- Determine the type of the association from the AssociationEnds -->

		<!-- Association direction -->
		<xsl:variable name="TraversableFrom">
			<xsl:value-of
				select="key('xmi.id', $SemanticID)/UML:Association.connection/UML:AssociationEnd[1]/@isNavigable"></xsl:value-of>
		</xsl:variable>
		<xsl:variable name="TraversableTo">
			<xsl:value-of
				select="key('xmi.id', $SemanticID)/UML:Association.connection/UML:AssociationEnd[2]/@isNavigable"></xsl:value-of>
		</xsl:variable>
		<xsl:variable name="Traversable">
			<xsl:choose>
				<xsl:when test="($TraversableFrom = 'true') and ($TraversableTo = 'true')">
					<xsl:text>Both</xsl:text>
				</xsl:when>
				<xsl:when test="($TraversableFrom = 'true') and ($TraversableTo = 'false')">
					<xsl:text>From</xsl:text>
				</xsl:when>
				<xsl:when test="($TraversableFrom = 'false') and ($TraversableTo = 'true')">
					<xsl:text>To</xsl:text>
				</xsl:when>
				<xsl:when test="($TraversableFrom = 'false') and ($TraversableTo = 'false')">
					<xsl:text>None</xsl:text>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>

		<!-- Aggregation -->
		<xsl:variable name="Aggregation">
			<xsl:choose>
				<xsl:when
					test="key('xmi.id', $SemanticID)/UML:Association.connection/UML:AssociationEnd[(position() = 1) and (@aggregation = 'aggregate')]">
					<xsl:text>From</xsl:text>
				</xsl:when>
				<xsl:when
					test="key('xmi.id', $SemanticID)/UML:Association.connection/UML:AssociationEnd[(position() = 2) and (@aggregation = 'aggregate')]">
					<xsl:text>To</xsl:text>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>

		<!-- Composition -->
		<xsl:variable name="Composition">
			<xsl:choose>
				<xsl:when
					test="key('xmi.id', $SemanticID)/UML:Association.connection/UML:AssociationEnd[(position() = 1) and (@aggregation = 'composite')]">
					<xsl:text>From</xsl:text>
				</xsl:when>
				<xsl:when
					test="key('xmi.id', $SemanticID)/UML:Association.connection/UML:AssociationEnd[(position() = 2) and (@aggregation = 'composite')]">
					<xsl:text>To</xsl:text>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>

		<!-- Determine the line's end marker -->
		<xsl:variable name="marker-end">
			<xsl:choose>
				<xsl:when test="$Traversable = 'To'">
					<xsl:choose>
						<xsl:when test="$Aggregation = 'To'">
							<xsl:text>DirectedAggregationArrowheadEnd</xsl:text>
						</xsl:when>
						<xsl:when test="$Composition = 'To'">
							<xsl:text>DirectedCompositionArrowheadEnd</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>DirectedArrowheadEnd</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="$Aggregation = 'To'">
							<xsl:text>AggregationArrowheadEnd</xsl:text>
						</xsl:when>
						<xsl:when test="$Composition = 'To'">
							<xsl:text>CompositionArrowheadEnd</xsl:text>
						</xsl:when>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<!-- Determine the line's start marker -->
		<xsl:variable name="marker-start">
			<xsl:choose>
				<xsl:when test="$Traversable = 'From'">
					<xsl:choose>
						<xsl:when test="$Aggregation = 'From'">
							<xsl:text>DirectedAggregationArrowheadStart</xsl:text>
						</xsl:when>
						<xsl:when test="$Composition = 'From'">
							<xsl:text>DirectedCompositionArrowheadStart</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>DirectedArrowheadStart</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="$Aggregation = 'From'">
							<xsl:text>AggregationArrowheadStart</xsl:text>
						</xsl:when>
						<xsl:when test="$Composition = 'From'">
							<xsl:text>CompositionArrowheadStart</xsl:text>
						</xsl:when>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<!-- The main Association group -->
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
				Association line
				<xsl:value-of select="$SemanticID" />
			</title>
			<desc>
				Association:
				<xsl:value-of
					select="key('xmi.id', $SemanticID)/UML:Association.connection/UML:AssociationEnd[1]/UML:AssociationEnd.participant/*/@xmi.idref" />
				<xsl:if test="$Aggregation = 'From'">
					<xsl:text> (Aggregation)</xsl:text>
				</xsl:if>
				<xsl:if test="$Composition = 'From'">
					<xsl:text> (Composition)</xsl:text>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="$Traversable = 'Both'">
						&lt;-&gt;
					</xsl:when>
					<xsl:when test="$Traversable = 'From'">
						-&gt;
					</xsl:when>
					<xsl:when test="$Traversable = 'To'">
						&lt;-
					</xsl:when>
					<xsl:when test="$Traversable = 'None'">
						--
					</xsl:when>
				</xsl:choose>
				<xsl:value-of
					select="key('xmi.id', $SemanticID)/UML:Association.connection/UML:AssociationEnd[2]/UML:AssociationEnd.participant/*/@xmi.idref" />
				<xsl:if test="$Aggregation = 'To'">
					<xsl:text> (Aggregation)</xsl:text>
				</xsl:if>
				<xsl:if test="$Composition = 'To'">
					<xsl:text> (Composition)</xsl:text>
				</xsl:if>
			</desc>

			<xsl:if test="$marker-start != ''">
				<xsl:choose>
					<xsl:when test="$marker-start = 'DirectedArrowheadStart'">
						<xsl:call-template name="DirectedArrowheadStart">
							<xsl:with-param
								name="OwnerDiagramID"
								select="@xmi.id" />
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="$marker-start = 'DirectedAggregationArrowheadStart'">
						<xsl:call-template name="DirectedAggregationArrowheadStart">
							<xsl:with-param
								name="OwnerDiagramID"
								select="@xmi.id" />
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="$marker-start = 'DirectedCompositionArrowheadStart'">
						<xsl:call-template name="DirectedCompositionArrowheadStart">
							<xsl:with-param
								name="OwnerDiagramID"
								select="@xmi.id" />
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="$marker-start = 'AggregationArrowheadStart'">
						<xsl:call-template name="AggregationArrowheadStart">
							<xsl:with-param
								name="OwnerDiagramID"
								select="@xmi.id" />
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="$marker-start = 'CompositionArrowheadStart'">
						<xsl:call-template name="CompositionArrowheadStart">
							<xsl:with-param
								name="OwnerDiagramID"
								select="@xmi.id" />
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
			</xsl:if>
			<xsl:if test="$marker-end != ''">
				<xsl:choose>
					<xsl:when test="$marker-end = 'DirectedArrowheadEnd'">
						<xsl:call-template name="DirectedArrowheadEnd">
							<xsl:with-param
								name="OwnerDiagramID"
								select="@xmi.id" />
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="$marker-end = 'DirectedAggregationArrowheadEnd'">
						<xsl:call-template name="DirectedAggregationArrowheadEnd">
							<xsl:with-param
								name="OwnerDiagramID"
								select="@xmi.id" />
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="$marker-end = 'DirectedCompositionArrowheadEnd'">
						<xsl:call-template name="DirectedCompositionArrowheadEnd">
							<xsl:with-param
								name="OwnerDiagramID"
								select="@xmi.id" />
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="$marker-end = 'AggregationArrowheadEnd'">
						<xsl:call-template name="AggregationArrowheadEnd">
							<xsl:with-param
								name="OwnerDiagramID"
								select="@xmi.id" />
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="$marker-end = 'CompositionArrowheadEnd'">
						<xsl:call-template name="CompositionArrowheadEnd">
							<xsl:with-param
								name="OwnerDiagramID"
								select="@xmi.id" />
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
			</xsl:if>

			<!-- Association line -->
			<path
				d="{$PathData}"
				fill="none">
				<xsl:if test="$marker-start != ''">
					<xsl:attribute name="marker-start">
						<xsl:text>url(#</xsl:text><xsl:value-of select="$marker-start" /><xsl:value-of
						select="@xmi.id" /><xsl:text>)</xsl:text>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="$marker-end != ''">
					<xsl:attribute name="marker-end">
						<xsl:text>url(#</xsl:text><xsl:value-of select="$marker-end" /><xsl:value-of
						select="@xmi.id" /><xsl:text>)</xsl:text>
					</xsl:attribute>
				</xsl:if>
			</path>

			<!-- Display edge properties -->
			<xsl:call-template name="EdgeText">
				<xsl:with-param
					name="OwnerSemanticID"
					select="$SemanticID" />
			</xsl:call-template>
		</g>
	</xsl:template>

	<!-- AssociationClassEdge line, displayed as a dashed line -->
	<xsl:template name="AssociationClassEdge_Line">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
		<xsl:variable name="PathData">
			<xsl:call-template name="BuildPathData" />
		</xsl:variable>

		<!-- The main Link group -->
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
				Link line
				<xsl:value-of select="$SemanticID" />
			</title>
			<desc>
				Link:
				<xsl:value-of
					select="key('xmi.id', $SemanticID)/UML:LinkEnd.instance[1]/*/@xmi.idref" />
				--
				<xsl:value-of
					select="key('xmi.id', $SemanticID)/UML:LinkEnd.instance[2]/*/@xmi.idref" />
			</desc>

			<!-- The Link line -->
			<path
				d="{$PathData}"
				fill="none"
				stroke-dasharray="6 12" />
		</g>
	</xsl:template>

	<!-- Abstraction line, displayed as a dashed line with a white triangle at the endpoint -->
	<xsl:template name="Abstraction_Line">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
		<xsl:variable name="PathData">
			<xsl:call-template name="BuildPathData" />
		</xsl:variable>

		<!-- The main Abstraction group -->
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
				Abstraction line
				<xsl:value-of select="$SemanticID" />
			</title>
			<desc>
				Abstraction:
				<xsl:value-of
					select="key('xmi.id', $SemanticID)/UML:Dependency.client/*/@xmi.idref" />
				-&gt;
				<xsl:value-of
					select="key('xmi.id', $SemanticID)/UML:Dependency.supplier/*/@xmi.idref" />
			</desc>

			<!-- The Abstraction marker -->
			<xsl:call-template name="GeneralizationArrowhead">
				<xsl:with-param
					name="OwnerDiagramID"
					select="@xmi.id" />
			</xsl:call-template>

			<!-- The Abstraction line -->
			<path
				d="{$PathData}"
				fill="none"
				marker-end="url(#GeneralizationArrowhead{@xmi.id})"
				stroke-dasharray="6 9" />

			<!-- Display edge properties -->
			<xsl:call-template name="EdgeText">
				<xsl:with-param
					name="OwnerSemanticID"
					select="$SemanticID" />
			</xsl:call-template>
		</g>
	</xsl:template>

	<!-- Comment line, displayed as a dashed line -->
	<xsl:template name="Comment_Line">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@xmi.id" />
		<xsl:variable name="PathData">
			<xsl:call-template name="BuildPathData" />
		</xsl:variable>

		<!-- The main comment line group -->
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
				Comment line
				<xsl:value-of select="$SemanticID" />
			</title>
			<desc>Main Comment line group</desc>

			<!-- Comment line -->
			<path
				d="{$PathData}"
				fill="none"
				stroke-dasharray="6 4" />
		</g>
	</xsl:template>

	<!-- ClassifierRole line, displayed as a dashed line -->
	<xsl:template name="ClassifierRole_Line">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
		<xsl:variable name="PathData">
			<xsl:call-template name="BuildPathData" />
		</xsl:variable>

		<!-- The main ClassifierRole group -->
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
				ClassifierRole line
				<xsl:value-of select="$SemanticID" />
			</title>
			<desc>
				ClassifierRole:
				<xsl:value-of
					select="key('xmi.id', $SemanticID)/UML:ClassifierRole.base/*/@xmi.idref" />
				-&gt;
				<xsl:value-of select="key('xmi.id', $SemanticID)/../../@xmi.id" />
			</desc>

			<!-- ClasifierRole line -->
			<path
				d="{$PathData}"
				fill="none"
				stroke-dasharray="6 4" />

			<!-- Display edge properties -->
			<xsl:call-template name="EdgeText">
				<xsl:with-param
					name="OwnerSemanticID"
					select="$SemanticID" />
			</xsl:call-template>
		</g>
	</xsl:template>

	<!-- Extend line, displayed as a dashed line with a simple arrowhead at the endpoint -->
	<xsl:template name="Extend_Line">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
		<xsl:variable name="PathData">
			<xsl:call-template name="BuildPathData" />
		</xsl:variable>

		<!-- The main Extend group -->
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
				Extend line
				<xsl:value-of select="$SemanticID" />
			</title>
			<desc>
				Extend:
				<xsl:value-of select="key('xmi.id', $SemanticID)/UML:Extend.extension/*/@xmi.idref" />
				-&gt;
				<xsl:value-of select="key('xmi.id', $SemanticID)/UML:Extend.base/*/@xmi.idref" />
			</desc>

			<!-- The Extend marker -->
			<xsl:call-template name="DependencyArrowhead">
				<xsl:with-param
					name="OwnerDiagramID"
					select="@xmi.id" />
			</xsl:call-template>

			<!-- The Extend line -->
			<path
				d="{$PathData}"
				fill="none"
				marker-end="url(#DependencyArrowhead{@xmi.id})"
				stroke-dasharray="6 6" />

			<!-- Display edge properties -->
			<xsl:call-template name="EdgeText">
				<xsl:with-param
					name="OwnerSemanticID"
					select="$SemanticID" />
			</xsl:call-template>
		</g>
	</xsl:template>

	<!-- Include line, displayed as a dashed line with a simple arrowhead at the endpoint -->
	<xsl:template name="Include_Line">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
		<xsl:variable name="PathData">
			<xsl:call-template name="BuildPathData" />
		</xsl:variable>

		<!-- The main Include group -->
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
				Include line
				<xsl:value-of select="$SemanticID" />
			</title>
			<desc>
				Include:
				<xsl:value-of select="key('xmi.id', $SemanticID)/UML:Include.addition/*/@xmi.idref" />
				-&gt;
				<xsl:value-of select="key('xmi.id', $SemanticID)/UML:Include.base/*/@xmi.idref" />
			</desc>

			<!-- The Include marker -->
			<xsl:call-template name="DependencyArrowhead">
				<xsl:with-param
					name="OwnerDiagramID"
					select="@xmi.id" />
			</xsl:call-template>

			<!-- The Include line -->
			<path
				d="{$PathData}"
				fill="none"
				marker-end="url(#DependencyArrowhead{@xmi.id})"
				stroke-dasharray="6 6" />

			<!-- Display edge properties -->
			<xsl:call-template name="EdgeText">
				<xsl:with-param
					name="OwnerSemanticID"
					select="$SemanticID" />
			</xsl:call-template>
		</g>
	</xsl:template>

	<!-- Link line from Collaboration diagrams, displayed as a simple line -->
	<xsl:template name="Link_Line">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
		<xsl:variable name="PathData">
			<xsl:call-template name="BuildPathData" />
		</xsl:variable>

		<!-- The main Link group -->
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
				Link line
				<xsl:value-of select="$SemanticID" />
			</title>
			<desc>
				Link:
				<xsl:value-of
					select="key('xmi.id', $SemanticID)/UML:LinkEnd.instance[1]/*/@xmi.idref" />
				--
				<xsl:value-of
					select="key('xmi.id', $SemanticID)/UML:LinkEnd.instance[2]/*/@xmi.idref" />
			</desc>

			<!-- The Link line -->
			<path
				d="{$PathData}"
				fill="none" />

			<!-- Display edge properties -->
			<xsl:call-template name="EdgeText">
				<xsl:with-param
					name="OwnerSemanticID"
					select="$SemanticID" />
			</xsl:call-template>
		</g>
	</xsl:template>

	<!-- Link line from Sequence diagrams -->
	<xsl:template name="LinkSequence_Line">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Link/@xmi.idref" />
		<xsl:variable name="PathData">
			<xsl:call-template name="BuildPathData" />
		</xsl:variable>

		<!-- <xsl:variable name="StimulusSemanticID" select="UML:GraphElement.contained/*[UML:GraphElement.semanticModel//UML:Stimulus]/UML:GraphElement.semanticModel//*[@xmi.idref]/@xmi.idref"/> -->
		<xsl:variable
			name="StimulusSemanticID"
			select="UML:GraphElement.contained/UML:GraphNode/UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Stimulus/@xmi.idref" />
		<xsl:variable
			name="ActionSemanticID"
			select="key('xmi.id', $StimulusSemanticID)/UML:Stimulus.dispatchAction/*/@xmi.idref" />
		<xsl:variable name="LinkType">
			<xsl:choose>
				<xsl:when test="key('xmi.id', $ActionSemanticID)/self::UML:ReturnAction">
					Return
				</xsl:when>
				<xsl:when test="key('xmi.id', $ActionSemanticID)/@isAsynchronous = 'true'">
					Asynchronous
				</xsl:when>
				<xsl:otherwise>
					Synchronous
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<!-- The main Link group -->
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

			<xsl:variable
				name="Sender"
				select="key('xmi.id', $StimulusSemanticID)/UML:Stimulus.sender/*/@xmi.idref" />
			<xsl:variable
				name="Receiver"
				select="key('xmi.id', $StimulusSemanticID)/UML:Stimulus.receiver/*/@xmi.idref" />

			<xsl:variable
				name="Connector1"
				select="UML:GraphEdge.anchor/UML:GraphConnector[1]/@xmi.idref" />
			<xsl:variable
				name="Connector2"
				select="UML:GraphEdge.anchor/UML:GraphConnector[2]/@xmi.idref" />

			<xsl:variable
				name="Object1"
				select="key('xmi.id', $Connector1)/ancestor::UML:GraphNode[UML:GraphElement.semanticModel//UML:Object][1]/UML:GraphElement.semanticModel//UML:Object/@xmi.idref" />
			<xsl:variable
				name="Object2"
				select="key('xmi.id', $Connector2)/ancestor::UML:GraphNode[UML:GraphElement.semanticModel//UML:Object][1]/UML:GraphElement.semanticModel//UML:Object/@xmi.idref" />

			<title>
				Link line
				<xsl:value-of select="$SemanticID" />
			</title>
			<desc>
				Link:
				<xsl:value-of select="key('xmi.id', $Sender)/@name" />
				&lt;-&gt;
				<xsl:value-of select="key('xmi.id', $Receiver)/@name" />
			</desc>

			<xsl:variable name="FirstOne">
				<xsl:choose>
					<xsl:when test="$Object1 = $Object2">
						<xsl:variable
							name="Y1"
							select="UML:GraphEdge.waypoints/XMI.field[1]/XMI.field[2]" />
						<xsl:variable
							name="Y2"
							select="UML:GraphEdge.waypoints/XMI.field[last()-2]/XMI.field[2]" />
						<xsl:choose>
							<xsl:when test="$Y1 &gt; $Y2">
								receiver
							</xsl:when>
							<xsl:otherwise>
								sender
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="$Object1 = $Receiver and $Object2 = $Sender">
								receiver
							</xsl:when>
							<xsl:otherwise>
								sender
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<!-- <xsl:message>FirstOne:<xsl:value-of select="$FirstOne"/></xsl:message> -->

			<xsl:choose>
				<xsl:when test="$FirstOne = 'receiver'">
					<xsl:choose>
						<xsl:when test="$LinkType = 'Synchronous'">
							<xsl:call-template name="SynchronousArrowheadStart">
								<xsl:with-param
									name="OwnerDiagramID"
									select="@xmi.id" />
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="AsynchronousArrowheadStart">
								<xsl:with-param
									name="OwnerDiagramID"
									select="@xmi.id" />
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
					<!-- The Link line -->
					<path
						d="{$PathData}"
						fill="none">
						<xsl:choose>
							<xsl:when test="$LinkType = 'Return'">
								<xsl:attribute name="stroke-dasharray"><xsl:text>15 12</xsl:text></xsl:attribute>
								<xsl:attribute name="marker-start"><xsl:text>url(#AsynchronousArrowheadStart</xsl:text><xsl:value-of
									select="@xmi.id" />)</xsl:attribute>
							</xsl:when>
							<xsl:when test="$LinkType = 'Asynchronous'">
								<xsl:attribute name="marker-start"><xsl:text>url(#AsynchronousArrowheadStart</xsl:text><xsl:value-of
									select="@xmi.id" />)</xsl:attribute>
							</xsl:when>
							<xsl:when test="$LinkType = 'Synchronous'">
								<xsl:attribute name="marker-start"><xsl:text>url(#SynchronousArrowheadStart</xsl:text><xsl:value-of
									select="@xmi.id" />)</xsl:attribute>
							</xsl:when>
						</xsl:choose>
					</path>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="$LinkType = 'Synchronous'">
							<xsl:call-template name="SynchronousArrowheadEnd">
								<xsl:with-param
									name="OwnerDiagramID"
									select="@xmi.id" />
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="AsynchronousArrowheadEnd">
								<xsl:with-param
									name="OwnerDiagramID"
									select="@xmi.id" />
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
					<!-- The Link line -->
					<path
						d="{$PathData}"
						fill="none">
						<xsl:choose>
							<xsl:when test="$LinkType = 'Return'">
								<xsl:attribute name="stroke-dasharray"><xsl:text>15 12</xsl:text></xsl:attribute>
								<xsl:attribute name="marker-end"><xsl:text>url(#AsynchronousArrowheadEnd</xsl:text><xsl:value-of
									select="@xmi.id" />)</xsl:attribute>
							</xsl:when>
							<xsl:when test="$LinkType = 'Asynchronous'">
								<xsl:attribute name="marker-end"><xsl:text>url(#AsynchronousArrowheadEnd</xsl:text><xsl:value-of
									select="@xmi.id" />)</xsl:attribute>
							</xsl:when>
							<xsl:when test="$LinkType = 'Synchronous'">
								<xsl:attribute name="marker-end"><xsl:text>url(#SynchronousArrowheadEnd</xsl:text><xsl:value-of
									select="@xmi.id" />)</xsl:attribute>
							</xsl:when>
						</xsl:choose>
					</path>
				</xsl:otherwise>
			</xsl:choose>

			<!-- Display edge properties -->
			<xsl:call-template name="EdgeText">
				<xsl:with-param
					name="OwnerSemanticID"
					select="$SemanticID" />
			</xsl:call-template>
		</g>
	</xsl:template>

	<!-- Message line from Sequence diagrams -->
	<xsl:template name="Message_Line">

		<xsl:variable name="PathData">
			<xsl:call-template name="BuildPathData" />
		</xsl:variable>

		<xsl:variable
			name="MessageSemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:Message/@xmi.idref" />

		<xsl:variable
			name="Message"
			select="key('xmi.id', $MessageSemanticID)" />

		<!-- MessageSort in {synchCall, asynchCall} -->
		<xsl:variable
			name="MessageSort"
			select="key('xmi.id', $MessageSemanticID)/@messageSort" />

		<!-- The main Link group -->
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
				Message line:
				<xsl:value-of select="$MessageSemanticID" />
			</title>
			<desc></desc>

			<xsl:choose>
				<xsl:when test="$MessageSort = 'synchCall'">
					<xsl:call-template name="SynchronousArrowheadEnd">
						<xsl:with-param
							name="OwnerDiagramID"
							select="@xmi.id" />
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="$MessageSort = 'asynchCall'">
					<xsl:call-template name="AsynchronousArrowheadEnd">
						<xsl:with-param
							name="OwnerDiagramID"
							select="@xmi.id" />
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					Ignoring unknown message sort.
				</xsl:otherwise>
			</xsl:choose>

			<!-- The Link line -->
			<path
				d="{$PathData}"
				fill="none">
				<xsl:choose>
					<xsl:when test="$MessageSort = 'synchCall'">
						<xsl:attribute name="marker-end"><xsl:text>url(#SynchronousArrowheadEnd</xsl:text><xsl:value-of
							select="@xmi.id" />)</xsl:attribute>
						<xsl:choose>
							<xsl:when
								test="key('xmi.id', $Message/UML2:Message.receiveEvent/UML2:EventOccurrence/@xmi.idref)/UML2:EventOccurrence.startExec">
								<!-- Call -->
							</xsl:when>
							<xsl:when
								test="key('xmi.id', $Message/UML2:Message.sendEvent/UML2:EventOccurrence/@xmi.idref)/UML2:EventOccurrence.finishExec">
								<!-- Return -->
								<xsl:attribute name="stroke-dasharray"><xsl:text>15 12</xsl:text></xsl:attribute>
							</xsl:when>
							<xsl:otherwise>
								<xsl:message>
									Ignoring unknown synchCall message type.
								</xsl:message>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$MessageSort = 'asynchCall'">
						<xsl:attribute name="marker-end"><xsl:text>url(#AsynchronousArrowheadEnd</xsl:text><xsl:value-of
							select="@xmi.id" />)</xsl:attribute>
					</xsl:when>
				</xsl:choose>
			</path>

			<!-- Display edge properties -->
			<xsl:call-template name="EdgeText">
				<xsl:with-param
					name="OwnerSemanticID"
					select="$MessageSemanticID" />
			</xsl:call-template>
		</g>
	</xsl:template>
	<!-- Transition line, displayed as a simple line with a simple arrowhead -->
	<xsl:template name="Transition_Line">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
		<xsl:variable name="PathData">
			<xsl:call-template name="BuildPathData" />
		</xsl:variable>

		<!-- The main Transition group -->
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
				Transition line
				<xsl:value-of select="$SemanticID" />
			</title>
			<desc>
				Transition:
				<xsl:value-of
					select="key('xmi.id', $SemanticID)/UML:Transition.source/*/@xmi.idref" />
				-&gt;
				<xsl:value-of
					select="key('xmi.id', $SemanticID)/UML:Transition.target/*/@xmi.idref" />
			</desc>

			<!-- The transition marker -->
			<xsl:call-template name="DirectedArrowheadEnd">
				<xsl:with-param
					name="OwnerDiagramID"
					select="@xmi.id" />
			</xsl:call-template>

			<!-- The Transition line -->
			<path
				d="{$PathData}"
				fill="none"
				marker-end="url(#DirectedArrowheadEnd{@xmi.id})">
				<xsl:if
					test="key('xmi.id', $SemanticID)/UML:Transition.source/UML:ObjectFlowState or key('xmi.id', $SemanticID)/UML:Transition.target/UML:ObjectFlowState">
					<xsl:attribute name="stroke-dasharray"><xsl:text>5</xsl:text></xsl:attribute>
				</xsl:if>
			</path>

			<!-- Display edge properties -->
			<xsl:call-template name="EdgeText">
				<xsl:with-param
					name="OwnerSemanticID"
					select="$SemanticID" />
			</xsl:call-template>
		</g>
	</xsl:template>

	<!-- RequiredInterfaceEdge line, displayed as a dashed line with a white triangle 
		marker -->
	<xsl:template name="RequiredInterfaceEdge">

		<xsl:variable name="PathData">
			<xsl:call-template name="BuildPathData" />
		</xsl:variable>

		<!-- The main RequiredInterfaceEdge group -->
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

			<title>RequiredInterfaceEdge line</title>
			<desc>RequiredInterfaceEdge</desc>

			<!-- The RequiredInterfaceEdge line -->
			<!-- The dependency marker -->
			<xsl:call-template name="DependencyArrowhead">
				<xsl:with-param
					name="OwnerDiagramID"
					select="@xmi.id" />
			</xsl:call-template>
			<path
				d="{$PathData}"
				fill="none"
				style="stroke-dasharray: 6 10"
				marker-end="url(#DependencyArrowhead{@xmi.id})" />
		</g>
	</xsl:template>

	<!-- ProvidedInterfaceEdge line, displayed as a simple line -->
	<xsl:template name="ProvidedInterfaceEdge">

		<xsl:variable name="PathData">
			<xsl:call-template name="BuildPathData" />
		</xsl:variable>

		<!-- The main ProvidedInterfaceEdge group -->
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

			<title>ProvidedInterfaceEdge line</title>
			<desc>ProvidedInterfaceEdge</desc>

			<!-- The RequiredInterfaceEdge line -->
			<path
				d="{$PathData}"
				fill="none" />
		</g>
	</xsl:template>

	<xsl:template name="EdgeText">
		<xsl:param name="OwnerSemanticID" />
		<!-- Edge properties -->
		<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
			<xsl:choose>
				<xsl:when
					test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'StereotypeCompartment'">
					<!-- Stereotype compartment -->
					<xsl:call-template name="StereotypeCompartment">
						<xsl:with-param
							name="OwnerSemanticID"
							select="$OwnerSemanticID" />
					</xsl:call-template>
				</xsl:when>

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
					<!-- Name -->
					<xsl:call-template name="Name">
						<xsl:with-param
							name="OwnerSemanticID"
							select="$OwnerSemanticID" />
					</xsl:call-template>
				</xsl:when>

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'DirectedName'">
					<xsl:call-template name="DirectedName" />
				</xsl:when>

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'KeywordMetaclass'">
					<!-- Metaclass -> Extend / Include -->
					<xsl:call-template name="Text">
						<xsl:with-param name="String">
							<xsl:choose>
								<xsl:when test="key('xmi.id', $OwnerSemanticID)/self::UML:Extend">
									<xsl:value-of select="'extend'" />
								</xsl:when>
								<xsl:when test="key('xmi.id', $OwnerSemanticID)/self::UML:Include">
									<xsl:value-of select="'include'" />
								</xsl:when>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:AssociationEnd">
					<!-- Endpoints -->
					<xsl:variable
						name="EndpointSemanticID"
						select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />
					<g
						id="{$EndpointSemanticID}"
						transform="translate({UML:GraphElement.position/XMI.field[1]}, {UML:GraphElement.position/XMI.field[2]})">
						<xsl:apply-templates
							select="."
							mode="FontStyle" />
						<xsl:apply-templates
							select="."
							mode="isVisible" />

						<title>
							<xsl:text>Endpoint </xsl:text>
							<xsl:value-of select="$EndpointSemanticID" />
						</title>
						<desc>
							<xsl:text>Endpoint</xsl:text>
						</desc>

						<!-- Contained nodes -->
						<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
							<xsl:choose>
								<xsl:when
									test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
									<xsl:call-template name="Name">
										<xsl:with-param
											name="OwnerSemanticID"
											select="$EndpointSemanticID" />
										<xsl:with-param name="TextDecoration">
											<xsl:if
												test="key('xmi.id', $EndpointSemanticID)/@targetScope = 'classifier'">
												<xsl:text>underline</xsl:text>
											</xsl:if>
										</xsl:with-param>
									</xsl:call-template>
								</xsl:when>

								<xsl:when
									test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Visibility'">
									<!-- Endpoint Visibility -->
									<!-- Main Visibility group -->
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
											<xsl:text>Visibility for </xsl:text>
											<xsl:value-of select="$EndpointSemanticID" />
										</title>
										<desc>
											<xsl:text>Visibility</xsl:text>
										</desc>

										<!-- Visibility text -->
										<xsl:call-template name="Text">
											<xsl:with-param name="String">
												<xsl:call-template name="Visibility">
													<xsl:with-param
														name="OwnerSemanticID"
														select="$EndpointSemanticID" />
												</xsl:call-template>
											</xsl:with-param>
											<xsl:with-param
												name="x"
												select="0" />
											<xsl:with-param
												name="y"
												select="0" />
										</xsl:call-template>
									</g>
								</xsl:when>

								<xsl:when
									test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Multiplicity'">
									<!-- Endpoint Multiplicity -->
									<!-- Main Multiplicity group -->
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
											<xsl:text>Multiplicity </xsl:text>
											<xsl:value-of select="$EndpointSemanticID" />
										</title>
										<desc>
											<xsl:text>Multiplicity</xsl:text>
										</desc>

										<!-- Multiplicity text -->
										<xsl:call-template name="Text">
											<xsl:with-param name="String">
												<xsl:call-template name="Multiplicity">
													<xsl:with-param
														name="OwnerSemanticID"
														select="$EndpointSemanticID" />
												</xsl:call-template>
											</xsl:with-param>
											<xsl:with-param
												name="x"
												select="0" />
											<xsl:with-param
												name="y"
												select="0" />
										</xsl:call-template>
									</g>
								</xsl:when>

								<xsl:when
									test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'ExpressionCompartment'">
									<!-- Endpoint expressions -->
									<xsl:call-template name="ExpressionCompartment">
										<xsl:with-param
											name="OwnerSemanticID"
											select="$EndpointSemanticID" />
									</xsl:call-template>
								</xsl:when>
							</xsl:choose>
						</xsl:for-each>
					</g>
				</xsl:when>

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Stimulus">
					<!-- Link Stimulus -->
					<xsl:variable
						name="StimulusSemanticID"
						select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Stimulus/@xmi.idref" />
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

						<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
							<xsl:choose>
								<xsl:when
									test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Arrow'">
									<xsl:variable
										name="ActionSemanticID"
										select="key('xmi.id', $StimulusSemanticID)/UML:Stimulus.dispatchAction/*/@xmi.idref" />
									<xsl:choose>
										<xsl:when test="key('xmi.id', $ActionSemanticID)/@isAsynchronous = 'true'">
											<xsl:call-template name="AsynchronousArrow" />
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="SynchronousArrow" />
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>

								<xsl:when
									test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'SequenceExpression'">
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
											<xsl:text>SequenceExpression for </xsl:text>
											<xsl:value-of select="$StimulusSemanticID" />
										</title>
										<desc>
											<xsl:text>SequenceExpression</xsl:text>
										</desc>

										<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
											<xsl:choose>
												<xsl:when
													test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
													<xsl:call-template name="Name">
														<xsl:with-param
															name="OwnerSemanticID"
															select="$StimulusSemanticID" />
													</xsl:call-template>
												</xsl:when>
											</xsl:choose>
										</xsl:for-each>
									</g>
								</xsl:when>

								<xsl:when
									test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'TypeSeparator'">
									<!-- Separator, ':' -->
									<xsl:apply-templates
										select="."
										mode="FontStyle" />
									<xsl:call-template name="Text">
										<xsl:with-param
											name="String"
											select="$TypeSeparator" />
									</xsl:call-template>
								</xsl:when>

								<xsl:when
									test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:DestroyAction or
										UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:CreateAction or
										UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:CallAction or
										UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:SendAction or
										UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:ReturnAction">
									<g
										id="{@xmi.id}"
										transform="translate({UML:GraphElement.position/XMI.field[1]}, {UML:GraphElement.position/XMI.field[2]})">
										<xsl:apply-templates
											select="."
											mode="FontStyle" />
										<xsl:apply-templates
											select="."
											mode="isVisible" />

										<xsl:variable
											name="ActionSemanticID"
											select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

										<title>
											<xsl:text>Stimulus Action </xsl:text>
											<xsl:value-of select="$ActionSemanticID" />
											<xsl:text> for </xsl:text>
											<xsl:value-of select="$StimulusSemanticID" />
										</title>
										<desc>
											<xsl:text>Stimulus Action</xsl:text>
										</desc>

										<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
											<xsl:choose>
												<xsl:when
													test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
													<xsl:call-template name="Name">
														<xsl:with-param
															name="OwnerSemanticID"
															select="$ActionSemanticID" />
													</xsl:call-template>
												</xsl:when>
												<xsl:when
													test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML:Operation">
													<xsl:call-template name="Operation" />
												</xsl:when>
												<xsl:otherwise>
													<!-- !TODO: try to solve the other cases here (if any) -->
													<text>[uml2svg: not implemented]</text>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:for-each>
									</g>
								</xsl:when>
							</xsl:choose>
						</xsl:for-each>
					</g>
				</xsl:when>

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'TransitionDescription'">
					<!-- Transition description -->
					<xsl:call-template name="TransitionDescription" />
				</xsl:when>

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'NamespaceCompartment'">
					<!-- Namespace compartment -->
					<xsl:call-template name="NamespaceCompartment" />
				</xsl:when>

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'ExpressionCompartment'">
					<!-- Expression compartment -->
					<xsl:call-template name="ExpressionCompartment" />
				</xsl:when>

				<xsl:when
					test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'StateTransitionDescription'">
					<!-- UML2 StateTransitionDescription -->
					<xsl:call-template name="StateTransitionDescription" />
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

	<!-- Build a path data ( 'd' attribute for path element) -->
	<xsl:template name="BuildPathData">

		<xsl:variable
			name="Waypoints"
			select="UML:GraphEdge.waypoints" />
		<xsl:text>M </xsl:text>
		<xsl:for-each select="$Waypoints/XMI.field">
			<xsl:choose>
				<xsl:when test="position() = 1">
					<xsl:value-of select="./XMI.field[position()=1]" />
					<xsl:text> </xsl:text>
					<xsl:value-of select="./XMI.field[position()=2]" />
					<xsl:text> L </xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="(position() mod 3) = 1">
						<xsl:value-of select="./XMI.field[position()=1]" />
						<xsl:text> </xsl:text>
						<xsl:value-of select="./XMI.field[position()=2]" />
						<xsl:text> </xsl:text>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
