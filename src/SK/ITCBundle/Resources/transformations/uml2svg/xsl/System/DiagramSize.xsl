<?xml version="1.0" encoding="UTF-8"?>
<!-- Template: DiagramSize.xsl Gets the width and height for a diagram -->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

	<!-- DiagramSize - non recursive wrapper template -->
	<xsl:template name="DiagramSize">

		<xsl:variable name="Diagram_BBox">
			<xsl:choose>
				<xsl:when test="UML:GraphElement.contained/*">
					<xsl:for-each select="UML:GraphElement.contained/*[position() = 1]">
						<xsl:call-template name="GetBounds" />
					</xsl:for-each>
				</xsl:when>

				<xsl:otherwise>
					<xsl:text>0 0 0 0</xsl:text> <!-- empty screen -->
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable
			name="MinX"
			select="number(substring-before($Diagram_BBox, ' '))" />
		<xsl:variable
			name="MinY"
			select="number(substring-before(substring-after($Diagram_BBox, ' '), ' '))" />
		<xsl:variable
			name="MaxX"
			select="number(substring-before(substring-after(substring-after($Diagram_BBox, ' '), ' '), ' '))" />
		<xsl:variable
			name="MaxY"
			select="number(substring-after(substring-after(substring-after($Diagram_BBox, ' '), ' '), ' '))" />

		<xsl:variable
			name="Width"
			select="$MaxX - $MinX + $ViewBoxPaddingLeft + $ViewBoxPaddingRight" />
		<xsl:variable
			name="Height"
			select="$MaxY - $MinY + $ViewBoxPaddingTop + $ViewBoxPaddingBottom" />

		<xsl:attribute name="width"><xsl:value-of select="$Width * @zoom" /></xsl:attribute>
		<xsl:attribute name="height"><xsl:value-of select="$Height * @zoom" /></xsl:attribute>
		<xsl:attribute name="viewBox">
			<xsl:value-of select="$MinX - $ViewBoxPaddingLeft" />
			<xsl:text> </xsl:text>
			<xsl:value-of select="$MinY - $ViewBoxPaddingTop" />
			<xsl:text> </xsl:text>
			<xsl:value-of select="$Width" />
			<xsl:text> </xsl:text>
			<xsl:value-of select="$Height" />
		</xsl:attribute>

		<xsl:if
			test="namespace-uri(UML:Diagram.owner/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*) = 'org.omg.xmi.namespace.UML2'">
			<rect
				x="{$MinX}"
				y="{$MinY}"
				width="{$MaxX - $MinX + $ViewBoxPaddingLeft - 1}"
				height="{$MaxY - $MinY + $ViewBoxPaddingTop - 1}"
				stroke="#808080">
				<xsl:apply-templates
					select="."
					mode="StrokeStyle" />
				<xsl:apply-templates
					select="."
					mode="FillStyle">
					<xsl:with-param
						name="DefaultFill"
						select="'#FFFFE3'" />
				</xsl:apply-templates>
			</rect>
			<xsl:if
				test="UML:DiagramElement.property/UML:Property[@key = 'show-dotted-line']/@value = 'true'">
				<rect
					x="{$MinX + 10 }"
					y="{$MinY + 10}"
					width="{$MaxX - $MinX + $ViewBoxPaddingLeft - 1 - 20}"
					height="{$MaxY - $MinY + $ViewBoxPaddingTop - 1 - 20}"
					stroke="#000000"
					fill="none"
					rx="5"
					ry="5" />
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template name="GetBounds">
		<xsl:choose>
			<xsl:when test="@isVisible = 'true'">

				<xsl:variable name="MeAndMyChildrenRelative_BBox">

					<!-- Compute bounding box for the current element depending on type (node, edge, 
						etc.) -->
					<xsl:variable name="My_BBox">
						<xsl:choose>
							<xsl:when test="self::UML:GraphEdge or self::UML:Polyline">
								<!-- GraphEdge or Polyline, check the waypoints -->
								<!-- Edge path minimum X -->
								<xsl:for-each
									select="*[substring-after(name(),'.')='waypoints']/XMI.field[position() mod 3 = 1]/XMI.field[1]">
									<xsl:sort
										select="."
										data-type="number"
										order="ascending" />
									<xsl:if test="position() = 1">
										<xsl:value-of select="." />
									</xsl:if>
								</xsl:for-each>

								<xsl:text> </xsl:text>

								<!-- Edge path minimum Y -->
								<xsl:for-each
									select="*[substring-after(name(),'.')='waypoints']/XMI.field[position() mod 3 = 1]/XMI.field[2]">
									<xsl:sort
										select="."
										data-type="number"
										order="ascending" />
									<xsl:if test="position() = 1">
										<xsl:value-of select="." />
									</xsl:if>
								</xsl:for-each>

								<xsl:text> </xsl:text>

								<!-- Edge path maximum X -->
								<xsl:for-each
									select="*[substring-after(name(),'.')='waypoints']/XMI.field[position() mod 3 = 1]/XMI.field[1]">
									<xsl:sort
										select="."
										data-type="number"
										order="descending" />
									<xsl:if test="position() = 1">
										<xsl:value-of select="." />
									</xsl:if>
								</xsl:for-each>

								<xsl:text> </xsl:text>

								<!-- Edge path maximum Y -->
								<xsl:for-each
									select="*[substring-after(name(),'.')='waypoints']/XMI.field[position() mod 3 = 1]/XMI.field[2]">
									<xsl:sort
										select="."
										data-type="number"
										order="descending" />
									<xsl:if test="position() = 1">
										<xsl:value-of select="." />
									</xsl:if>
								</xsl:for-each>
							</xsl:when>

							<xsl:when
								test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:ActivityParameterNode" />
							<xsl:when
								test="self::UML:GraphNode and not (UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:ActivityParameterNode)">
								<xsl:if
									test="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/UML2:ActivityParameterNode">
									<xsl:message>
										Crap
									</xsl:message>
								</xsl:if>
								<!-- GraphNode - UML:GraphNode.size -->
								<!-- UML:GraphElement.position is added later (also to the children) -->
								<!-- Node minimum X = 0 (Node X position is added later) -->
								<xsl:value-of select="0" />
								<xsl:text> </xsl:text>
								<!-- Node minimum Y = 0 (Node Y position is added later) -->
								<xsl:value-of select="0" />
								<xsl:text> </xsl:text>
								<!-- Node maximum X = Node width (Node X position is added later) -->
								<xsl:value-of select="UML:GraphNode.size/XMI.field[1]" />
								<xsl:text> </xsl:text>
								<!-- Node maximum Y = Node height (Node Y position is added later) -->
								<xsl:value-of select="UML:GraphNode.size/XMI.field[2]" />
							</xsl:when>

							<xsl:when test="self::UML:Ellipse">
								<xsl:value-of select="UML:Ellipse.center/XMI.field[1] - @radiusX" />
								<xsl:text> </xsl:text>
								<xsl:value-of select="UML:Ellipse.center/XMI.field[2] - @radiusY" />
								<xsl:text> </xsl:text>
								<xsl:value-of select="UML:Ellipse.center/XMI.field[1] + @radiusX" />
								<xsl:text> </xsl:text>
								<xsl:value-of select="UML:Ellipse.center/XMI.field[2] + @radiusY" />
							</xsl:when>

							<xsl:otherwise>
								<!-- Keep the code "safe" in case something strange is encountered -->
								<xsl:text>Infinity Infinity -Infinity -Infinity</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>

					<!-- <xsl:message><xsl:value-of select="@xmi.id"/> My_BBox: <xsl:value-of select="$My_BBox"/></xsl:message> -->

					<xsl:choose>
						<!-- element has children -->
						<xsl:when test="UML:GraphElement.contained/*">

							<!-- Compute bounding box for children (call only the first child as the childs 
								will call each other) -->
							<xsl:variable name="Children_BBox">
								<xsl:for-each select="UML:GraphElement.contained/*[position() = 1]">
									<xsl:call-template name="GetBounds" />
								</xsl:for-each>
							</xsl:variable>

							<!-- <xsl:message><xsl:value-of select="@xmi.id"/> Children_BBox: <xsl:value-of 
								select="$Children_BBox"/></xsl:message> -->

							<!-- Split this node's BBox into the 4 components: MinX, MinY, MaxX, MaxY -->
							<xsl:variable
								name="Self_MinX"
								select="substring-before($My_BBox, ' ')" />
							<xsl:variable
								name="Self_MinY"
								select="substring-before(substring-after($My_BBox, ' '), ' ')" />
							<xsl:variable
								name="Self_MaxX"
								select="substring-before(substring-after(substring-after($My_BBox, ' '), ' '), ' ')" />
							<xsl:variable
								name="Self_MaxY"
								select="substring-after(substring-after(substring-after($My_BBox, ' '), ' '), ' ')" />

							<!-- Split the children BBox into the 4 components: MinX, MinY, MaxX, MaxY -->
							<xsl:variable
								name="Child_MinX"
								select="substring-before($Children_BBox, ' ')" />
							<xsl:variable
								name="Child_MinY"
								select="substring-before(substring-after($Children_BBox, ' '), ' ')" />
							<xsl:variable
								name="Child_MaxX"
								select="substring-before(substring-after(substring-after($Children_BBox, ' '), ' '), ' ')" />
							<xsl:variable
								name="Child_MaxY"
								select="substring-after(substring-after(substring-after($Children_BBox, ' '), ' '), ' ')" />

							<xsl:choose>
								<xsl:when test="($Child_MinX = 'Infinity') and ($Self_MinX = 'Infinity')">
									<xsl:text>Infinity</xsl:text>
								</xsl:when>
								<xsl:when
									test="($Child_MinX = 'Infinity') or (number($Self_MinX) &lt;= number($Child_MinX))">
									<xsl:value-of select="number($Self_MinX)" />
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="number($Child_MinX)" />
								</xsl:otherwise>
							</xsl:choose>

							<xsl:text> </xsl:text>

							<xsl:choose>
								<xsl:when test="($Child_MinY = 'Infinity') and ($Self_MinY = 'Infinity')">
									<xsl:text>Infinity</xsl:text>
								</xsl:when>
								<xsl:when
									test="($Child_MinY = 'Infinity') or (number($Self_MinY) &lt;= number($Child_MinY))">
									<xsl:value-of select="number($Self_MinY)" />
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="number($Child_MinY)" />
								</xsl:otherwise>
							</xsl:choose>

							<xsl:text> </xsl:text>

							<xsl:choose>
								<xsl:when test="($Child_MaxX = '-Infinity') and ($Self_MaxX = '-Infinity')">
									<xsl:text>-Infinity</xsl:text>
								</xsl:when>
								<xsl:when
									test="($Child_MaxX = '-Infinity') or (number($Child_MaxX) &lt; number($Self_MaxX))">
									<xsl:value-of select="number($Self_MaxX)" />
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="number($Child_MaxX)" />
								</xsl:otherwise>
							</xsl:choose>

							<xsl:text> </xsl:text>

							<xsl:choose>
								<xsl:when test="($Child_MaxY = '-Infinity') and ($Self_MaxY = '-Infinity')">
									<xsl:text>-Infinity</xsl:text>
								</xsl:when>
								<xsl:when
									test="($Child_MaxY = '-Infinity') or (number($Child_MaxY) &lt; number($Self_MaxY))">
									<xsl:value-of select="number($Self_MaxY) " />
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="number($Child_MaxY) " />
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>

						<xsl:otherwise> <!-- element has no children -->
							<xsl:value-of select="$My_BBox" />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable> <!-- MeAndMyChildrenRelative_BBox -->

				<!-- <xsl:message><xsl:value-of select="@xmi.id"/> MeAndMyChildrenRelative_BBox: 
					<xsl:value-of select="$MeAndMyChildrenRelative_BBox"/></xsl:message> -->

				<xsl:variable name="MeAndMyChildren_BBox">
					<xsl:choose>
						<xsl:when test="UML:GraphElement.position">
							<xsl:variable
								name="Relative_MinX"
								select="substring-before($MeAndMyChildrenRelative_BBox, ' ')" />
							<xsl:variable
								name="Relative_MinY"
								select="substring-before(substring-after($MeAndMyChildrenRelative_BBox, ' '), ' ')" />
							<xsl:variable
								name="Relative_MaxX"
								select="substring-before(substring-after(substring-after($MeAndMyChildrenRelative_BBox, ' '), ' '), ' ')" />
							<xsl:variable
								name="Relative_MaxY"
								select="substring-after(substring-after(substring-after($MeAndMyChildrenRelative_BBox, ' '), ' '), ' ')" />
							<xsl:value-of
								select="number($Relative_MinX) + number(UML:GraphElement.position/XMI.field[1])" />
							<xsl:text> </xsl:text>
							<xsl:value-of
								select="number($Relative_MinY) + number(UML:GraphElement.position/XMI.field[2])" />
							<xsl:text> </xsl:text>
							<xsl:value-of
								select="number($Relative_MaxX) + number(UML:GraphElement.position/XMI.field[1])" />
							<xsl:text> </xsl:text>
							<xsl:value-of
								select="number($Relative_MaxY) + number(UML:GraphElement.position/XMI.field[2])" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$MeAndMyChildrenRelative_BBox" />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>


				<!-- <xsl:message><xsl:value-of select="@xmi.id"/> MeAndMyChildren_BBox: <xsl:value-of 
					select="$MeAndMyChildren_BBox"/></xsl:message> -->

				<xsl:choose>
					<xsl:when test="following-sibling::*">
						<!-- Compute bounding box for the rest of the siblings (they call each other 
							in turn) -->
						<xsl:variable name="FollowingSiblings_BBox">
							<xsl:for-each select="following-sibling::*[position() = 1]">
								<xsl:call-template name="GetBounds" />
							</xsl:for-each>
						</xsl:variable>

						<!-- <xsl:message><xsl:value-of select="@xmi.id"/> FollowingSiblings_BBox: 
							<xsl:value-of select="$FollowingSiblings_BBox"/></xsl:message> -->

						<!-- Split this element's BBox into the 4 components: MinX, MinY, MaxX, MaxY -->
						<xsl:variable
							name="MeAndChildren_MinX"
							select="substring-before($MeAndMyChildren_BBox, ' ')" />
						<xsl:variable
							name="MeAndChildren_MinY"
							select="substring-before(substring-after($MeAndMyChildren_BBox, ' '), ' ')" />
						<xsl:variable
							name="MeAndChildren_MaxX"
							select="substring-before(substring-after(substring-after($MeAndMyChildren_BBox, ' '), ' '), ' ')" />
						<xsl:variable
							name="MeAndChildren_MaxY"
							select="substring-after(substring-after(substring-after($MeAndMyChildren_BBox, ' '), ' '), ' ')" />

						<!-- Split the following siblings' BBox into the 4 components: MinX, MinY, 
							MaxX, MaxY -->
						<xsl:variable
							name="Following_MinX"
							select="substring-before($FollowingSiblings_BBox, ' ')" />
						<xsl:variable
							name="Following_MinY"
							select="substring-before(substring-after($FollowingSiblings_BBox, ' '), ' ')" />
						<xsl:variable
							name="Following_MaxX"
							select="substring-before(substring-after(substring-after($FollowingSiblings_BBox, ' '), ' '), ' ')" />
						<xsl:variable
							name="Following_MaxY"
							select="substring-after(substring-after(substring-after($FollowingSiblings_BBox, ' '), ' '), ' ')" />

						<xsl:choose>
							<xsl:when
								test="($Following_MinX = 'Infinity') and ($MeAndChildren_MinX = 'Infinity')">
								<xsl:text>Infinity</xsl:text>
							</xsl:when>
							<xsl:when
								test="($Following_MinX = 'Infinity') or (number($MeAndChildren_MinX) &lt;= number($Following_MinX))">
								<xsl:value-of select="number($MeAndChildren_MinX)" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="number($Following_MinX)" />
							</xsl:otherwise>
						</xsl:choose>

						<xsl:text> </xsl:text>

						<xsl:choose>
							<xsl:when
								test="($Following_MinY = 'Infinity') and ($MeAndChildren_MinY = 'Infinity')">
								<xsl:text>Infinity</xsl:text>
							</xsl:when>
							<xsl:when
								test="($Following_MinY = 'Infinity') or (number($MeAndChildren_MinY) &lt;= number($Following_MinY))">
								<xsl:value-of select="number($MeAndChildren_MinY)" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="number($Following_MinY)" />
							</xsl:otherwise>
						</xsl:choose>

						<xsl:text> </xsl:text>

						<xsl:choose>
							<xsl:when
								test="($Following_MaxX = '-Infinity') and ($MeAndChildren_MaxX = '-Infinity')">
								<xsl:text>-Infinity</xsl:text>
							</xsl:when>
							<xsl:when
								test="($Following_MaxX = '-Infinity') or (number($MeAndChildren_MaxX) &gt;= number($Following_MaxX))">
								<xsl:value-of select="number($MeAndChildren_MaxX)" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="number($Following_MaxX)" />
							</xsl:otherwise>
						</xsl:choose>

						<xsl:text> </xsl:text>

						<xsl:choose>
							<xsl:when
								test="($Following_MaxY = '-Infinity') and ($MeAndChildren_MaxY = '-Infinity')">
								<xsl:text>-Infinity</xsl:text>
							</xsl:when>
							<xsl:when
								test="($Following_MaxY = '-Infinity') or (number($MeAndChildren_MaxY) &gt;= number($Following_MaxY))">
								<xsl:value-of select="number($MeAndChildren_MaxY)" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="number($Following_MaxY)" />
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>

					<xsl:otherwise> <!-- element has no siblings -->
						<xsl:value-of select="$MeAndMyChildren_BBox" />
					</xsl:otherwise>

				</xsl:choose>
			</xsl:when>

			<xsl:otherwise> <!-- invisible element (has to call its siblings though) -->
				<xsl:choose>
					<xsl:when test="following-sibling::*">
						<xsl:for-each select="following-sibling::*[position() = 1]">
							<xsl:call-template name="GetBounds" />
						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>Infinity Infinity -Infinity -Infinity</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
