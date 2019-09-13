import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

// Modelos
import 'package:ferreventas/models/pedidos/total.dart';

class TotalPedidosProvider {
  final _totalPedidosController = StreamController<TotalPedidos>.broadcast();

  Function(TotalPedidos) get totalPedidosSink => _totalPedidosController.sink.add;
  Stream<TotalPedidos> get totalPedidosStream => _totalPedidosController.stream;

  void disposeStreams() {
    _totalPedidosController?.close();
  }

  Future<TotalPedidos> _procesarRespuesta(Uri uri) async {
    final resp = await http.get(uri);
    final decodeData = json.decode(resp.body);
    final totalPedidos = new TotalPedidos.fromJson(decodeData[0]);
    return totalPedidos;
  }

  Future<TotalPedidos> getTotalPedidos(int idFerrum) async {
    final url = Uri.https('ferremayoristas.com.mx', '/api/asesores.php', {
      'opcion': '5',
      'perid': '$idFerrum'
    });

    final respuesta = await _procesarRespuesta(url);
    totalPedidosSink(respuesta);
    return respuesta;
  }
}