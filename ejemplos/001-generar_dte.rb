#LibreDTE
#Copyright (C) SASCO SpA (https://sasco.cl)

#Este programa es software libre: usted puede redistribuirlo y/o modificarlo
#bajo los términos de la GNU Lesser General Public License (LGPL) publicada
#por la Fundación para el Software Libre, ya sea la versión 3 de la Licencia,
#o (a su elección) cualquier versión posterior de la misma.

#Este programa se distribuye con la esperanza de que sea útil, pero SIN
#GARANTÍA ALGUNA; ni siquiera la garantía implícita MERCANTIL o de APTITUD
#PARA UN PROPÓSITO DETERMINADO. Consulte los detalles de la GNU Lesser General
#Public License (LGPL) para obtener una información más detallada.

#Debería haber recibido una copia de la GNU Lesser General Public License
#(LGPL) junto a este programa. En caso contrario, consulte
#<http://www.gnu.org/licenses/lgpl.html>.


#Ejemplo que muestra los pasos para:
# - Emitir DTE temporal
# - Generar DTE real a partir del temporal
# - Obtener PDF a partir del DTE real
#@author Cristobal Esteban Lama Arce, crilam (cristobal.lama[at]redcomercio.cl)
#@version 2016-07-31


# datos a utilizar
url = "https://libredte.cl"
api_key = ""
dte = {
    'Encabezado': {
        'IdDoc': {
            'TipoDTE': 33,
        },
        'Emisor': {
            'RUTEmisor': '76019824-2',
        },
        'Receptor': {
            'RUTRecep': '66666666-6',
            'RznSocRecep': 'Persona sin RUT',
            'GiroRecep': 'Particular',
            'DirRecep': 'Santiago',
            'CmnaRecep': 'Santiago',
        },
    },
    'Detalle': [
        {
            'NmbItem': 'Producto 1',
            'QtyItem': 2,
            'PrcItem': 1000,
        },
    ],
}

# módulos que se usarán
#from libredte.sdk import LibreDTE

# crear cliente
Cliente = LibreDTE.new(api_key, url)

# crear DTE temporal
emitir = Cliente.post('/dte/documentos/emitir', dte)
if emitir.code != 200 
    puts('Error al emitir DTE temporal: '+emitir.body)
end

# crear DTE real
generar = Cliente.post('/dte/documentos/generar', JSON.parse(emitir.body))
if generar.code != 200 
    puts('Error al generar DTE real: '+generar.body)
end

# obtener el PDF del DTE
generar_pdf_request = {'xml':JSON.parse(generar.body)['xml'], 'compress': false}
generar_pdf = Cliente.post('/dte/documentos/generar_pdf', generar_pdf_request)
if generar_pdf.code!=200
    puts('Error al generar PDF del DTE: '+generar_pdf.body)
end

# guardar PDF en el disco
open('001-generar_dte.pdf', 'wb') { |f|
 f.write(generar_pdf.body)
}
