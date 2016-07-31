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
# - Actualizar el estado de un DTE enviado al SII
#@author Cristobal Esteban Lama Arce, crilam (cristobal.lama[at]redcomercio.cl)
#@version 2016-07-31

# datos a utilizar
url = 'https://libredte.cl'
api_key = ''
rut = 76192083
dte = 33
folio = 42
metodo = 1 # =1 servicio web, =0 correo

# módulos que se usarán
#from libredte.sdk import LibreDTE

# crear cliente
Cliente = LibreDTE.new(api_key, url)

# consultar estado de dte emitido
estado = Cliente.get('/dte/dte_emitidos/actualizar_estado/'+dte.to_s+'/'+folio.to_s+'/'+rut.to_s+'?usarWebservice='+metodo.to_s)
if estado.code !=200 
  puts('Error al obtener el estado del DTE emitido: '+estado.body)
end
puts(estado.body)