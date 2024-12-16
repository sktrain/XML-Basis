<?xml version="1.0" encoding="UTF-8"?>

<!-- **************************************************************************-->
<!-- ***      Beispiele für Funktionen in XSLT                         ********-->
<!-- **************************************************************************-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  
                xmlns:sample="otto"   
                xmlns:xs="http://www.w3.org/2001/XMLSchema" 
                exclude-result-prefixes="sample xs" version="2.0">

	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
		
	<!--Funktion die eine einfache Berechnung durchführt-->
	<xsl:function name="sample:add" as="xs:integer" >
		<!--<xsl:param name="op1" as="xs:integer" required="yes"/>-->  <!-- required-Attribut erst an Version 3.0) -->
		<xsl:param name="op1" as="xs:integer" />     
		<xsl:param name="op2" as="xs:integer" />
			<xsl:sequence select="$op1 * $op2" /> 
			<!--ist auch möglich mit:  -->
			<!--<xsl:value-of select="$op1 * $op2" />-->
	</xsl:function>
	
	<!--Funktion die ein neues komplexeres Element liefert-->	  
	<xsl:function name="sample:createElement" as="element(employee)" >
		<xsl:element name="employee"> 
			<name id="101" > Hugo </name>
			<department id="50"> Sales </department>
			<job> Programmer </job>
		</xsl:element>
	</xsl:function> 
	
	<!--Funktion die eine Sequenz von  Nodes erwartet und diese mit neue Elementen kombiniert -->
	<!--benutzt jetzt als  Basis Transactions.xml -->
	<xsl:function name="sample:combineElements" as="element()*" >
		<xsl:param name="seq" as="node()*" />
		<xsl:for-each select="$seq" >
		<xsl:sequence select="." />		
		<xsl:element name="employee"> 
			<name id="101" > Hugo </name>
			<department id="50"> Sales </department>
			<job> Programmer </job>
		</xsl:element>
		</xsl:for-each>
	</xsl:function> 
	
	<xsl:template match="/" name="initial-template">
	     <root>
	        <test>
				<xsl:text>&#xA;		Aufruf der create-Funktion und Ausgabe des akkumulierten Textknoten </xsl:text>
				<xsl:value-of select="sample:createElement()" />
				<xsl:text>&#xA;	</xsl:text>
			</test>	
									
			<!--Aufruf der einfachen Funktion-->
			<simplereturn>
				<xsl:value-of select="sample:add(4, 5)" />
			</simplereturn>
			<xsl:text>&#xA;</xsl:text>
			
			<!--Aufruf der create-Funktion-->
			<new_element>
				<xsl:sequence select="sample:createElement()" />
			</new_element>
			
			<!--Aufruf der combine-Funktion-->
			<combine_element>
				<xsl:sequence select="sample:combineElements(/transactions/transaction)" />
			</combine_element>
			
			
	     </root>
	     <xsl:apply-templates />
	</xsl:template>
	
</xsl:stylesheet>
