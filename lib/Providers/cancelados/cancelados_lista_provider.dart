import 'dart:convert';

// Modelo

// Providers
import 'package:ferreventas/models/cancelados/cancelados_lista_model.dart';

// HTTP
import 'package:http/http.dart' as http;

class CanceladosListaProvider {
  Future<List<CanceladoLista>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    final clientes = new CanceladosLista.fromJsonList(decodeData);
    return clientes.items;
  }

  Future<List<CanceladoLista>> getCancelados({int idFerrum}) async {
    List<CanceladoLista> _clientes = new List();

    final url = Uri.https('ferremayoristas.com.mx', '/api/pedidos.php', {
      'opcion': '49',
      'perid': '$idFerrum'
    });

    final respuesta = await _procesarRespuesta(url);

    _clientes.addAll(respuesta);
    return _clientes;
  }
}