import 'dart:convert';

import 'package:http/http.dart' as http;

// Modelos
import 'package:ferreventas/models/cartera/vencido_model.dart';

class Vencido4660Provider {
  Future<Vencido> getVencido({int idFerrum}) async {
    final url = Uri.https('ferremayoristas.com.mx', '/api/asesores.php', {
      'opcion': '16',
      'perid': '$idFerrum'
    });

    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    final vencido = new Vencido.fromJson(decodeData[0]);
    return vencido;
  }
}