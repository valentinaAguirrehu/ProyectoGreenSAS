/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

// Esperar a que el DOM esté listo
// Asegúrate de que typo.js se haya cargado antes de este script

let diccionario; // Definir globalmente

document.addEventListener("DOMContentLoaded", function () {
    var dictionary = new Typo("es", "diccionario/es_ES.dic", "diccionario/es_ES.aff", {
        dictionaryPath: "/ruta-a-los-archivos/"
    });

    if (!dictionary) {
        console.error("Error: No se pudo cargar el diccionario.");
        return;
    }

    var inputFields = document.querySelectorAll("input[type='text'], textarea");

    inputFields.forEach(function (field) {
        field.addEventListener("input", function () {
            var words = this.value.split(/\s+/);
            words.forEach(word => {
                if (!dictionary.check(word)) {
                    console.log("Error ortográfico detectado:", word);
                    // Aquí puedes resaltar la palabra o mostrar una sugerencia
                }
            });
        });
    });
});
