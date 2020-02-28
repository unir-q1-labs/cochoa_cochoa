<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!-- This XSL file converts the Rule Project Statistics Report XML information
into a series of HTML tables. Place the file in the same directory as the Rule Project
Statistics XML file and it will be applied if you open the XML file in a web browser that
supports XSL (most do). -->

<!-- Start of the template, matches the root of the document -->
<xsl:template match="/">
  <html>
  <head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <title><xsl:value-of select="rule-projects/metadata/main-title"/></title>
  <title>Rule Project Statistics Report</title>
  <style type="text/css">
body
{
	line-height: 1.6em;
	font-family: "Lucida Sans Unicode", "Lucida Grande", Sans-Serif;
	font-size: 16px;
}

#box-table-a
{
	font-family: "Lucida Sans Unicode", "Lucida Grande", Sans-Serif;
	font-size: 12px;
	margin: 45px;
	width: 480px;
	text-align: left;
	border-collapse: collapse;
}
#box-table-a th
{
	font-size: 13px;
	font-weight: normal;
	padding: 8px;
	background: #b9c9fe;
	border-top: 4px solid #aabcfe;
	border-bottom: 1px solid #fff;
	color: #039;
}
#box-table-a td
{
	padding: 8px;
	background: #e8edff; 
	border-bottom: 1px solid #fff;
	color: #669;
	border-top: 1px solid transparent;
}
#box-table-a tr:hover td
{
	background: #d0dafd;
	color: #339;
}
   </style>
   </head>
  <body>
  <h1><xsl:value-of select="rule-projects/metadata/main-title"/></h1>
  <h2><xsl:value-of select="rule-projects/metadata/table-content"/></h2>
   	<ol>
		<xsl:for-each select="rule-projects/rule-project">
		<xsl:sort select="@display-name"/>
			<li>
				<xsl:element name="a">
					<xsl:attribute name="href">#
						<xsl:value-of select="@display-name"/>
					</xsl:attribute>
					<xsl:value-of select="@display-name"/>
				</xsl:element>
			</li>
		</xsl:for-each>
	</ol>
  	<xsl:apply-templates/>
  </body>
  </html>
</xsl:template>


<!-- Just to ot display the metadata -->
<xsl:template match="metadata">
</xsl:template>

<!-- Template to display the details for rule projects -->
<xsl:template match="rule-project">
	<hr/>
	<xsl:element name="h2">
		<xsl:attribute name="id"><xsl:value-of select="@display-name"/></xsl:attribute>
		<xsl:value-of select="@display-name"/>
	</xsl:element>
	<hr/>
	<p>
	<table id="box-table-a" summary="Rule Project Properties">
		<thead>
    		<tr>
    			<th scope="col"><xsl:value-of select="../metadata/column-name-property"/></th>
    			<th scope="col"><xsl:value-of select="../metadata/column-name-value"/></th>
    		</tr>
    	</thead>
    	<tbody>
      <tr><td><xsl:value-of select="../metadata/row-name-documentation"/></td><td><xsl:value-of select="documentation"/></td></tr>
	  <tr><td><xsl:value-of select="../metadata/row-name-advanced-properties"/></td><td><xsl:value-of select="advanced-properties"/></td></tr>
	  <tr><td><xsl:value-of select="../metadata/row-name-categories"/></td><td><xsl:value-of select="categories"/></td></tr>
	  <tr><td><xsl:value-of select="../metadata/row-name-dependencies"/></td><td><xsl:value-of select="dependencies"/></td></tr>
	  <tr><td><xsl:value-of select="../metadata/row-name-parameters"/></td><td><xsl:value-of select="parameters"/></td></tr>
	  <tr><td><xsl:value-of select="../metadata/row-name-referencing-projects"/></td><td><xsl:value-of select="referencing-projects"/></td></tr>
	  <tr><td><xsl:value-of select="../metadata/row-name-schema-dependencies"/></td><td><xsl:value-of select="schema-dependencies"/></td></tr>
	  </tbody>
	</table>
	<xsl:apply-templates select="artifacts/*">
		<xsl:sort select="name()"/>
	</xsl:apply-templates>
	</p>
</xsl:template>

<!-- Template that can be applied to all artifacts in the report -->
<xsl:template match="artifacts/*">
  <h3><xsl:value-of select="./description"/> (<xsl:value-of select="@count"/>)</h3>
  <p>
  <table id="box-table-a" summary="Artifact Statistics">
    <thead>
    <tr>
    	<th scope="col"><xsl:value-of select="../../../metadata/column-name-statistic"/></th>
    	<th scope="col"><xsl:value-of select="../../../metadata/column-name-min"/></th>
    	<th scope="col"><xsl:value-of select="../../../metadata/column-name-max"/></th>
    	<th scope="col"><xsl:value-of select="../../../metadata/column-name-mean"/></th>
    	<th scope="col"><xsl:value-of select="../../../metadata/column-name-sum"/></th>
    </tr>
    </thead>
    <tbody>
    <xsl:apply-templates select="*/min"/>
    </tbody>
	<tfoot>
		<tr>
			<td colspan="5"><em><xsl:value-of select="../../../metadata/footer-notes"/></em></td>
		</tr>
	</tfoot>
  </table>
  </p>
</xsl:template>

<!-- Template that matches against 'min' and renders the description, min, max, mean and sum for an 
individual statistics attribute. -->
<xsl:template match="*/min">
<tr>
  <!--td><xsl:value-of select="name(..)"/></td-->
  <td><xsl:value-of select="../description"/></td>
  <td><xsl:value-of select="../min"/></td>
  <td><xsl:value-of select="../max"/></td>
  <td><xsl:value-of select="../mean"/></td>
  <td><xsl:value-of select="../sum"/></td>
</tr>
</xsl:template>

</xsl:stylesheet>