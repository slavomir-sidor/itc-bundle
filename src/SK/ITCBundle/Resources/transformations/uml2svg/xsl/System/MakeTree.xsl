<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: MakeTree.xsl Outputs the diagram tree -->
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
	<xsl:template name="MakeTree">
		<script type="text/ecmascript">
			<xsl:text disable-output-escaping="yes">&lt;![CDATA[
/*****
*
*   AntiZoomAndPan.js
*
*   copyright 2002, Kevin Lindsey
*
*****/

AntiZoomAndPan.VERSION = "1.2"

/*****
*
*   constructor
*
*****/
function AntiZoomAndPan() {
    this.init();
}

/*****
*
*   init
*
*****/
AntiZoomAndPan.prototype.init = function() {
	if(window.svgDocument == null){
		svgDocument = document;
	}
    var svgRoot = svgDocument.documentElement;

    // Initialize properties;
    this.svgNodes = new Array();
    this.x_trans  = 0;
    this.y_trans  = 0;
    this.scale    = 1;
    this.lastTM   = svgRoot.createSVGMatrix();

    // Setup event listeners to capture zoom and scroll events
    svgRoot.addEventListener('SVGZoom',   this, false);
    svgRoot.addEventListener('SVGScroll', this, false);
    svgRoot.addEventListener('SVGResize', this, false);
};

/*****
*
*   appendNode
*
*****/
AntiZoomAndPan.prototype.appendNode = function(svgNode) {
    // Add node to a array
    this.svgNodes.push(svgNode);
};

/*****
*
*   removeNode
*
*****/
AntiZoomAndPan.prototype.removeNode = function(svgNode) {
    // Remove node if found
    for ( var i = 0; i &lt; this.svgNodes.length; i++ ) {
        if ( this.svgNodes[i] === svgNode ) {
            this.svgNodes.splice(i, 1);
            break;
        }
    }
};

/*****
*
*   Event Handlers
*
*****/

/*****
*
*   handleEvent
*
*****/
AntiZoomAndPan.prototype.handleEvent = function(e) {
    var type = e.type;

    if ( this[type] == null )
        throw new Error("Unsupported event type: " + type);

    this[type](e);
};


/*****
*
*   SVGZoom
*
*****/
AntiZoomAndPan.prototype.SVGZoom = function(e) {
    // Update current transform
    this.update();
};


/*****
*
*   SVGScroll
*
*****/
AntiZoomAndPan.prototype.SVGScroll = function(e) {
    // Update current transform
    this.update();
};

/*****
*
*   SVGResize
*
*****/

AntiZoomAndPan.prototype.SVGResize = function(e) {
    // Update current transform
    this.update();
};

/*****
*
*   update
*
*****/
AntiZoomAndPan.prototype.update = function() {
	if ( this.svgNodes.length &gt; 0 ) {
		var svgRoot = svgDocument.documentElement;
		var viewbox = ( window.ViewBox != null )
			? new ViewBox(svgRoot)
			: null;
		var matrix  = ( viewbox != null )
			? viewbox.getTM()
			: svgRoot.createSVGMatrix();
		var trans   = svgRoot.currentTranslate;

		// Set the scale factor to leave object at original scale
		matrix = matrix.scale( 1.0 / svgRoot.currentScale);

		// Get the current pan settings
		matrix = matrix.translate(-trans.x, -trans.y);

		// Apply combined transforms to all managed nodes
		for ( var i = 0; i &lt; this.svgNodes.length; i++ ) {
			var node = this.svgNodes[i];
			var CTM  = matrix.multiply( this.lastTM.multiply(node.getCTM()) );
			var transform = "matrix(" + [ CTM.a, CTM.b, CTM.c, CTM.d, CTM.e, CTM.f ].join(",") + ")";
			this.svgNodes[i].setAttributeNS(null, "transform", transform);
		}
    }

	var TreeViewBox = document.getElementById('DiagramTreeSVG').getAttribute('viewBox');
	var viewBoxParams = TreeViewBox.split(/\s*,\s*|\s+/);

	var innerHeight;
	if(window.innerHeight){
		innerHeight = window.innerHeight;
	}
	else if(svgDocument.documentElement.height){
		innerHeight = svgDocument.documentElement.height.baseVal.value;
	}

	svgDocument.getElementById("DiagramTreeSVG").setAttribute('viewBox', viewBoxParams[0] + ' ' +  viewBoxParams[1] + ' 200 ' + (innerHeight));
	TreeScroller.ResizeScrollbars(innerHeight);
	UpdateScrollbars();
	this.lastTM = matrix.inverse();
};
		]]&gt;
		</xsl:text>
		</script>

		<script>
			<xsl:text disable-output-escaping="yes">&lt;![CDATA[
        var azap = new AntiZoomAndPan();

        function init(evt) {
            if ( window.svgDocument == null ){
                svgDocument = window.evt.target.ownerDocument;
            }
            var Tree = svgDocument.getElementById("DiagramTree");
            azap.appendNode(Tree);
            azap.appendNode(svgDocument.getElementById("BackgroundRect"));

/*            var Diagrams = svgDocument.getElementsByTagName("svg");
			for(var i = 0; i &lt; Diagrams.length; i++){
				var Diagram = Diagrams.item(i);
				var id = Diagram.getAttribute('id');
				if(id AND id != 'DiagramTreeSVG'){
					azap.appendNode(Diagram);
					Diagram.setAttribute('zoomAndPan', 'disable');
				}
            }*/

            var innerHeight;
            if(window.innerHeight){
                innerHeight = window.innerHeight;
            }
            else if(svgDocument.documentElement.height){
                innerHeight = svgDocument.documentElement.height.baseVal.value;
            }
            svgDocument.getElementById("DiagramTreeSVG").setAttribute('viewBox', '0 0 200 ' + (innerHeight));

            // This update is needed to initialize all mananged nodes
            // Really this is a hack to get around this "feature" of the code
            azap.update();
            clinit(evt)
        }
		]]&gt;
		</xsl:text>
		</script>

		<script>
			<xsl:text disable-output-escaping="yes">&lt;![CDATA[
/*-----------------------------------------
|  Slightly inspired from Kevin Lindsey's ViewBox.svg
| http://www.kevlindev.com/gui/utilities/viewbox/index.htm
-------------------------------------------*/

var svgns = "http://www.w3.org/2000/svg";
var svgRoot;
var viewBox;

function clinit(evt) {
    if ( window.svgDocument == null )
        svgDocument = evt.target.ownerDocument;
    svgRoot         = svgDocument.documentElement;
    viewBox         = new ViewBox(svgRoot);
}

function ScreenToClient(parent, e) {
    var trans  = svgRoot.getCurrentTranslate();
    var scale  = svgRoot.getCurrentScale();
    var m      = viewBox.getTM();
    var p1     = svgRoot.createSVGPoint();
    var p2, p3;
    m = m.scale( 1/scale );
    m = m.translate(-trans.x, -trans.y);
    p1.x = e.clientX;
    p1.y = e.clientY;
    p2 = p1.matrixTransform(m);
    p3 = Transform2Parent(parent, p2);
    return p3;
}

function Transform2Parent(node, point){
  if(node == svgDocument){
    return point;
  }
  point = Transform2Parent(node.parentNode, point);
  var x = node.getAttribute('x') ? parseFloat(node.getAttribute('x')) : 0;
  var y = node.getAttribute('y') ? parseFloat(node.getAttribute('y')) : 0;
  point.x -= x;
  point.y -= y;
  var v = node.getAttribute('viewBox');
  if(v){
    var params = v.split(/\s*,\s*|\s+/);
    var vx  = parseFloat( params[0] );
    var vy  = parseFloat( params[1] );
    var vwidth  = parseFloat( params[2] );
    var width   = parseFloat( node.getAttribute('width'));
    point.x += vx;
    point.y += vy;
    if(width){
      point.x = point.x * (vwidth / width);
      point.y = point.y * (vwidth / width);
    }
  }
  point = point.matrixTransform(node.getCTM().inverse());
  return point;
}
		]]&gt;
		</xsl:text>
		</script>

		<script>
			<xsl:text disable-output-escaping="yes">&lt;![CDATA[
/*****
*
*   ViewBox.js
*
*   copyright 2002, Kevin Lindsey
*
*****/

ViewBox.VERSION = "1.0";


/*****
*
*   constructor
*
*****/
function ViewBox(svgNode) {
    if ( arguments.length &gt; 0 ) {
        this.init(svgNode);
    }
}

/*****
*
*   init
*
*****/
ViewBox.prototype.init = function(svgNode) {
    var viewBox = svgNode.getAttributeNS(null, "viewBox");
    var preserveAspectRatio = svgNode.getAttributeNS(null, "preserveAspectRatio");
    
    if ( viewBox != "" ) {
		var params = viewBox.split(/\s*,\s*|\s+/);

        this.x      = parseFloat( params[0] );
        this.y      = parseFloat( params[1] );
    } else {
        // NOTE: Need to put an SVGResize event handler on the svgNode to keep
        // these values in sync with the window size or should add additional
        // logic (probably a flag) to getTM() so it will know to use the window
        // dimensions instead of this object's width and height properties
        this.x      = 0;
        this.y      = 0;
    }

    this.setPAR(preserveAspectRatio);
};


/*****
*
*   getTM
*
*****/
ViewBox.prototype.getTM = function() {
    var svgRoot      = svgDocument.documentElement;
    var matrix       = svgDocument.documentElement.createSVGMatrix();
    var windowWidth  = svgRoot.getAttributeNS(null, "width");
    var windowHeight = svgRoot.getAttributeNS(null, "height");

    var innerWidth;
    if(window.innerWidth){
      innerWidth = window.innerWidth;
    }
    else if(svgDocument.documentElement.width){
      innerWidth = svgDocument.documentElement.width.baseVal.value;
    }

    var innerHeight;
    if(window.innerHeight){
      innerHeight = window.innerHeight;
    }
    else if(svgDocument.documentElement.height){
      innerHeight = svgDocument.documentElement.height.baseVal.value;
    }

    windowWidth  = ( windowWidth  != "" ) ? parseFloat(windowWidth)  : innerWidth;
    windowHeight = ( windowHeight != "" ) ? parseFloat(windowHeight) : innerHeight;

    var x_ratio = innerWidth  / windowWidth;
    var y_ratio = innerHeight / windowHeight;

    matrix = matrix.translate(this.x, this.y);
    if ( this.alignX == "none" ) {
        matrix = matrix.scaleNonUniform( x_ratio, y_ratio );
    } else {
        if ( x_ratio &lt; y_ratio &amp;&amp; this.meetOrSlice == "meet" ||
             x_ratio &gt; y_ratio &amp;&amp; this.meetOrSlice == "slice"   )
        {
            var x_trans = 0;
            var x_diff  = windowWidth*y_ratio - this.width;

            if ( this.alignX == "Mid" )
                x_trans = -x_diff/2;
            else if ( this.alignX == "Max" )
                x_trans = -x_diff;
            
            matrix = matrix.translate(x_trans, 0);
            matrix = matrix.scale( y_ratio );
        }
        else if ( x_ratio &gt; y_ratio &amp;&amp; this.meetOrSlice == "meet" ||
                  x_ratio &lt; y_ratio &amp;&amp; this.meetOrSlice == "slice"   )
        {
            var y_trans = 0;
            var y_diff  = windowHeight*x_ratio - this.height;

            if ( this.alignY == "Mid" )
                y_trans = -y_diff/2;
            else if ( this.alignY == "Max" )
                y_trans = -y_diff;
            
            matrix = matrix.translate(0, y_trans);
            matrix = matrix.scale( x_ratio );
        }
        else
        {
            // x_ratio == y_ratio so, there is no need to translate
            // We can scale by either value
            matrix = matrix.scale( x_ratio );
        }
    }

    return matrix;
}


/*****
*
*   get/set methods
*
*****/

/*****
*
*   setPAR
*
*****/
ViewBox.prototype.setPAR = function(PAR) {
    // NOTE: This function needs to use default values when encountering
    // unrecognized values
    if ( PAR ) {
        var params = PAR.split(/\s+/);
        var align  = params[0];

        if ( align == "none" ) {
            this.alignX = "none";
            this.alignY = "none";
        } else {
            this.alignX = align.substring(1,4);
            this.alignY = align.substring(5,9);
        }

        if ( params.length == 2 ) {
            this.meetOrSlice = params[1];
        } else {
            this.meetOrSlice = "meet";
        }
    } else {
        this.align  = "xMidYMid";
        this.alignX = "Mid";
        this.alignY = "Mid";
        this.meetOrSlice = "meet";
    }
};
		]]&gt;
		</xsl:text>
		</script>

		<script>
			<xsl:text disable-output-escaping="yes">&lt;![CDATA[
/***********************************************
Scroller
Handles scrolling
************************************************/
var SCROLLBAR_WIDTH = 15;
var SCROLLBAR_MIN_LENGTH = 5;
var SCROLL_DELTA = 20;
var PADDING = 10;

function Scroller(GlobalName, Target, WIDTH, HEIGHT, ContainerID){
 this.GlobalName = GlobalName;
 this.Target = Target;
 this.TargetWidth = WIDTH;
 this.TargetHeight = HEIGHT;
 this.FocusCursor = false;
 // Generate Scrollbars

 // VERTICAL SCROLLBAR
 this.vScroll = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'g');
 this.vScroll.setAttribute('transform', 'translate(' + (this.TargetWidth - SCROLLBAR_WIDTH) + ', 0)');
 this.vScroll.setAttribute('id', 'vScroll');
 this.vScroll.setAttribute('display', 'none');
 
 this.UpBtn = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'g');
 this.UpBtnBk = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'rect');
 this.UpBtnBk.setAttribute('stroke', 'none');
 this.UpBtnBk.setAttribute('fill', '#444');
 this.UpBtnBk.setAttribute('width', SCROLLBAR_WIDTH);
 this.UpBtnBk.setAttribute('y', 0.5);
 this.UpBtnBk.setAttribute('height', SCROLLBAR_WIDTH-1);
 this.UpBtn.appendChild(this.UpBtnBk);
 this.UpBtnTopLeft = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'path');
 this.UpBtnTopLeft.setAttribute('stroke', '#FFFFE3');
 this.UpBtnTopLeft.setAttribute('stroke-width', '1px');
 this.UpBtnTopLeft.setAttribute('fill', 'none');
 this.UpBtnTopLeft.setAttribute('d', "M 0 " + (SCROLLBAR_WIDTH-1) + " V 0.5 h " + SCROLLBAR_WIDTH);
 this.UpBtn.appendChild(this.UpBtnTopLeft);
 this.UpBtnBottomRight = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'path');
 this.UpBtnBottomRight.setAttribute('stroke', '#000');
 this.UpBtnBottomRight.setAttribute('stroke-width', '2px');
 this.UpBtnBottomRight.setAttribute('fill', 'none');
 this.UpBtnBottomRight.setAttribute('d', "M 0 " + (SCROLLBAR_WIDTH-1) + " h " + SCROLLBAR_WIDTH + " V 0.5");
 this.UpBtn.appendChild(this.UpBtnBottomRight);
 this.UpBtn.setAttribute('onmousedown', this.GlobalName+'.UpBtnMouseDown()');
 var UpArr = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'path');
 UpArr.setAttribute('stroke', '#764');
 UpArr.setAttribute('stroke-width', '0.75px');
 UpArr.setAttribute('fill', '#FFFFE3');
 UpArr.setAttribute('d', 'M ' + SCROLLBAR_WIDTH/2 + ' ' + SCROLLBAR_WIDTH/4 + ' l ' + (-SCROLLBAR_WIDTH/4) + ' ' + SCROLLBAR_WIDTH/2 +
  ' h ' +  SCROLLBAR_WIDTH/2 + ' z');
 this.UpBtn.appendChild(UpArr);
 
 this.DownBtn = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'g');
 this.DownBtn.setAttribute('transform', 'translate(0, ' + (this.TargetHeight - SCROLLBAR_WIDTH) + ')');
 this.DownBtnBk = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'rect');
 this.DownBtnBk.setAttribute('stroke', 'none');
 this.DownBtnBk.setAttribute('fill', '#444');
 this.DownBtnBk.setAttribute('width', SCROLLBAR_WIDTH);
 this.DownBtnBk.setAttribute('y', 0.5);
 this.DownBtnBk.setAttribute('height', SCROLLBAR_WIDTH-1);
 this.DownBtn.appendChild(this.DownBtnBk);
 this.DownBtnTopLeft = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'path');
 this.DownBtnTopLeft.setAttribute('stroke', '#FFFFE3');
 this.DownBtnTopLeft.setAttribute('stroke-width', '1px');
 this.DownBtnTopLeft.setAttribute('fill', 'none');
 this.DownBtnTopLeft.setAttribute('d', "M 0 " + (SCROLLBAR_WIDTH-1) + " V 0.5 h " + SCROLLBAR_WIDTH);
 this.DownBtn.appendChild(this.DownBtnTopLeft);
 this.DownBtnBottomRight = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'path');
 this.DownBtnBottomRight.setAttribute('stroke', '#000');
 this.DownBtnBottomRight.setAttribute('stroke-width', '2px');
 this.DownBtnBottomRight.setAttribute('fill', 'none');
 this.DownBtnBottomRight.setAttribute('d', "M 0 " + (SCROLLBAR_WIDTH-1) + " h " + SCROLLBAR_WIDTH + " V 0.5");
 this.DownBtn.appendChild(this.DownBtnBottomRight);
 this.DownBtn.setAttribute('onmousedown', this.GlobalName+'.DownBtnMouseDown()');
 var DownArr = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'path');
 DownArr.setAttribute('stroke', '#764');
 DownArr.setAttribute('stroke-width', '0.75px');
 DownArr.setAttribute('fill', '#FFFFE3');
 DownArr.setAttribute('d', 'M ' + SCROLLBAR_WIDTH/2 + ' ' + 3*SCROLLBAR_WIDTH/4 + ' l ' + (-SCROLLBAR_WIDTH/4) + ' ' + (-SCROLLBAR_WIDTH/2) +
  ' h ' +  SCROLLBAR_WIDTH/2 + ' z');
 this.DownBtn.appendChild(DownArr);

 this.vScrollB = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'g');
 this.vScrollB.setAttribute('transform', 'translate(0, ' + SCROLLBAR_WIDTH + ')');
 this.vScroll.appendChild(this.vScrollB);
 
 this.vScrollBk = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'rect');
 this.vScrollBk.setAttribute('id', 'vScrollBk');
 this.vScrollBk.setAttribute('stroke', '#333');
 this.vScrollBk.setAttribute('fill', '#333');
 this.vScrollBk.setAttribute('stroke-width', '1px');
 this.vScrollBk.setAttribute('width', SCROLLBAR_WIDTH);
 this.vScrollBk.setAttribute('height', this.TargetHeight - SCROLLBAR_WIDTH);
 this.vScrollBk.setAttribute('onclick', this.GlobalName+'.vScrollBkClick(evt)');
 this.vScrollB.appendChild(this.vScrollBk);

 this.vScrollBt = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'g');

 this.vScrollBtBk = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'rect');
 this.vScrollBtBk.setAttribute('stroke', 'none');
 this.vScrollBtBk.setAttribute('fill', '#444');
 this.vScrollBtBk.setAttribute('width', SCROLLBAR_WIDTH);
 this.vScrollBtBk.setAttribute('height', SCROLLBAR_MIN_LENGTH);
 
 this.vScrollBtTopLeft = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'path');
 this.vScrollBtTopLeft.setAttribute('stroke', '#FFFFE3');
 this.vScrollBtTopLeft.setAttribute('stroke-width', '1px');
 this.vScrollBtTopLeft.setAttribute('fill', 'none');
 this.vScrollBtTopLeft.setAttribute('d', "M 0 " + SCROLLBAR_MIN_LENGTH + " v " + (-SCROLLBAR_MIN_LENGTH) + " h " + SCROLLBAR_WIDTH);

 this.vScrollBtBottomRight = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'path');
 this.vScrollBtBottomRight.setAttribute('stroke', '#000');
 this.vScrollBtBottomRight.setAttribute('stroke-width', '2px');
 this.vScrollBtBottomRight.setAttribute('fill', 'none');
 this.vScrollBtBottomRight.setAttribute('d', "M 0 " + SCROLLBAR_MIN_LENGTH + " h " + SCROLLBAR_WIDTH + " v " + (-SCROLLBAR_MIN_LENGTH));

 this.vScrollBt.appendChild(this.vScrollBtBk);
 this.vScrollBt.appendChild(this.vScrollBtTopLeft);
 this.vScrollBt.appendChild(this.vScrollBtBottomRight);

 this.vScrollB.appendChild(this.vScrollBt);
 this.vScroll.appendChild(this.UpBtn);
 this.vScroll.appendChild(this.DownBtn);
 this.vScrollBt.setAttribute('onmousedown', this.GlobalName+'.vScrollBtMouseDown(evt)');
 
 // HORIZONTAL SCROLLBAR

 this.hScroll = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'g');
 this.hScroll.setAttribute('transform', 'translate(0, ' + (this.TargetHeight - SCROLLBAR_WIDTH) + ')');
 this.hScroll.setAttribute('id', 'hScroll');
 this.hScroll.setAttribute('display', 'none');
 
 this.LeftBtn = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'g');
 this.LeftBtnBk = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'rect');
 this.LeftBtnBk.setAttribute('stroke', 'none');
 this.LeftBtnBk.setAttribute('fill', '#444');
 this.LeftBtnBk.setAttribute('x', 0.5);
 this.LeftBtnBk.setAttribute('width', SCROLLBAR_WIDTH-1);
 this.LeftBtnBk.setAttribute('height', SCROLLBAR_WIDTH);
 this.LeftBtn.appendChild(this.LeftBtnBk);
 this.LeftBtnTopLeft = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'path');
 this.LeftBtnTopLeft.setAttribute('stroke', '#FFFFE3');
 this.LeftBtnTopLeft.setAttribute('stroke-width', '1px');
 this.LeftBtnTopLeft.setAttribute('fill', 'none');
 this.LeftBtnTopLeft.setAttribute('d', "M 0.5 " + SCROLLBAR_WIDTH + " V 0 h " + (SCROLLBAR_WIDTH-1));
 this.LeftBtn.appendChild(this.LeftBtnTopLeft);
 this.LeftBtnBottomRight = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'path');
 this.LeftBtnBottomRight.setAttribute('stroke', '#000');
 this.LeftBtnBottomRight.setAttribute('stroke-width', '2px');
 this.LeftBtnBottomRight.setAttribute('fill', 'none');
 this.LeftBtnBottomRight.setAttribute('d', "M 0.5 " + SCROLLBAR_WIDTH + " h " + (SCROLLBAR_WIDTH-1) + " V 0");
 this.LeftBtn.appendChild(this.LeftBtnBottomRight);
 this.LeftBtn.setAttribute('onmousedown', this.GlobalName+'.LeftBtnMouseDown()');
 var LeftArr = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'path');
 LeftArr.setAttribute('stroke', '#764');
 LeftArr.setAttribute('stroke-width', '0.75px');
 LeftArr.setAttribute('fill', '#FFFFE3');
 LeftArr.setAttribute('d', 'M ' + SCROLLBAR_WIDTH/4 + ' ' + SCROLLBAR_WIDTH/2 + ' l ' + SCROLLBAR_WIDTH/2 + ' ' + (-SCROLLBAR_WIDTH/4) +
  ' v ' +  SCROLLBAR_WIDTH/2 + ' z');
 this.LeftBtn.appendChild(LeftArr);

 this.RightBtn = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'g');
 this.RightBtn.setAttribute('transform', 'translate(' + (this.TargetWidth - SCROLLBAR_WIDTH) + ', 0)');
 this.RightBtnBk = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'rect');
 this.RightBtnBk.setAttribute('stroke', 'none');
 this.RightBtnBk.setAttribute('fill', '#444');
 this.RightBtnBk.setAttribute('x', 0.5);
 this.RightBtnBk.setAttribute('width', SCROLLBAR_WIDTH-1);
 this.RightBtnBk.setAttribute('height', SCROLLBAR_WIDTH);
 this.RightBtn.appendChild(this.RightBtnBk);
 this.RightBtnTopLeft = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'path');
 this.RightBtnTopLeft.setAttribute('stroke', '#FFFFE3');
 this.RightBtnTopLeft.setAttribute('stroke-width', '1px');
 this.RightBtnTopLeft.setAttribute('fill', 'none');
 this.RightBtnTopLeft.setAttribute('d', "M 0.5 " + SCROLLBAR_WIDTH + " V 0 h " + (SCROLLBAR_WIDTH-1));
 this.RightBtn.appendChild(this.RightBtnTopLeft);
 this.RightBtnBottomRight = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'path');
 this.RightBtnBottomRight.setAttribute('stroke', '#000');
 this.RightBtnBottomRight.setAttribute('stroke-width', '2px');
 this.RightBtnBottomRight.setAttribute('fill', 'none');
 this.RightBtnBottomRight.setAttribute('d', "M 0.5 " + SCROLLBAR_WIDTH + " h " + (SCROLLBAR_WIDTH-1) + " V 0");
 this.RightBtn.appendChild(this.RightBtnBottomRight);
 this.RightBtn.setAttribute('onmousedown', this.GlobalName+'.RightBtnMouseDown()');
 var RightArr = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'path');
 RightArr.setAttribute('stroke', '#764');
 RightArr.setAttribute('stroke-width', '0.75px');
 RightArr.setAttribute('fill', '#FFFFE3');
 RightArr.setAttribute('d', 'M ' + 3*SCROLLBAR_WIDTH/4 + ' ' + SCROLLBAR_WIDTH/2 + ' l ' + (-SCROLLBAR_WIDTH/2) + ' ' +(-SCROLLBAR_WIDTH/4) +
  ' v ' +  SCROLLBAR_WIDTH/2 + ' z');
 this.RightBtn.appendChild(RightArr);
 
 this.hScrollB = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'g');
 this.hScrollB.setAttribute('transform', 'translate(' + SCROLLBAR_WIDTH + ', 0)');
 this.hScroll.appendChild(this.hScrollB);
 
 this.hScrollBk = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'rect');
 this.hScrollBk.setAttribute('id', 'hScrollBk');
 this.hScrollBk.setAttribute('stroke', '#333');
 this.hScrollBk.setAttribute('fill', '#333');
 this.hScrollBk.setAttribute('stroke-width', '1px');
 this.hScrollBk.setAttribute('width', this.TargetWidth - SCROLLBAR_WIDTH);
 this.hScrollBk.setAttribute('height', SCROLLBAR_WIDTH);
 this.hScrollBk.setAttribute('onclick', this.GlobalName+'.hScrollBkClick(evt)');
 this.hScrollB.appendChild(this.hScrollBk);

 this.hScrollBt = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'g');
 
 this.hScrollBtBk = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'rect');
 this.hScrollBtBk.setAttribute('stroke', 'none');
 this.hScrollBtBk.setAttribute('fill', '#444');
 this.hScrollBtBk.setAttribute('width', SCROLLBAR_MIN_LENGTH);
 this.hScrollBtBk.setAttribute('height', SCROLLBAR_WIDTH);
 
 this.hScrollBtTopLeft = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'path');
 this.hScrollBtTopLeft.setAttribute('stroke', '#FFFFE3');
 this.hScrollBtTopLeft.setAttribute('stroke-width', '1px');
 this.hScrollBtTopLeft.setAttribute('fill', 'none');
 this.hScrollBtTopLeft.setAttribute('d', "M 0 " + SCROLLBAR_WIDTH + " v " + (-SCROLLBAR_WIDTH) + " h " + SCROLLBAR_MIN_LENGTH);

 this.hScrollBtBottomRight = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'path');
 this.hScrollBtBottomRight.setAttribute('stroke', '#000');
 this.hScrollBtBottomRight.setAttribute('stroke-width', '2px');
 this.hScrollBtBottomRight.setAttribute('fill', 'none');
 this.hScrollBtBottomRight.setAttribute('d', "M 0 " + SCROLLBAR_WIDTH + " h " + SCROLLBAR_MIN_LENGTH + " v " + (-SCROLLBAR_WIDTH));
 
 this.hScrollBt.appendChild(this.hScrollBtBk);
 this.hScrollBt.appendChild(this.hScrollBtTopLeft);
 this.hScrollBt.appendChild(this.hScrollBtBottomRight);

 this.hScrollB.appendChild(this.hScrollBt);
 this.hScroll.appendChild(this.LeftBtn);
 this.hScroll.appendChild(this.RightBtn);
 this.hScrollBt.setAttribute('onmousedown', this.GlobalName+'.hScrollBtMouseDown(evt)');

 this.MeetRect = svgDocument.createElementNS('http://www.w3.org/2000/svg', 'rect');
 this.MeetRect.setAttribute('stroke', '#333');
 this.MeetRect.setAttribute('fill', '#333');
 this.MeetRect.setAttribute('stroke-width', '1px');
 this.MeetRect.setAttribute('width', SCROLLBAR_WIDTH);
 this.MeetRect.setAttribute('height', SCROLLBAR_WIDTH);
 this.MeetRect.setAttribute('x', this.TargetWidth-SCROLLBAR_WIDTH);
 this.MeetRect.setAttribute('y', this.TargetHeight-SCROLLBAR_WIDTH);
 this.MeetRect.setAttribute('display', 'none');

 this.hScroll.setAttribute('onclick', 'evt.stopPropagation()');
 this.vScroll.setAttribute('onclick', 'evt.stopPropagation()');
 this.workspace = svgDocument.getElementById(ContainerID);
 this.workspace.appendChild(this.hScroll);
 this.workspace.appendChild(this.vScroll);
 this.workspace.appendChild(this.MeetRect);
}

