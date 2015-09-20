<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: MakeTreeScript.xsl Outputs the script that handles the tree -->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

	<!-- MakeTreeScript -->
	<xsl:template name="MakeTreeScript">
		<!-- Main TreeScript group -->
		<rect
			id="BackgroundRect"
			width="100%"
			height="100%"
			fill="#FFF"
			stroke="none" />
		<script type="text/ecmascript">
			<xsl:text disable-output-escaping="yes">&lt;![CDATA[
	function show(id){
		document.getElementById(id).setAttribute('display', 'inline');
		document.getElementById(id+'S').childNodes.item(0).nodeValue = "-";
		document.getElementById(id+'S').setAttribute('onclick', 'hide("' + id + '")');
		UpdateScrollbars();
	}
	function hide(id){
		document.getElementById(id).setAttribute('display', 'none');
		document.getElementById(id+'S').childNodes.item(0).nodeValue = "+";
		document.getElementById(id+'S').setAttribute('onclick', 'show("' + id + '")');
		UpdateScrollbars();
	}

	function treeNodeClick(id){
		if(document.getElementById(id).getAttribute('display') == 'none'){
			show(id);
		}
		else {
			hide(id);
		}
	}

	function UpdateScrollbars(){
		var TreeViewBox = document.getElementById('DiagramTreeSVG').getAttribute('viewBox');
		var TreeViewRect = svgDocument.documentElement.createSVGRect();
		var viewBoxParams = TreeViewBox.split(/\s*,\s*|\s+/);
		TreeViewRect.x = parseFloat(viewBoxParams[0]);
		TreeViewRect.y = parseFloat(viewBoxParams[1]);
		TreeViewRect.width = parseFloat(viewBoxParams[2]);
		TreeViewRect.height = parseFloat(viewBoxParams[3]);
		var TreeBBox = document.getElementById('DiagramTreeSVG').getBBox();
		TreeScroller.UpdateScrollbars(TreeBBox, TreeViewRect);
	}

	var CurrentDiagramID = null;
	function showDiagram(ID){
		if(CurrentDiagramID != null){
			document.getElementById(CurrentDiagramID).setAttribute('display', 'none');
			document.getElementById(CurrentDiagramID + 'T').setAttribute('fill', '#FFFFE3');
			document.getElementById(CurrentDiagramID + 'T').setAttribute('onmouseover', "document.getElementById('" + CurrentDiagramID + "T').setAttribute('fill', '#FFF')");
			document.getElementById(CurrentDiagramID + 'T').setAttribute('onmouseout', "document.getElementById('" + CurrentDiagramID + "T').setAttribute('fill', '#FFFFE3')");
		}
		document.getElementById(ID).setAttribute('display', 'inline');
		CurrentDiagramID = ID;
		document.getElementById(CurrentDiagramID + 'T').setAttribute('fill', '#FFE089');
		document.getElementById(CurrentDiagramID + 'T').setAttribute('onmouseover', "");
		document.getElementById(CurrentDiagramID + 'T').setAttribute('onmouseout', "");
	}

//----------------------------------------------------
//     Compute the minimum of 2 numbers
//----------------------------------------------------
function Minimum(Param1, Param2){
 return parseFloat((Param1 &lt; Param2) ? Param1 : Param2);
}

//----------------------------------------------------
//     Compute the maximum of 2 numbers
//----------------------------------------------------
function Maximum(Param1, Param2){
 return parseFloat((Param1 &gt; Param2) ? Param1 : Param2);
}

		]]&gt;</xsl:text>
		</script>
	</xsl:template>
</xsl:stylesheet>
