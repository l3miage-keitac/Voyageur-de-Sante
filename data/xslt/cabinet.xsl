<?xml version="1.0" encoding="UTF-8"?>


<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:med="http://www.ujf-grenoble.fr/l3miage/medical"
                xmlns:act="http://www.ujf-grenoble.fr/l3miage/actes">
    <xsl:output method="html"/>

    <!-- TODO customize transformation rules 
         syntax recommendation http://www.w3.org/TR/xslt 
    -->
    <!-- Selection de l'infirmière (par son identifiant)-->
    <xsl:param name="destinedId" select="001"/>
    	
    <xsl:variable name="actes" select="document('actes.xml', /)/act:ngap"/>
    
    
    
    <!--Une variable pour faire des espaces -->
    <xsl:variable name="espace" select="' '"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Visites des Patients</title>
                <!-- Inclusion des style et du fichier CSS -->
                <link rel="stylesheet" type="text/css" href="../css/cabinetPage.css" />
                <script type="text/javascript" src="../js/facture.js"></script>
                <script type="text/javascript" src="../js/buttonScript.js"></script>
            </head>
            <body>
                <br/><br/>
                <p>Bonjour 
                    <!-- Recuperer le prenom de l'infirmiere dont l'identifiant est passé en paramètre-->
                    <b><xsl:value-of select="//med:infirmier[@id=$destinedId]/med:prénom/text()"/>,</b>
                </p>

                <p>Aujourd'hui, vous avez
                    <!-- Recuperer le nombre de patients de l'infirmiere dont l'identifiant est passé en paramètre--> 
                    <xsl:value-of select="count(//med:patient/med:visite[@intervenant=$destinedId])"/>
                    <xsl:value-of select="$espace"/>
                    patients 
                </p>

                <p>
                    <h3>Visites du jour :</h3>
                </p>
                <center>
                    <table border="1" bgcolor='#CCCCCC'>
                        <tr>
                            <th>Nom</th>
                            <th>Adresse</th>
                            <th>Soins</th>
                            <th>Facture</th>
                        </tr>
                        <xsl:apply-templates select="//med:patient[med:visite/@intervenant = $destinedId]"/>
                    </table>
                </center>

              
            </body>
        </html>
    </xsl:template>
    
       
    <!-- Template pour récupérer les noms des patients ,leurs adresses et les soins -->
    <xsl:template match="med:patient">
        <tr>
            <td>
                <!-- Recuperation du nom du patient-->
                <xsl:value-of select="med:nom"/>
            </td>
            
            <td> 
                <!-- Si l'étage existe dans l'adresse du patient -->
                <xsl:if test="med:adresse/med:étage">
                    Etage n°<xsl:value-of select="$espace"/><xsl:value-of select= "med:adresse/med:étage/text()"/>,
                    <xsl:value-of select="$espace"/>
                </xsl:if> 
                <!-- Si le numero de la rue existe dans l'adresse du patient -->
                <xsl:if test="med:adresse/med:numéro">
                    <xsl:value-of select="$espace"/><xsl:value-of select= "med:adresse/med:numéro/text()"/>
                    <xsl:value-of select="$espace"/>
                </xsl:if> 
                <xsl:value-of select="med:adresse/med:rue"/>, 
                <xsl:value-of select="$espace"/> 
                <xsl:value-of select="med:adresse/med:ville"/>,
                <xsl:value-of select="$espace"/>
                <xsl:value-of select="med:adresse/med:codePostal"/> 
            </td>
            
            <!-- Recuperation des actes de visite--> 
            <td>
                <xsl:apply-templates select="med:visite[@intervenant=$destinedId]/med:acte"/>
            </td>
            
            <td>
                <!-- Ajout du bouton après la liste des actes -->   
                <input type="button" value="Facture">
                    <xsl:attribute name="onclick">
                        openFacture('<xsl:value-of select="med:prénom"/>',
                        '<xsl:value-of select="med:nom"/>',
                        '<xsl:apply-templates select="med:visite[@intervenant=$destinedId]/med:acte" mode="secondActe"/>')
                    </xsl:attribute>
                </input>
            </td>            
        </tr>                         
    </xsl:template>


    <!-- Template pour afficher les différents soins-->    
    <xsl:template match="med:acte">
        <li>
            <xsl:value-of select="$actes/act:actes/act:acte[@id = current()/@id]/text()"/>
        </li>
    </xsl:template>
 
       
    <!-- Template pour afficher les actes pour la facture-->    
    <xsl:template match="med:acte" mode="secondActe">
        <xsl:value-of select="@id"/><xsl:value-of select="$espace"/> 
    </xsl:template>

</xsl:stylesheet>
