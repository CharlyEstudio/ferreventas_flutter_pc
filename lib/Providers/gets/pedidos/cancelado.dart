import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

// Modelos
import 'package:ferreventas/models/pedidos/cancelado.dart';

class CanceladoProvider {
  final _canceladoController = StreamController<Cancelado>.broadcast();

  Function(Cancelado) get canceladoSink => _canceladoController.sink.add;
  Stream<Cancelado> get canceladoStream => _canceladoController.stream;

  void disposeStreams() {
    _canceladoController?.close();
  }

  Future<Cancelado> _procesarRespuesta(Uri uri) async {
    final resp = await http.get(uri);
    final decodeData = json.decode(resp.body);
    final cancelado = new Cancelado.fromJson(decodeData[0]);
    return cancelado;
  }

  Future<Cancelado> getCancelado(int idFerrum) async {
    final url = Uri.https('ferremayoristas.com.mx', '/api/asesores.php', {
      'opcion': '4',
      'perid': '$idFerrum'
    });

    final respuesta = await _procesarRespuesta(url);
    canceladoSink(respuesta);
    return respuesta;
  }
}