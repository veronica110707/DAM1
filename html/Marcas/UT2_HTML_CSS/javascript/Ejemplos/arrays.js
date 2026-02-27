// Array numeros aleatorios y ordenalos y mostrar en lista desordenada

Math.random()

let numeros = [] //o = new Array()

let cantidad = Math.floor((Math.random()*20)+1)

for (let index = 0; index < cantidad; index++) {
    numeros.push(Math.floor((Math.random()*99)+10)) //o unshift
}

document.writeln(numeros + "<br>")

// funcion q devuelva el ultimo elemento de un array

function devolverUltimo(array) {
    return array[array.length-1]
}

document.writeln(devolverUltimo(numeros))