<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: MakeArrowScript.xsl Outputs the script that handles the Stimuli Arrows 
	directions -->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

	<!-- MakeArrowScript -->
	<xsl:template name="MakeArrowScript">
		<script type="text/ecmascript">
			<xsl:text disable-output-escaping="yes">&lt;![CDATA[
	function OrientArrows(){
		var descriptions = document.getElementsByTagName('desc');
		for(i = 0; i &lt; descriptions.length; i++){
			if((descriptions.item(i).childNodes.item(0).nodeValue == 'SynchronousArrow') || (descriptions.item(i).childNodes.item(0).nodeValue == 'AsynchronousArrow')){
				var parentg = descriptions.item(i).parentNode;
				var rotate = getStimulusArrowRotation(parentg);
				transform = parentg.getAttribute('transform');
				transform += ' rotate(' + rotate + ')';
				parentg.setAttribute('transform', transform);
			}
		}
	}

	function getStimulusArrowRotation(Node){
		var pathparentg = Node.parentNode.parentNode;
		var path;
		for(k = 0; k &lt; pathparentg.childNodes.length; k++){
			if(pathparentg.childNodes.item(k).localName == 'path'){
				pathdata = pathparentg.childNodes.item(k).getAttribute('d');
				break;
			}
		}

		pathsegments = pathdata.split(' ');
		var pathpoints = new Array();
		pathpoints[0] = pathsegments[1];
		pathpoints[1] = pathsegments[2];
		for(k = 4; k &lt; pathsegments.length - 1; k++){
			pathpoints[pathpoints.length] = pathsegments[k];
		}

		var MinDistance = null;
		var Rotation = 0;
		transform = Node.getAttribute('transform');
		parentTransform = Node.parentNode.getAttribute('transform');
		xp = parseFloat(transform.split('(')[1].split(',')[0]) + parseFloat(parentTransform.split('(')[1].split(',')[0]);
		yp = parseFloat(transform.split(',')[1].split(')')[0]) + parseFloat(parentTransform.split(',')[1].split(')')[0]);

		for(k = 0; k &lt; pathpoints.length / 2 - 1; k++){
			xa = pathpoints[2*k];
			ya = pathpoints[2*k+1];
			xb = pathpoints[2*k+2];
			yb = pathpoints[2*k+3];
			if(xa == xb){
				d = Math.abs(xa - xp);
				if((d &lt; MinDistance) || (MinDistance == null)){
					MinDistance = d;
					if(ya &lt; yb) Rotation = -90;
					else Rotation = 90;
				}
			}
			else{
				m = (yb-ya)/(xb-xa);
				n = ya - xa*m;
				y = (m*m*yp - m*xp - n)/(m*m-1);
				x = m*y-m*yp+xp;
				if((xa &lt; xb &amp;&amp; xa &lt;= x &amp;&amp; x &lt;= xb) || (xb &lt; xa &amp;&amp; xb &lt;= x &amp;&amp; x &lt;= xa)){
					d = Math.sqrt((x-xp)*(x-xp) + (y-yp)*(y-yp));
				}
				else{
					DistanceToA = Math.sqrt((xp-xa)*(xp-xa) + (yp-ya)*(yp-ya));
					DistanceToB = Math.sqrt((xp-xb)*(xp-xb) + (yp-yb)*(yp-yb));
					d = DistanceToA &lt; DistanceToB ? DistanceToA : DistanceToB;
				}
				if((d &lt; MinDistance) || (MinDistance == null)){
					MinDistance = d;
					Rotation = Math.atan(m) * 180 / Math.PI;
					if(xa &lt; xb){
						Rotation += 180;
					}
				}
			}
		}
		return Rotation;
	}
		]]&gt;</xsl:text>
		</script>
	</xsl:template>
</xsl:stylesheet>