//----------------------------------------------------
//    The user clicks on the horizontal scroll background
//----------------------------------------------------
Scroller.prototype.hScrollBkClick = function(evt){
  var newx = ScreenToClient(this.hScrollBk, evt).x
  var btnx = Maximum(0, newx - parseFloat(this.hScrollBtBk.getAttribute('width')) / 2);
  btnx = Minimum(btnx, parseFloat(this.hScrollBk.getAttribute('width')) - parseFloat(this.hScrollBtBk.getAttribute('width')));
  this.hScrollBt.setAttribute('transform', 'translate(' + btnx + ', 0)');
  this.TranslateViewBoxX(btnx / parseFloat(this.hScrollBk.getAttribute('width')));
  evt.stopPropagation();
}

//----------------------------------------------------
//    The user clicks on the vertical scroll background
//----------------------------------------------------
Scroller.prototype.vScrollBkClick = function(evt){
  var newy = ScreenToClient(this.vScrollBk, evt).y
  var btny = Maximum(0, newy - parseFloat(this.vScrollBtBk.getAttribute('height')) / 2);
  btny = Minimum(btny, parseFloat(this.vScrollBk.getAttribute('height')) - parseFloat(this.vScrollBtBk.getAttribute('height')));
  this.vScrollBt.setAttribute('transform', 'translate(0, ' + btny + ')');
  this.TranslateViewBoxY(btny / parseFloat(this.vScrollBk.getAttribute('height')));
  evt.stopPropagation();
}

