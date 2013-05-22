<?xml version="1.0"?>
<xsl:stylesheet 
    version   ="1.0" 
    xmlns:xsl ="http://www.w3.org/1999/XSL/Transform"
    xmlns:wadl="http://wadl.dev.java.net/2009/02"
>
    <xsl:template match="/" >
        <html>
            <head></head>
            <body>
                <xsl:apply-templates />
            </body>
        </html>
    </xsl:template>
    <xsl:template match="/wadl:application/wadl:resources/wadl:resource/wadl:resource" >
        <xsl:variable name="resourceLink">
            <xsl:value-of select="../../@base" /><xsl:value-of select="../@path" /><xsl:value-of select="@path" />
        </xsl:variable>
        <xsl:element name="a" >
            <xsl:attribute name="href" >
                <xsl:value-of select="$resourceLink" />
            </xsl:attribute>
            <xsl:attribute name="type" >
                <!--  TODO not sure, but it looks like rest implementation we are using ignores this in lie of ?_type=json :( -->
                <xsl:value-of select="application/json" />
            </xsl:attribute>
            <xsl:value-of select="$resourceLink" />
        </xsl:element>
        <br/>
   </xsl:template>   
</xsl:stylesheet>


