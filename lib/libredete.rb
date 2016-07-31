#LibreDTE
#Copyright (C) Redcomercio SA (https://www.redcomercio.cl)

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

#Clase con las funcionalidades para integrar con LibreDTE
#@author Cristobal Esteban Lama Arce, crilam (cristobal.lama[at]redcomercio.cl)
#@version 2016-07-31

require 'uri'
require 'net/http'
require 'json'

class LibreDTE 
  
  def initialize (api_key, url = 'https://libredte.cl', ssl_check = true)
    #Constructor de la clase LibreDTE
    #:param hash: hash Hash de autenticación del usuario
    #:param url: Host con la dirección web base de LibreDTE
    #:param ssl_check: si se debe o no verificar el certificado SSL del host
    
    @url = URI.parse(url)
    @api_key = api_key
    @http = Net::HTTP.new(@url.host, @url.port)
    @http.use_ssl = ssl_check
  end
  
  def get (api)
    #Método que consume un servicio web de LibreDTE a través de GET
    #:param api: Recurso de la API que se desea consumir (sin /api)
    
    uri = URI.parse(@url.to_s+"/api"+api)
    request = Net::HTTP::Get.new(uri.request_uri)
    request["authorization"] = @api_key
    #request.basic_auth("username", "password")
    
    return response = @http.request(request)
  end
  
  def post(api, data = None)
    uri = URI.parse(@url.to_s+"/api"+api)
        
    request = Net::HTTP::Post.new(uri.request_uri)
    request["authorization"] = @api_key
    
    request.body = data.to_json
    #request.basic_auth("username", "password")

    return response = @http.request(request)
  end
end
