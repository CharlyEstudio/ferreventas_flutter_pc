import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

// Modelos
import 'package:ferreventas/models/pedidos/remision.dart';

class RemisionProvider {
  final _remisionController = StreamController<Remision>.broadcast();

  Function(Remision) get remisionSink => _remisionController.sink.add;
  Stream<Remision> get remisionStream => _remisionController.stream;

  void disposeStreams() {
    _remisionController?.close();
  }

  Future<Remision> _procesarRespuesta(Uri uri) async {
    final resp = await http.get(uri);
    final decodeData = json.decode(resp.body);
    final remision = new Remision.fromJson(decodeData[0]);
    return remision;
  }

  Future<Remision> getRemision(int idFerrum) async {
    final url = Uri.https('ferremayoristas.com.mx', '/api/asesores.php', {
      'opcion': '3',
      'perid': '$idFerrum'
    });

    final respuesta = await _procesarRespuesta(url);
    remisionSink(respuesta);
    return respuesta;
  }
}