//----------------------------------------------------
//    The user presses the mouse button on the horizontal scroll button
//----------------------------------------------------
Scroller.prototype.hScrollBtMouseDown = function(evt){
  this.clickX = ScreenToClient(this.hScrollBt, evt).x;
  window.Dragging = this;
  this.scrolling = 'h';
  evt.stopPropagation();
}

//----------------------------------------------------
//    The user presses the mouse button on the vertical scroll button
//----------------------------------------------------
Scroller.prototype.vScrollBtMouseDown = function(evt){
  this.clickY = ScreenToClient(this.vScrollBt, evt).y;
  window.Dragging = this;
  this.scrolling = 'v';
  evt.stopPropagation();
}

//----------------------------------------------------
//    Mouse dragging
//----------------------------------------------------
Scroller.prototype.MouseMove = function (evt){
  if(this.scrolling == 'h'){
    var newx = ScreenToClient(this.hScrollBk, evt).x;
    var btnx = Maximum(0, newx - this.clickX);
    btnx = Minimum(btnx, parseFloat(this.hScrollBk.getAttribute('width')) - parseFloat(this.hScrollBtBk.getAttribute('width')));
    this.hScrollBt.setAttribute('transform', 'translate(' + btnx + ', 0)');
    this.TranslateViewBoxX(btnx / parseFloat(this.hScrollBk.getAttribute('width')));
  }
  else if(this.scrolling == 'v'){
    var newy = ScreenToClient(this.vScrollBk, evt).y;
    var btny = Maximum(0, newy - this.clickY);
    btny = Minimum(btny, parseFloat(this.vScrollBk.getAttribute('height')) - parseFloat(this.vScrollBtBk.getAttribute('height')));
    this.vScrollBt.setAttribute('transform', 'translate(0, ' + btny + ')');
    this.TranslateViewBoxY(btny / parseFloat(this.vScrollBk.getAttribute('height')));
  }
  evt.stopPropagation();
}

