<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output
		method="text"
		version="utf-8"
		encoding="utf-8"
		omit-xml-declaration="yes"
		standalone="yes"
		indent="yes"
		media-type="text/plain" />

	<xsl:template match="ContextState">

	</xsl:template>

	<xsl:template match="org.eclipse.mylyn.context.ui.editors">

	</xsl:template>

	<xsl:template match="MonitoredWindowOpenEditors">

		<xsl:param
			name="class"
			select="@class" />
		<xsl:param
			name="isActive"
			select="@isActive" />
		<xsl:param
			name="isLaunching"
			select="@isLaunching" />
		<xsl:param
			name="number"
			select="@number" />

	</xsl:template>

	<xsl:template match="editor">

		<xsl:param
			name="id"
			select="@id" />
		<xsl:param
			name="name"
			select="@name" />
		<xsl:param
			name="isLaunching"
			select="@isLaunching" />
		<xsl:param
			name="partName"
			select="@partName" />
		<xsl:param
			name="title"
			select="@title" />
		<xsl:param
			name="tooltip"
			select="@tooltip" />

	</xsl:template>

	<xsl:template match="input">

		<xsl:param
			name="factoryID"
			select="@factoryID" />
		<xsl:param
			name="taskHandle"
			select="@taskHandle" />

	</xsl:template>

</xsl:stylesheet>