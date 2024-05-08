<?xml version="1.0" encoding="UTF-8"?>


<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:med="http://www.ujf-grenoble.fr/l3miage/medical"
                xmlns:act="http://www.ujf-grenoble.fr/l3miage/actes">
    
    <xsl:output method="html"/>

    <!-- TODO customize transformation rules 
         syntax recommendation http://www.w3.org/TR/xslt 
    -->
    <xsl:variable name="espace" select="' '"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>fichePatient</title>
                <!-- Inclusion du style de la page -->
                <link rel="stylesheet" type="text/css" href="../css/patientPage.css" />
            </head>
            <body>
                <br/><br/>
                <h2>Bonjour<xsl:value-of select="$espace"/>
                    <q>
                        <xsl:value-of select="med:patient/med:sexe" />.
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="med:patient/med:nom" />
                    </q>
                </h2>
                
                <h4>VOS INFORMATIONS :<b/></h4>
                
                <p>
                    <b>Nom : </b><xsl:value-of select="med:patient/med:nom/text()"/>
                </p>
                
                <p>
                    <b>Prenom : </b> 
                    <xsl:value-of select="med:patient/med:prénom/text()"/>
                </p>
                
                <p>
                    <b>Sexe : </b><xsl:value-of select="med:patient/med:sexe/text()"/>
                </p>
                
                <p><b>Date de naissance : </b><xsl:value-of select="med:patient/med:naissance/text()"/></p>
                <p><b>Sécurité sociale : </b><xsl:value-of select="med:patient/med:numéroSS/text()"/></p>
                <p><b>Adresse : </b>
                    <xsl:value-of select="med:patient/med:adresse/med:rue"/>, 
                    <xsl:value-of select="$espace"/>
                    <xsl:value-of select="med:patient/med:adresse/med:codePostal"/>
                    <xsl:value-of select="$espace"/>
                    <xsl:value-of select="med:patient/med:adresse/med:ville"/>
                </p>
                
                <h3>Vos visites : </h3>
                
                <center>
                    <table border="1" >
                        <tr>
                            <th>Date</th>
                            <th>Acte</th>
                            <th>Intervenant</th>
                        </tr>
                        <xsl:apply-templates select="med:patient/med:visite"/>
                    </table>                    
                </center>                                 
            </body>
        </html>
    </xsl:template>
    
    
    <!--Template pour recuperer les visites du patient-->
    <xsl:template match="med:visite">
        <tr>
            <td>
                <xsl:value-of select="@date"/>
            </td>
            <td>
                <ul>
                    <xsl:apply-templates select="med:acte"/>
                </ul>                
            </td>
            <td>
                <xsl:value-of select="med:intervenant/med:nom/text()"/>
                <xsl:value-of select="$espace"/>
                <xsl:value-of select="med:intervenant/med:prénom/text()"/>
            </td>
        </tr>
    </xsl:template>


    <!--Template pour recuperer les Actes à effectuer-->
    <xsl:template match="med:acte">
        <li>
            <xsl:value-of select="text()"/>
        </li>
    </xsl:template>  

</xsl:stylesheet>