//----------------------------------------------------
//    The user presses the scroll left arrow
//----------------------------------------------------
Scroller.prototype.LeftBtnMouseDown = function(){
  var transform = this.hScrollBt.getAttribute('transform');
  var btnx = parseFloat(transform.substring(transform.indexOf('(')+1, transform.indexOf(',')));
  var newx = Maximum(0, btnx - SCROLL_DELTA);
  this.hScrollBt.setAttribute('transform', 'translate(' + newx + ', 0)');
  this.TranslateViewBoxX(newx / parseFloat(this.hScrollBk.getAttribute('width')));
}

//----------------------------------------------------
//    The user presses the scroll right arrow
//----------------------------------------------------
Scroller.prototype.RightBtnMouseDown = function(){
  var transform = this.hScrollBt.getAttribute('transform');
  var btnx = parseFloat(transform.substring(transform.indexOf('(')+1, transform.indexOf(',')));
  var newx = Minimum(btnx + SCROLL_DELTA,
      parseFloat(this.hScrollBk.getAttribute('width')) - parseFloat(this.hScrollBtBk.getAttribute('width')));
  this.hScrollBt.setAttribute('transform', 'translate(' + newx + ', 0)');
  this.TranslateViewBoxX(newx / parseFloat(this.hScrollBk.getAttribute('width')));
}

