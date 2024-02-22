// Ejercicio 1
let refranes = ['El que la sigue la consigue', 'Más vale prevenir que curar', 'Quién todo lo quiere, todo lo pierde', 'No por mucho madrugar amanece más temprano', 'Persona prevenida vale por dos'];
let i = 0;

setInterval(function () {
    if (i === refranes.length) {
        i = 0;
    }
    document.getElementById('parrafo').innerHTML = refranes[i];
    i++;
}, 2000);
document.write("<br>");

//Ejercicio 2

 // Acceder al contenido del div y crear un array
 let contenido = document.getElementById("contenido").innerHTML.toLowerCase();
 let contenidoSplit = contenido.split(' ');
 
 // Número de palabras
 document.write("Número de palabras: " + contenidoSplit.length + "<br>");
 
 // Primera palabra
 document.write("Primera palabra: " + contenidoSplit[0] + "<br>");
 
 // Última palabra
 document.write("Última palabra: " + contenidoSplit[contenidoSplit.length - 1] + "<br>");
 
 // Palabras en orden inverso
 document.write("Palabras en orden inverso: " + contenidoSplit.reverse().join(" ") + "<br>");
 
 // Palabras ordenadas de a-z
 document.write("Palabras ordenadas de a-z: " + contenidoSplit.sort().join(" "));
 document.write("<br>")
 document.write("<br>")


//EJERCICIO 3

//Enlace del penultimo enlace
let enlaces = document.getElementsByTagName("a");
let penultimoEnlace = enlaces[enlaces.length - 2];
document.write("Dirección a la que enlaza el penúltimo enlace: " + penultimoEnlace.href);
let contador = 0;
document.write("<br>")

// Mostrar el número de enlaces que enlazan a http://prueba
for (let i = 0; i < enlaces.length; i++) {
  if (enlaces[i].href == enlaces[0].href) {
    contador++;
  }
}
document.write("Número de enlaces que enlazan a http://prueba: " + contador);
document.write("<br>")

// Mostrar el id del tercer párrafo
let parrafos = document.getElementsByTagName("p");
let tercerParrafo = parrafos[2];
document.write("Id del tercer párrafo: " + tercerParrafo.id);




