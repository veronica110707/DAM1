function CambiarTexto() {
    let texto = document.getElementById("idTexto").value //value es el contenido
    let parrafo = document.createElement("p")
    parrafo.innerHTML = texto
    document.getElementById("idDivTexto").appendChild(parrafo)
    //document.getElementById("idDivTexto").innerHTML = texto
}

function CambiarColorFondo() {
    let colorFondo = document.getElementById("idColorFondo").value
    document.querySelector("#idDivTexto").style.backgroundColor = colorFondo
}

function CambiarColorBorde() {
    let colorBorde = document.getElementById("idColorBorde").value
    document.querySelector("#idDivTexto").style.borderColor = colorBorde

    //document.querySelector("#idDivTexto").style.borderColor = document.
    //getElementById("idColorBorde").value
}

let botonColorTexto = document.getElementById("prueba")
document.writeln(botonColorTexto)
botonColorTexto.addEventListener("click", function(){
    let colorTexto = document.getElementById("idColorTexto").value
    
}) 