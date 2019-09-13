import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

// Modelos
import 'package:ferreventas/models/pedidos/surtir.dart';

class SurtirProvider {
  final _surtirController = StreamController<Surtir>.broadcast();

  Function(Surtir) get surtirSink => _surtirController.sink.add;
  Stream<Surtir> get surtirStream => _surtirController.stream;

  void disposeStreams() {
    _surtirController?.close();
  }

  Future<Surtir> _procesarRespuesta(Uri uri) async {
    final resp = await http.get(uri);
    final decodeData = json.decode(resp.body);
    final surtir = new Surtir.fromJson(decodeData[0]);
    return surtir;
  }

  Future<Surtir> getSurtir(int idFerrum) async {
    final url = Uri.https('ferremayoristas.com.mx', '/api/asesores.php', {
      'opcion': '2',
      'perid': '$idFerrum'
    });

    final respuesta = await _procesarRespuesta(url);
    surtirSink(respuesta);
    return respuesta;
  }
}