//----------------------------------------------------
//    The user presses the scroll up arrow
//----------------------------------------------------
Scroller.prototype.UpBtnMouseDown = function(){
  var transform = this.vScrollBt.getAttribute('transform');
  var btny = parseFloat(transform.substring(transform.indexOf(' ')+1, transform.indexOf(')')));
  var newy = Maximum(0, btny - SCROLL_DELTA);
  this.vScrollBt.setAttribute('transform', 'translate(0, ' + newy + ')');
  this.TranslateViewBoxY(newy / parseFloat(this.vScrollBk.getAttribute('height')));
}

//----------------------------------------------------
//    The user presses the scroll down arrow
//----------------------------------------------------
Scroller.prototype.DownBtnMouseDown = function(){
  var transform = this.vScrollBt.getAttribute('transform');
  var btny = parseFloat(transform.substring(transform.indexOf(' ')+1, transform.indexOf(')')));
  var newy = Minimum(btny + SCROLL_DELTA,
      parseFloat(this.vScrollBk.getAttribute('height')) - parseFloat(this.vScrollBtBk.getAttribute('height')));
  this.vScrollBt.setAttribute('transform', 'translate(0, ' + newy +')');
  this.TranslateViewBoxY(newy / parseFloat(this.vScrollBk.getAttribute('height')));
}

