<?xml version="1.0"?>
<!-- Title: umbrello-xmi-to-html.xsl Purpose: An XSL stylesheet for converting Umbrello 
	1.4 XMI to HTML. Based on xmi-to-html.xsl from Objects by Design. Copyright (C) 1999-2001, 
	Objects by Design, Inc. All Rights Reserved. Copyright (C) 2005, Oliver M. Kellogg 
	<okellogg@users.sourceforge.net> This program is free software; you can redistribute 
	it and/or modify it under the terms of the GNU General Public License as published 
	by the Free Software Foundation. A copy of the license may be found at http://www.objectsbydesign.com/projects/gpl.txt 
	Version: July 23, 2005 For more info, please see the README file at http://www.objectsbydesign.com/projects/xmi-to-html.zip -->

<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/1999/xhtml"
	version="1.0"
	xmlns:UML="http://schema.omg.org/spec/UML/1.3"
	exclude-result-prefixes="UML">

	<xsl:output
		method="xml"
		indent="yes"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
		doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

	<xsl:key
		name="classifier"
		match="//UML:Class"
		use="@xmi.id" />

	<xsl:key
		name="generalization"
		match="//UML:Generalization"
		use="@xmi.id" />

	<xsl:key
		name="abstraction"
		match="//UML:Abstraction"
		use="@xmi.id" />

	<xsl:key
		name="multiplicity"
		match="//UML:Multiplicity"
		use="@xmi.id" />


	<!-- Document Root -->
	<xsl:template match="/">
		<html
			xmlns="http://www.w3.org/1999/xhtml"
			xml:lang="en"
			lang="en">
			<head>
				<!-- Model Name in window title -->
				<xsl:apply-templates
					select="//UML:Model"
					mode="head" />

				<link
					href="xmi.css"
					rel="stylesheet"
					type="text/css" />
			</head>
			<body>

				<!-- Model Name in document heading -->
				<xsl:apply-templates
					select="//UML:Model"
					mode="body" />

				<!-- Interfaces -->
				<xsl:apply-templates select="//UML:Interface">
				</xsl:apply-templates>

				<!-- Classes -->
				<xsl:apply-templates select="//UML:Class">
				</xsl:apply-templates>

			</body>
		</html>

	</xsl:template>


	<!-- Window Title -->
	<xsl:template
		match="UML:Model"
		mode="head">

		<title>
			<!-- Name of the model -->
			<xsl:value-of select="@name" />
		</title>

	</xsl:template>


	<!-- Document Heading -->
	<xsl:template
		match="UML:Model"
		mode="body">

		<div align="center">
			<h1>
				<!-- Name of the model -->
				<xsl:value-of select="@name" />
			</h1>
		</div>

	</xsl:template>


	<!-- Class -->
	<xsl:template match="UML:Class">
		<xsl:variable
			name="element_name"
			select="@name" />

		<xsl:variable
			name="xmi_id"
			select="@xmi.id" />

		<div align="center">
			<table
				border="1"
				width="75%"
				cellpadding="2">
				<tr>
					<td
						class="class-title"
						width="20%">Class</td>

					<!-- create a hyperlink target for the name -->
					<td class="class-name">
						<a name="{$element_name}">
							<xsl:value-of select="$element_name" />
						</a>
					</td>
				</tr>

				<tr>
					<td colspan="2">
						<table
							width="100%"
							cellpadding="0"
							cellspacing="0"
							border="0">

							<tr>
								<td
									colspan="2"
									bgcolor="#cacaca">
									<table
										width="100%"
										border="0"
										cellpadding="3"
										cellspacing="1">


										<xsl:call-template name="specifications" />

										<xsl:call-template name="realizations" />

										<xsl:call-template name="supertypes" />

										<xsl:call-template name="subtypes" />

										<xsl:call-template name="associations">
											<xsl:with-param
												name="source"
												select="$xmi_id" />
										</xsl:call-template>

										<xsl:call-template name="attributes" />

										<xsl:call-template name="operations" />

									</table>
								</td>
							</tr>

						</table>
					</td>
				</tr>

			</table>
		</div>
		<br />
		<br />
	</xsl:template>


	<!-- Interface -->
	<xsl:template match="UML:Interface">
		<xsl:variable
			name="element_name"
			select="@name" />

		<div align="center">
			<table
				border="1"
				width="75%"
				cellpadding="2">
				<tr>
					<td
						class="interface-title"
						width="20%">Interface</td>

					<!-- create a hyperlink target for the name -->
					<td class="interface-name">
						<a name="{$element_name}">
							<xsl:value-of select="$element_name" />
						</a>
					</td>
				</tr>

				<tr>
					<td colspan="2">
						<table
							width="100%"
							cellpadding="0"
							cellspacing="0"
							border="0">

							<tr>
								<td
									colspan="2"
									bgcolor="#cacaca">
									<table
										width="100%"
										border="0"
										cellpadding="3"
										cellspacing="1">

										<xsl:call-template name="realizations" />

										<xsl:call-template name="supertypes" />

										<xsl:call-template name="subtypes" />

										<xsl:call-template name="operations" />

									</table>
								</td>
							</tr>

						</table>
					</td>
				</tr>

			</table>
		</div>
		<br />
		<br />
	</xsl:template>


	<!-- The following template is designed to be called for Abstractions with the "realize" 
		stereotype, i.e. Realization relationships. It formats the name of the supplier of 
		the Abstraction dependency, i.e. the class or interface specifying the behaviour 
		of the client in the dependency. -->
	<!-- Specifications (interface or class) -->
	<xsl:template name="specifications">

		<!-- Abstractions identify specifications -->
		<xsl:variable
			name="specifications"
			select="Foundation.Core.ModelElement.clientDependency/
                 Foundation.Core.Abstraction" />

		<xsl:if test="count($specifications) > 0">
			<tr>
				<td
					width="20%"
					class="info-title">Specifications:</td>
				<td
					colspan="2"
					class="info">
					<xsl:for-each select="$specifications">

						<!-- get the supplier in the abstraction -->
						<xsl:variable
							name="abstraction"
							select="key('abstraction', ./@xmi.idref)" />
						<xsl:variable
							name="target"
							select="$abstraction/
                            Foundation.Core.Dependency.supplier/
                            */@xmi.idref" />
						<xsl:call-template name="classify">
							<xsl:with-param
								name="target"
								select="$target" />
						</xsl:call-template>

						<xsl:if test="position() != last()">
							<xsl:text>,  </xsl:text>
						</xsl:if>
					</xsl:for-each>
				</td>
			</tr>
		</xsl:if>

	</xsl:template>


	<!-- The following template is designed to be called for Abstractions with the "realize" 
		stereotype, i.e. Realization relationships. It formats the name of the client of 
		the Abstraction dependency, i.e. the class realizing the specification defined by 
		the supplier in the dependency. -->
	<!-- Realizations (of interface) -->
	<xsl:template name="realizations">

		<!-- Abstractions identify realizations -->
		<xsl:variable
			name="realizations"
			select="Foundation.Core.ModelElement.supplierDependency/
                 Foundation.Core.Abstraction" />

		<xsl:if test="count($realizations) > 0">
			<tr>
				<td
					width="20%"
					class="info-title">Realizations:</td>
				<td
					colspan="2"
					class="info">
					<xsl:for-each select="$realizations">

						<!-- get the client in the abstraction -->
						<xsl:variable
							name="abstraction"
							select="key('abstraction', ./@xmi.idref)" />
						<xsl:variable
							name="target"
							select="$abstraction/
                            Foundation.Core.Dependency.client/
                            */@xmi.idref" />
						<xsl:call-template name="classify">
							<xsl:with-param
								name="target"
								select="$target" />
						</xsl:call-template>

						<xsl:if test="position() != last()">
							<xsl:text>,  </xsl:text>
						</xsl:if>
					</xsl:for-each>
				</td>
			</tr>
		</xsl:if>

	</xsl:template>



	<!-- Supertypes (inheritance) -->
	<xsl:template name="supertypes">

		<!-- Generalizations identify supertypes -->
		<xsl:variable
			name="generalizations"
			select="UML:Generalization" />

		<xsl:if test="count($generalizations) > 0">
			<tr>
				<td
					width="20%"
					class="info-title">Supertypes:</td>
				<td
					colspan="2"
					class="info">
					<xsl:for-each select="$generalizations">

						<!-- get the parent in the generalization -->
						<xsl:variable
							name="generalization"
							select="key('generalization', ./@xmi.idref)" />
						<xsl:variable
							name="target"
							select="$generalization/
                            Foundation.Core.Generalization.parent/
                            */@xmi.idref" />
						<xsl:call-template name="classify">
							<xsl:with-param
								name="target"
								select="$target" />
						</xsl:call-template>

						<xsl:if test="position() != last()">
							<xsl:text>,  </xsl:text>
						</xsl:if>
					</xsl:for-each>
				</td>
			</tr>
		</xsl:if>
	</xsl:template>


	<!-- Subtypes (inheritance) -->
	<xsl:template name="subtypes">

		<!-- Specializations identify subtypes -->
		<xsl:variable
			name="specializations"
			select="Foundation.Core.GeneralizableElement.specialization/
                 Foundation.Core.Generalization" />

		<xsl:if test="count($specializations) > 0">
			<tr>
				<td
					width="20%"
					class="info-title">Subtypes:</td>
				<td
					colspan="2"
					class="info">
					<xsl:for-each select="$specializations">

						<!-- get the child in the generalization -->
						<xsl:variable
							name="generalization"
							select="key('generalization', ./@xmi.idref)" />
						<xsl:variable
							name="target"
							select="$generalization/
                            Foundation.Core.Generalization.child/
                            */@xmi.idref" />
						<xsl:call-template name="classify">
							<xsl:with-param
								name="target"
								select="$target" />
						</xsl:call-template>

						<xsl:if test="position() != last()">
							<xsl:text>,  </xsl:text>
						</xsl:if>
					</xsl:for-each>
				</td>
			</tr>
		</xsl:if>
	</xsl:template>


	<!-- Associations -->
	<xsl:template name="associations">
		<xsl:param name="source" />

		<xsl:variable
			name="association_ends"
			select="//UML:AssociationEnd[@type=$source]" />

		<xsl:if test="count($association_ends) > 0">
			<tr>
				<td
					colspan="3"
					class="info-title">Associations:</td>
			</tr>
			<tr>
				<td
					class="feature-heading"
					width="20%">visibility</td>
				<td
					class="feature-heading"
					width="25%">type</td>
				<td
					class="feature-heading"
					width="55%">properties</td>
			</tr>

			<xsl:for-each select="$association_ends">
				<tr>
					<xsl:for-each
						select="preceding-sibling::UML:AssociationEnd |
                                  following-sibling::UML:AssociationEnd">

						<xsl:call-template name="association_end" />

					</xsl:for-each>
				</tr>
			</xsl:for-each>
		</xsl:if>
	</xsl:template>


	<!-- Association End -->
	<xsl:template name="association_end">
		<!-- Visibility -->
		<td class="feature-detail">
			<xsl:variable
				name="visibility"
				select="@visibility" />
			<xsl:choose>
				<xsl:when test="string-length($visibility) > 0">
					<xsl:value-of select="$visibility" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</td>

		<!-- Type -->
		<td class="feature-detail">
			<xsl:variable
				name="target"
				select="Foundation.Core.AssociationEnd.type/*/@xmi.idref" />

			<xsl:call-template name="classify">
				<xsl:with-param
					name="target"
					select="$target" />
			</xsl:call-template>
		</td>

		<!-- Properties -->
		<td class="feature-detail">

			<!-- Rolename -->
			<xsl:variable
				name="rolename"
				select="@name" />

			<span class="property-name">Rolename: </span>
			<xsl:choose>
				<xsl:when test="string-length($rolename) > 0">
					<xsl:value-of select="$rolename" />
				</xsl:when>
				<xsl:otherwise>
					(none)
				</xsl:otherwise>
			</xsl:choose>

			<!-- Multiplicity -->
			<xsl:apply-templates select=".//Foundation.Data_Types.Multiplicity" />

			<!-- Navigable -->
			<xsl:variable
				name="navigable"
				select="Foundation.Core.AssociationEnd.isNavigable/@xmi.value" />
			<xsl:if test="string-length($navigable) > 0">
				<br />
				<span class="property-name">Navigable: </span>
				<xsl:value-of select="$navigable" />
			</xsl:if>

			<!-- Ordering -->
			<xsl:variable
				name="ordering"
				select="Foundation.Core.AssociationEnd.ordering/@xmi.value" />
			<xsl:if test="string-length($ordering) > 0">
				<br />
				<span class="property-name">Ordering: </span>
				<xsl:value-of select="$ordering" />
			</xsl:if>
		</td>
	</xsl:template>


	<!-- Multiplicity (definition) -->
	<xsl:template match="Foundation.Data_Types.Multiplicity[@xmi.id]">
		<br />
		<span class="property-name">Multiplicity: </span>

		<xsl:variable
			name="lower"
			select=".//Foundation.Data_Types.MultiplicityRange.lower" />

		<xsl:variable
			name="upper"
			select=".//Foundation.Data_Types.MultiplicityRange.upper" />

		<xsl:value-of select="$lower" />
		<xsl:if test="$upper != $lower">
			<xsl:text>..</xsl:text>
			<xsl:value-of select="$upper" />
		</xsl:if>

	</xsl:template>

	<!-- Multiplicity (reference) -->
	<xsl:template match="Foundation.Data_Types.Multiplicity[@xmi.idref]">
		<xsl:apply-templates select="key('multiplicity', @xmi.idref)" />
	</xsl:template>



	<!-- Attributes -->
	<xsl:template name="attributes">
		<tr>
			<td
				colspan="3"
				class="info-title">Attributes:</td>
		</tr>
		<tr>
			<td
				class="feature-heading"
				width="20%">visibility</td>
			<td
				class="feature-heading"
				width="25%">type</td>
			<td
				class="feature-heading"
				width="55%">name</td>
		</tr>
		<xsl:apply-templates
			select="UML:Classifier.feature/
                                 UML:Attribute" />
	</xsl:template>


	<xsl:template match="UML:Attribute">
		<xsl:variable
			name="target"
			select='@type' />


		<tr>
			<td class="feature-detail">
				<xsl:value-of select="@visibility" />
			</td>

			<td class="feature-detail">
				<xsl:call-template name="classify">
					<xsl:with-param
						name="target"
						select="$target" />
				</xsl:call-template>
			</td>

			<td class="feature-detail">
				<xsl:value-of select="@name" />
			</td>
		</tr>
	</xsl:template>



	<!-- Operations -->
	<xsl:template name="operations">
		<tr>
			<td
				colspan="3"
				class="info-title">Operations:</td>
		</tr>
		<tr>
			<td
				class="feature-heading"
				width="20%">visibility</td>
			<td
				class="feature-heading"
				width="25%">return</td>
			<td
				class="feature-heading"
				width="55%">name</td>
		</tr>

		<xsl:apply-templates
			select="UML:Classifier.feature/
                                 UML:Operation" />
	</xsl:template>


	<xsl:template match="UML:Operation">

		<xsl:variable
			name="parameters"
			select="UML:BehavioralFeature.parameter/
         UML:Parameter[@kind!='return']" />

		<xsl:variable
			name="return"
			select="UML:BehavioralFeature.parameter/
         UML:Parameter[@kind='return']" />

		<xsl:variable
			name="target"
			select="$return/@type" />

		<tr>
			<td class="feature-detail">
				<xsl:value-of select="@visibility" />
			</td>

			<td class="feature-detail">

				<xsl:choose>
					<xsl:when test="string-length($target) = 0">
						<span class="datatype">
							<xsl:text>void</xsl:text>
						</span>
					</xsl:when>

					<xsl:otherwise>
						<xsl:call-template name="classify">
							<xsl:with-param
								name="target"
								select="$target" />
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>

			</td>

			<td class="feature-detail">
				<xsl:value-of select="@name" />
			</td>
		</tr>

		<xsl:variable
			name="parameter-count"
			select="count($parameters)" />

		<xsl:if test="not(normalize-space($parameter-count)='0')">

			<tr>
				<td class="feature-detail">
					<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
				</td>

				<td
					class="parameter-heading"
					valign="top">parameters:</td>
				<td
					bgcolor="#ffffff"
					align="right">
					<table
						width="85%"
						align="right"
						cellpadding="0"
						cellspacing="0"
						border="0">
						<xsl:apply-templates select="$parameters" />
					</table>
				</td>
			</tr>

		</xsl:if>

	</xsl:template>



	<!-- Parameter -->
	<xsl:template match="UML:Parameter">
		<xsl:variable
			name="target"
			select="@type" />

		<tr>
			<td
				class="feature-detail"
				width="45%">
				<xsl:call-template name="classify">
					<xsl:with-param
						name="target"
						select="$target" />
				</xsl:call-template>
			</td>

			<td
				class="feature-detail"
				width="55%">
				<xsl:value-of select="@name" />
			</td>
		</tr>
	</xsl:template>


	<!-- Classification -->
	<xsl:template name="classify">
		<xsl:param name="target" />

		<xsl:variable
			name="classifier"
			select="key('classifier', $target)" />

		<xsl:variable
			name="classifier_name"
			select="$classifier/@name" />

		<xsl:variable
			name="type"
			select="name($classifier)" />

		<!-- Get the type of the classifier (class, interface, datatype) -->
		<xsl:variable name="classifier_type">
			<xsl:choose>
				<xsl:when test="$type='UML:Class'">
					classifier
				</xsl:when>
				<xsl:when test="$type='UML:Interface'">
					interface
				</xsl:when>
				<xsl:when test="$type='UML:DataType'">
					datatype
				</xsl:when>
				<xsl:otherwise>
					classifier
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:choose>
			<!-- Datatypes don't have hyperlinks -->
			<xsl:when test="$type='UML:DataType'">
				<span class="datatype">
					<xsl:value-of select="$classifier_name" />
				</span>
			</xsl:when>

			<!-- Classes and Interfaces have hyperlinks -->
			<!-- The classifier type is used to style appropriately -->
			<xsl:otherwise>
				<xsl:if test="string-length($classifier) > 0">
					<a
						class="{$classifier_type}"
						href="#{$classifier_name}">
						<xsl:value-of select="$classifier_name" />
					</a>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

</xsl:stylesheet>