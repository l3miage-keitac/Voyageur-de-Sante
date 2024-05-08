<?xml version="1.0" encoding="UTF-8"?>


<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:med="http://www.ujf-grenoble.fr/l3miage/medical"
                xmlns:act="http://www.ujf-grenoble.fr/l3miage/actes">
    
    <xsl:output method="xml" indent="yes"/>

    <!-- TODO customize transformation rules 
         syntax recommendation http://www.w3.org/TR/xslt 
    -->
    <xsl:param name="destinedName">Kapoëtla</xsl:param>
    <xsl:variable name="actes" select="document('../xml/actes.xml', /)/act:ngap"/>
    
    
    <xsl:template match="/">
        <patient>
            <xsl:apply-templates select='med:cabinet/med:patients/med:patient[med:nom/text()=$destinedName]'/>
        </patient>
    </xsl:template>
    
    
    <!--Patient-->
    <xsl:template match="med:patient">
        <nom>
            <xsl:value-of select="med:nom/text()"/>
        </nom>
        
        <prénom>
            <xsl:value-of select="med:prénom/text()"/>
        </prénom>
        
        <sexe>
            <xsl:value-of select="med:sexe/text()"/>
        </sexe>
        
        <naissance>
            <xsl:value-of select="med:naissance/text()"/>
        </naissance>
        
        <numéroSS>
            <xsl:value-of select="med:numéro/text()"/>
        </numéroSS>
        
        <adresse>
            <rue>
                <xsl:value-of select="med:adresse/med:rue/text()"/>
            </rue>
                
            <codePostal>
                <xsl:value-of select="med:adresse/med:codePostal/text()"/>
            </codePostal>
            
            <ville>
                <xsl:value-of select="med:adresse/med:ville/text()"/>
            </ville>
        </adresse>
        <xsl:apply-templates select="med:visite">
            <xsl:sort select="date" order="ascending"/>
        </xsl:apply-templates>
    </xsl:template>

    <!--Visite Patient-->
    <xsl:template match="med:visite">
        <xsl:element name="visite">
            <xsl:attribute name="date">
                <xsl:value-of select="@date"/>
            </xsl:attribute>
            <intervenant>
                <xsl:variable name="intervenantId" select="@intervenant"/>
                <nom>
                    <xsl:value-of select="//med:infirmier[@id=$intervenantId]/med:nom/text()"/>
                </nom>
                
                <prénom>
                    <xsl:value-of select="//med:infirmier[@id=$intervenantId]/med:prénom/text()"/>
                </prénom>
            </intervenant>
            <xsl:apply-templates select="med:acte"/>  
        </xsl:element>
    </xsl:template>
        
    <!--Visite Actes du Patients-->
    <xsl:template match="med:acte">
        <acte>
            <xsl:variable name="acteId" select="@id"/>
            <xsl:value-of select="$actes/act:actes/act:acte[@id=$acteId]"/>
        </acte>
    </xsl:template>
    
</xsl:stylesheet>