//----------------------------------------------------
//    Update scrollbar
//----------------------------------------------------
Scroller.prototype.UpdateScrollbars = function (workareaBBox, viewBox){
  this.PutInside(viewBox, workareaBBox);
  if(((workareaBBox.width &gt; (viewBox.width - SCROLLBAR_WIDTH)) &amp;&amp; (workareaBBox.height &gt; (viewBox.height - SCROLLBAR_WIDTH))) ||
     (workareaBBox.width &gt; viewBox.width)){
   if (workareaBBox.height &gt; viewBox.height - SCROLLBAR_WIDTH){
     var bkwidth = viewBox.width - 3*SCROLLBAR_WIDTH
     this.hScrollBk.setAttribute('width', bkwidth);
     this.RightBtn.setAttribute('transform', 'translate(' + (this.TargetWidth - 2*SCROLLBAR_WIDTH) + ', 0)');
     var hScrollWidth = Maximum(SCROLLBAR_MIN_LENGTH,
        ((viewBox.width-SCROLLBAR_WIDTH) * bkwidth / workareaBBox.width));
     var hScrollX = (viewBox.x * bkwidth / workareaBBox.width);
     this.hScrollBtBk.setAttribute('width', hScrollWidth);
     this.hScrollBtTopLeft.setAttribute('d', "M 0 " + SCROLLBAR_WIDTH + " v " + (-SCROLLBAR_WIDTH) + " h " + hScrollWidth);
     this.hScrollBtBottomRight.setAttribute('d', "M 0 " + SCROLLBAR_WIDTH + " h " + hScrollWidth + " v " + (-SCROLLBAR_WIDTH));
     this.hScrollBt.setAttribute('transform', 'translate(' + hScrollX + ', 0)');
     this.hScroll.setAttribute('display', 'inline');

     var bkheight = viewBox.height - 3*SCROLLBAR_WIDTH;
     this.vScrollBk.setAttribute('height', bkheight);
     this.DownBtn.setAttribute('transform', 'translate(0, ' + (this.TargetHeight - 2*SCROLLBAR_WIDTH) + ')');
     var vScrollHeight = Maximum(SCROLLBAR_MIN_LENGTH,
        ((viewBox.height - SCROLLBAR_WIDTH) * bkheight / workareaBBox.height));
     var vScrollY = (viewBox.y * bkheight / workareaBBox.height);
     this.vScrollBtBk.setAttribute('height', vScrollHeight);
     this.vScrollBtTopLeft.setAttribute('d', "M 0 " + vScrollHeight + " v " + (-vScrollHeight) + " h " + SCROLLBAR_WIDTH);
     this.vScrollBtBottomRight.setAttribute('d', "M 0 " + vScrollHeight + " h " + SCROLLBAR_WIDTH + " v " + (-vScrollHeight));
     this.vScrollBt.setAttribute('transform', 'translate(0, ' + vScrollY + ')');
     this.vScroll.setAttribute('display', 'inline');

      this.MeetRect.setAttribute('display', 'inline');
      return;
   }
   else{
     var bkwidth = viewBox.width - 2* SCROLLBAR_WIDTH;
     this.hScrollBk.setAttribute('width', bkwidth);
     this.RightBtn.setAttribute('transform', 'translate(' + (this.TargetWidth - SCROLLBAR_WIDTH) + ', 0)');
     var hScrollWidth = Maximum(SCROLLBAR_MIN_LENGTH,
        (viewBox.width * bkwidth / workareaBBox.width));
     var hScrollX = (viewBox.x * bkwidth / workareaBBox.width);
     this.hScrollBtBk.setAttribute('width', hScrollWidth);
     this.hScrollBtTopLeft.setAttribute('d', "M 0 " + SCROLLBAR_WIDTH + " v " + (-SCROLLBAR_WIDTH) + " h " + hScrollWidth);
     this.hScrollBtBottomRight.setAttribute('d', "M 0 " + SCROLLBAR_WIDTH + " h " + hScrollWidth + " v " + (-SCROLLBAR_WIDTH));
     this.hScrollBt.setAttribute('transform', 'translate(' + hScrollX + ', 0)');
     this.hScroll.setAttribute('display', 'inline');
   }
  }
  else{
    this.hScroll.setAttribute('display', 'none');
  }
  if (workareaBBox.height &gt; viewBox.height){
    var bkheight = viewBox.height - 2*SCROLLBAR_WIDTH;
    this.DownBtn.setAttribute('transform', 'translate(0, ' + (this.TargetHeight - SCROLLBAR_WIDTH) + ')');
    this.vScrollBk.setAttribute('height', bkheight);
    var vScrollHeight = Maximum(SCROLLBAR_MIN_LENGTH,
       (viewBox.height * bkheight / workareaBBox.height));
    var vScrollY = (viewBox.y * bkheight / workareaBBox.height);
    this.vScrollBtBk.setAttribute('height', vScrollHeight);
    this.vScrollBtTopLeft.setAttribute('d', "M 0 " + vScrollHeight + " v " + (-vScrollHeight) + " h " + SCROLLBAR_WIDTH);
    this.vScrollBtBottomRight.setAttribute('d', "M 0 " + vScrollHeight + " h " + SCROLLBAR_WIDTH + " v " + (-vScrollHeight));
    this.vScrollBt.setAttribute('transform', 'translate(0, ' + vScrollY + ')');
    this.vScroll.setAttribute('display', 'inline');
  }
  else{
    this.vScroll.setAttribute('display', 'none');
  }
  this.MeetRect.setAttribute('display', 'none');
}

