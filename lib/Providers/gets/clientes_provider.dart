import 'dart:convert';
// import 'dart:io';

// Modelo
import 'package:ferreventas/models/clientes_model.dart';

// Providers
import 'package:ferreventas/Providers/herramientas/utils_provider.dart';

// HTTP
import 'package:http/http.dart' as http;

class ClientesProvider {
  Future<List<Cliente>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    final clientes = new Clientes.fromJsonList(decodeData['respuesta']);
    return clientes.items;
  }

  Future<List<Cliente>> getClientes({int idFerrum}) async {
    List<Cliente> _clientes = new List();
    final fecha = fechaActual();
    final diaVisita = diaActual();

    final url = Uri(
      scheme: 'https',
      host: 'ferremayoristas.com.mx',
      port: 4111,
      path: '/clientes/dia/$idFerrum/$diaVisita/$fecha'
    );

    final respuesta = await _procesarRespuesta(url);

    _clientes.addAll(respuesta);
    return _clientes;
  }
}