import 'dart:convert';

import 'package:http/http.dart' as http;

// Modelos
import 'package:ferreventas/models/existencias/existencias_model.dart';

class ExistenciasProvider {
  Future<Existencias> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    if (decodeData.length > 0) {
      final existencia = new Existencias.fromJson(decodeData[0]);
      return existencia;
    } else {
      Existencias existencias = new Existencias();
      existencias.nombre = 'No existe este código.';
      existencias.existencia = 0;
      existencias.qro = 0;
      existencias.tx = 0;
      existencias.precio = 0.00;
      return existencias;
    }
  }

  Future<Existencias> getExistencias({String codigo}) async {
    final url = Uri.https('ferremayoristas.com.mx', '/api/existencias.php', {
      'opcion': '1',
      'codigo': '$codigo'
    });

    final respuesta = await _procesarRespuesta(url);
    return respuesta;
  }
}