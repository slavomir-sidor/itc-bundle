<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output
		method="xml"
		version="1.0"
		encoding="UTF-8"
		indent="yes" />

	<xsl:variable name="uml2svgVersion">
		0.17
	</xsl:variable>

	<xsl:param name="UmlStdVersion">
		1.5
	</xsl:param>

	<xsl:param name="TypeSeparator">
		:
	</xsl:param>
	<xsl:param name="ParameterSeparator">
		,
	</xsl:param>
	<xsl:param name="ParameterStart">
		(
	</xsl:param>
	<xsl:param name="ParameterEnd">
		)
	</xsl:param>

	<xsl:param name="PublicVisibility">
		+
	</xsl:param>
	<xsl:param name="ProtectedVisibility">
		#
	</xsl:param>
	<xsl:param name="PackageVisibility">
		~
	</xsl:param>
	<xsl:param name="PrivateVisibility">
		-
	</xsl:param>

	<xsl:param name="Derived">
		/
	</xsl:param>
	<xsl:param name="MultiplicityStart">
		[
	</xsl:param>
	<xsl:param name="MultiplicityEnd">
		]
	</xsl:param>
	<xsl:param name="InitialValueSeparator">
		=
	</xsl:param>

	<xsl:param name="ExpressionStart">
		{
	</xsl:param>
	<xsl:param name="ExpressionSeparator">
		,
	</xsl:param>
	<xsl:param name="ExpressionEnd">
		}
	</xsl:param>

	<xsl:param name="NamespaceStart">
		(from
	</xsl:param>
	<xsl:param name="NamespaceSeparator">
		::
	</xsl:param>
	<xsl:param name="NamespaceEnd">
		)
	</xsl:param>

	<xsl:param name="StereotypeStart">&lt;&lt;
	</xsl:param>
	<xsl:param name="StereotypeSeparator">
		,
	</xsl:param>
	<xsl:param name="StereotypeEnd">&gt;&gt;
	</xsl:param>

	<xsl:param name="InStatesStart">
		[
	</xsl:param>
	<xsl:param name="InStatesEnd">
		]
	</xsl:param>

	<xsl:param name="NameLocationSeparator">
		:
	</xsl:param>

	<xsl:param name="TriggerSeparator">
		|
	</xsl:param>
	<xsl:param name="GuardStart">
		[
	</xsl:param>
	<xsl:param name="GuardEnd">
		]
	</xsl:param>
	<xsl:param name="EffectStart">
		/
	</xsl:param>

	<xsl:param name="MessageSeparator">
		.
	</xsl:param>

	<xsl:param name="AEGuardStart">
		[
	</xsl:param>
	<xsl:param name="AEGuardEnd">
		]
	</xsl:param>

	<xsl:param name="WeightStart">
		{
	</xsl:param>
	<xsl:param name="WeightIs">
		weight=
	</xsl:param>
	<xsl:param name="WeightEnd">
		}
	</xsl:param>
	<xsl:param
		name="CommentPaddingLeft"
		select="10" />
	<xsl:param
		name="CommentPaddingTop"
		select="10" />

	<xsl:param
		name="ViewBoxPaddingLeft"
		select="20" />
	<xsl:param
		name="ViewBoxPaddingRight"
		select="20" />
	<xsl:param
		name="ViewBoxPaddingTop"
		select="20" />
	<xsl:param
		name="ViewBoxPaddingBottom"
		select="20" />

	<xsl:param
		name="TreeWidth"
		select="200" />

</xsl:stylesheet>

