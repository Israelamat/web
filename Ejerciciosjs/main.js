//Ejercicio 1 Crea una función que imprima por consola la fecha actual en los siguientes formatos:
//mm-dd-aaaa, mm/dd/aaaa 

function formatoFecha(){
    let hoy = new Date();
    document.write(hoy.getMonth() + "/" + hoy.getDate() + "/" + hoy.getFullYear() + "<br>");
    document.write(hoy.toLocaleDateString() + "<br>");
}

document.write("<b>Ejercicio 1 Crea una función que imprima por consola la fecha actual en los siguientes formatos:</b>" + 
    "<b>mm-dd-aaaa, mm/dd/aaaa o dd-mm-aaaa, dd/mm/aaaa</b><br>")
formatoFecha();

//Ejercicio 2 Crea una función calcule los días que quedan para la siguiente Navidad. Has de mostrar el resultado en el HTML. 
function diasHastaNavidad(){
    let hoy = new Date();
    let navidad = hoy.getFullYear();

    if (hoy.getMonth() == 11 && hoy.getDate() > 25) {
    navidad = navidad + 1;
    }

    let fechaNavidad = new Date(navidad, 11, 25);
    let diaEnMilisegundos = 1000 * 60 * 60 * 24;

    let diasRestantes = Math.ceil(
    (fechaNavidad.getTime() - hoy.getTime()) /
    (diaEnMilisegundos));

   document.write("There are " + diasRestantes +
   " days remaining until Christmas.<br>");
}

document.write("<b>Ejercicio 2 Crea una función calcule los días que quedan para la siguiente Navidad. Has de mostrar el resultado en el HTML.</b><br>")
diasHastaNavidad();

//Ejercicio 3 Crea una función que muestre por consola el día y la hora actual en el siguiente formato.  
function today(){
    let hoy = new Date();
    let diasSemana = ["lunes", "martes", "miércoles", "jueves", "viernes", "sábado", "domingo"];
    let numeroDiaSeemana = hoy.getDay();

    let horas = hoy.getHours();
    let minutos = hoy.getMinutes();
    let segundos = hoy.getSeconds();

    document.write("Hoy es: " + diasSemana[numeroDiaSeemana]);
    document.write("<br>La hora actual es: " + horas + " PM : " + minutos + " : " + segundos);
}

document.write("<b>Ejercicio 3 Crea una función que muestre por consola el día y la hora actual en el siguiente formato.</b>")
today();


let array = [4,8,3,9];

array.unshift(1);
console.log(array);
array.push(2);
console.log(array);

array.splice(3,5);
console.log(array);

array.reverse();
console.log(array);