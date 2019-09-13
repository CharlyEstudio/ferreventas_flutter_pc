import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

// Modelos
import 'package:ferreventas/models/pedidos/bajar.dart';

class BajarProvider {
  final _bajarController = StreamController<Bajar>.broadcast();

  Function(Bajar) get bajarSink => _bajarController.sink.add;
  Stream<Bajar> get bajarStream => _bajarController.stream;

  void disposeStreams() {
    _bajarController?.close();
  }

  Future<Bajar> _procesarRespuesta(Uri uri) async {
    final resp = await http.get(uri);
    final decodeData = json.decode(resp.body);
    final bajar = new Bajar.fromJson(decodeData[0]);
    return bajar;
  }

  Future<Bajar> getBajar(int idFerrum) async {
    final url = Uri.https('ferremayoristas.com.mx', '/api/asesores.php', {
      'opcion': '1',
      'perid': '$idFerrum'
    });

    final respuesta = await _procesarRespuesta(url);
    bajarSink(respuesta);
    return respuesta;
  }
}