//------------------------------------
//    Mouse Up
//----------------------------------------------------
Scroller.prototype.MouseUp = function (evt){
  window.Dragging = null;
  evt.stopPropagation();
}

//----------------------------------------------------
//    Translate the viewbox on the X axis
//----------------------------------------------------
Scroller.prototype.TranslateViewBoxX = function(newX){
  var viewBox = this.TaiewBox = this.Target.getAttribute('viewBox');
  var viewBoxParams = viewBox.split(/\s*,\s*|\s+/);
  var workareaHeight = this.Target.getBBox().height + PADDING;
  var workareaWidth = this.Target.getBBox().width + PADDING;
  var newX = newX * workareaWidth;

  this.Target.setAttribute('viewBox', newX + ' ' + viewBoxParams[1] + ' ' + viewBoxParams[2] + ' ' + viewBoxParams[3]);
}

//----------------------------------------------------
//    Translate the viewbox on the Y axis
//----------------------------------------------------
Scroller.prototype.TranslateViewBoxY = function(newY){
  var viewBox = this.Target.getAttribute('viewBox');
  var viewBoxParams = viewBox.split(/\s*,\s*|\s+/);
  var workareaHeight = this.Target.getBBox().height + PADDING;
  var workareaWidth = this.Target.getBBox().width + PADDING;
  var newY = newY * workareaHeight;

  this.Target.setAttribute('viewBox', viewBoxParams[0] + ' ' + newY + ' ' + viewBoxParams[2] + ' ' + viewBoxParams[3]);
}

//----------------------------------------------------
//    Translate the viewbox so that the viewbox doesn't get out of the bbox
//----------------------------------------------------
Scroller.prototype.PutInside = function(viewRect, bbox){
  var Modified = false;
  if(((viewRect.x + viewRect.width) &gt; bbox.width) &amp;&amp; (viewRect.x != 0)){
    if (bbox.height &gt; viewRect.height){
      viewRect.x = Maximum(0, bbox.width - viewRect.width + SCROLLBAR_WIDTH);
    }
    else{
      viewRect.x = Maximum(0, bbox.width - viewRect.width);
    }
    Modified = true;
  }
  if(((viewRect.y + viewRect.height) &gt; bbox.height) &amp;&amp; (viewRect.y != 0)){
    if (bbox.width &gt; viewRect.width){
      viewRect.y = Maximum(0, bbox.height - viewRect.height + SCROLLBAR_WIDTH);
    }
    else{
      viewRect.y = Maximum(0, bbox.height - viewRect.height);
    }
    Modified = true;
  }
  if(Modified == true){
    this.Target.setAttribute('viewBox', viewRect.x + ' ' + viewRect.y + ' ' + viewRect.width + ' ' + viewRect.height);
  }
}

Scroller.prototype.ResizeScrollbars = function(Height){
 this.TargetHeight = Height;

 this.DownBtn.setAttribute('transform', 'translate(0, ' + (this.TargetHeight - SCROLLBAR_WIDTH) + ')');
 this.hScroll.setAttribute('transform', 'translate(0, ' + (this.TargetHeight - SCROLLBAR_WIDTH) + ')');
 this.MeetRect.setAttribute('y', this.TargetHeight-SCROLLBAR_WIDTH);
}

