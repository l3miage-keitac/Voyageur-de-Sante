/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/javascript.js to edit this template
 */

function openFacture(prenom, nom, actes) {
   var width  = 500;
   var height = 300;
   if(window.innerWidth) {
       var left = (window.innerWidth-width)/2;
       var top = (window.innerHeight-height)/2;
   }
   else {
       var left = (document.body.clientWidth-width)/2;
       var top = (document.body.clientHeight-height)/2;
   }
   var factureWindow = window.open('','facture','menubar=yes, scrollbars=yes, top='+top+', left='+left+', width='+width+', height='+height+'');
   factureText = afficherFacture(prenom, nom, actes);
   factureWindow.document.write(factureText);
}