let nombre = document.getElementById("user");
let mail = document.getElementById("mail");

function moificarElementos(elemento){

    elemento.addEvenListener("blur", function(event){
        if(elemento.value === ""){
            elemento.style.backgroundcolor = "red";
        }else{
            elemento.style.backgroundcolor = "White";            
        }        
    });

    elemento.addEvenListener("focus", function (event){
        elemento.style.backgroundcolor = "yellow";
    })
};

moificarElementos(nombre);
moificarElementos(mail);