if(window.innerHeight){
  TreeScroller = new Scroller('TreeScroller', svgDocument.getElementById('DiagramTreeSVG'), 200, window.innerHeight, 'DiagramTree');
}
else if(svgDocument.documentElement.height){
  TreeScroller = new Scroller('TreeScroller', svgDocument.getElementById('DiagramTreeSVG'), 200,
    svgDocument.documentElement.height.baseVal.value, 'DiagramTree');
}
else{
}
		]]&gt;
		</xsl:text>
		</script>
		<!-- Main Tree group -->
		<g id="DiagramTree">
			<!-- Background -->
			<rect
				width="200"
				height="100%"
				fill="black"
				stroke="#444"
				stroke-width="2" />
			<svg
				id="DiagramTreeSVG"
				width="200"
				font-weight="bold"
				font-size="13"
				fill="#FFFFE3"
				onload="init();"
				viewBox="0 0 200 500">
				<!-- Origin, used for correct scrolling -->
				<rect
					width="0.1px"
					height="0.1px"
					style="opacity: 0; fill: #000" />
				<!-- Tree root -->
				<a>
					<text stroke="none">
						<tspan
							id="TreeRootS"
							x="10"
							dy="20"
							onclick="show('TreeRoot')">+</tspan>
						<tspan
							x="20"
							dy="0"
							onclick="treeNodeClick('TreeRoot')">
							<xsl:value-of select="//UML:Model/@name" />
						</tspan>
						<tspan
							id="TreeRoot"
							display="none">

							<!-- Contained Class diagrams -->
							<xsl:if
								test="/XMI/XMI.content/UML:Diagram[UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'ClassDiagram']">
								<tspan
									id="ClassDiagramsS"
									x="20"
									dy="20"
									onclick="show('ClassDiagrams')">+</tspan>
								<tspan
									x="30"
									dy="0"
									onclick="treeNodeClick('ClassDiagrams')">Class Diagrams</tspan>
								<tspan
									id="ClassDiagrams"
									display="none">
									<xsl:for-each
										select="/XMI/XMI.content/UML:Diagram[UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'ClassDiagram']">
										<tspan
											id="{@xmi.id}T"
											x="40"
											dy="20"
											onclick="showDiagram('{@xmi.id}')"
											onmouseover="document.getElementById('{@xmi.id}T').setAttribute('fill', '#FFF')"
											onmouseout="document.getElementById('{@xmi.id}T').setAttribute('fill', '#FFFFE3')">
											<xsl:value-of select="@name" />
										</tspan>
									</xsl:for-each>
								</tspan>
							</xsl:if>

							<!-- Contained UseCase diagrams -->
							<xsl:if
								test="/XMI/XMI.content/UML:Diagram[UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'UseCaseDiagram']">
								<tspan
									id="UseCaseDiagramsS"
									x="20"
									dy="20"
									onclick="show('UseCaseDiagrams')">+</tspan>
								<tspan
									x="30"
									dy="0"
									onclick="treeNodeClick('UseCaseDiagrams')">UseCase Diagrams</tspan>
								<tspan
									id="UseCaseDiagrams"
									display="none">
									<xsl:for-each
										select="/XMI/XMI.content/UML:Diagram[UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'UseCaseDiagram']">
										<tspan
											id="{@xmi.id}T"
											x="40"
											dy="20"
											onclick="showDiagram('{@xmi.id}')"
											onmouseover="document.getElementById('{@xmi.id}T').setAttribute('fill', '#FFF')"
											onmouseout="document.getElementById('{@xmi.id}T').setAttribute('fill', '#FFFFE3')">
											<xsl:value-of select="@name" />
										</tspan>
									</xsl:for-each>
								</tspan>
							</xsl:if>

							<!-- Contained State diagrams -->
							<xsl:if
								test="/XMI/XMI.content/UML:Diagram[UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'StateDiagram']">
								<tspan
									id="StateDiagramsS"
									x="20"
									dy="20"
									onclick="show('StateDiagrams')">+</tspan>
								<tspan
									x="30"
									dy="0"
									onclick="treeNodeClick('StateDiagrams')">State Diagrams</tspan>
								<tspan
									id="StateDiagrams"
									display="none">
									<xsl:for-each
										select="/XMI/XMI.content/UML:Diagram[UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'StateDiagram']">
										<tspan
											id="{@xmi.id}T"
											x="40"
											dy="20"
											onclick="showDiagram('{@xmi.id}')"
											onmouseover="document.getElementById('{@xmi.id}T').setAttribute('fill', '#FFF')"
											onmouseout="document.getElementById('{@xmi.id}T').setAttribute('fill', '#FFFFE3')">
											<xsl:value-of select="@name" />
										</tspan>
									</xsl:for-each>
								</tspan>
							</xsl:if>

							<!-- Contained Activity diagrams -->
							<xsl:if
								test="/XMI/XMI.content/UML:Diagram[UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'ActivityDiagram']">
								<tspan
									id="ActivityDiagramsS"
									x="20"
									dy="20"
									onclick="show('ActivityDiagrams')">+</tspan>
								<tspan
									x="30"
									dy="0"
									onclick="treeNodeClick('ActivityDiagrams')">Activity Diagrams</tspan>
								<tspan
									id="ActivityDiagrams"
									display="none">
									<xsl:for-each
										select="/XMI/XMI.content/UML:Diagram[UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'ActivityDiagram']">
										<tspan
											id="{@xmi.id}T"
											x="40"
											dy="20"
											onclick="showDiagram('{@xmi.id}')"
											onmouseover="document.getElementById('{@xmi.id}T').setAttribute('fill', '#FFF')"
											onmouseout="document.getElementById('{@xmi.id}T').setAttribute('fill', '#FFFFE3')">
											<xsl:value-of select="@name" />
										</tspan>
									</xsl:for-each>
								</tspan>
							</xsl:if>

							<!-- Contained Collaboration diagrams -->
							<xsl:if
								test="/XMI/XMI.content/UML:Diagram[UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'CollaborationDiagram']">
								<tspan
									id="CollaborationDiagramsS"
									x="20"
									dy="20"
									onclick="show('CollaborationDiagrams')">+</tspan>
								<tspan
									x="30"
									dy="0"
									onclick="treeNodeClick('CollaborationDiagrams')">Collaboration Diagrams</tspan>
								<tspan
									id="CollaborationDiagrams"
									display="none">
									<xsl:for-each
										select="/XMI/XMI.content/UML:Diagram[UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'CollaborationDiagram']">
										<tspan
											id="{@xmi.id}T"
											x="40"
											dy="20"
											onclick="showDiagram('{@xmi.id}')"
											onmouseover="document.getElementById('{@xmi.id}T').setAttribute('fill', '#FFF')"
											onmouseout="document.getElementById('{@xmi.id}T').setAttribute('fill', '#FFFFE3')">
											<xsl:value-of select="@name" />
										</tspan>
									</xsl:for-each>
								</tspan>
							</xsl:if>

							<!-- Contained Sequence diagrams -->
							<xsl:if
								test="/XMI/XMI.content/UML:Diagram[UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'SequenceDiagram']">
								<tspan
									id="SequenceDiagramsS"
									x="20"
									dy="20"
									onclick="show('SequenceDiagrams')">+</tspan>
								<tspan
									x="30"
									dy="0"
									onclick="treeNodeClick('SequenceDiagrams')">Sequence Diagrams</tspan>
								<tspan
									id="SequenceDiagrams"
									display="none">
									<xsl:for-each
										select="/XMI/XMI.content/UML:Diagram[UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'SequenceDiagram']">
										<tspan
											id="{@xmi.id}T"
											x="40"
											dy="20"
											onclick="showDiagram('{@xmi.id}')"
											onmouseover="document.getElementById('{@xmi.id}T').setAttribute('fill', '#FFF')"
											onmouseout="document.getElementById('{@xmi.id}T').setAttribute('fill', '#FFFFE3')">
											<xsl:value-of select="@name" />
										</tspan>
									</xsl:for-each>
								</tspan>
							</xsl:if>

							<!-- Contained Deployment diagrams -->
							<xsl:if
								test="/XMI/XMI.content/UML:Diagram[UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'DeploymentDiagram']">
								<tspan
									id="DeploymentDiagramsS"
									x="20"
									dy="20"
									onclick="show('DeploymentDiagrams')">+</tspan>
								<tspan
									x="30"
									dy="0"
									onclick="treeNodeClick('DeploymentDiagrams')">Deployment Diagrams</tspan>
								<tspan
									id="DeploymentDiagrams"
									display="none">
									<xsl:for-each
										select="/XMI/XMI.content/UML:Diagram[UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'DeploymentDiagram']">
										<tspan
											id="{@xmi.id}T"
											x="40"
											dy="20"
											onclick="showDiagram('{@xmi.id}')"
											onmouseover="document.getElementById('{@xmi.id}T').setAttribute('fill', '#FFF')"
											onmouseout="document.getElementById('{@xmi.id}T').setAttribute('fill', '#FFFFE3')">
											<xsl:value-of select="@name" />
										</tspan>
									</xsl:for-each>
								</tspan>
							</xsl:if>
						</tspan>
					</text>
				</a>
			</svg>
		</g>
	</xsl:template>
</xsl:stylesheet>
