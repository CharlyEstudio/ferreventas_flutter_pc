import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:ferreventas/models/ubicacion/ubicacion_model.dart';

class EntradaProvider {

  Future<Ubicacion> postEntrada({String time, double latOri, double lngOri, double latDes, double lngDes, int clienteid, int idFerrum}) async {
    // HttpClient client = new HttpClient();
    // client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    final origen = '$latOri,$lngOri';
    final destino = '$latDes,$lngDes';
    // final url = Uri(
    //   scheme: 'https',
    //   host: 'ferremayoristas.com.mx',
    //   port: 4111,
    //   path: '/distance/$time/$origen/$destino/$clienteid/$idFerrum'
    // );

    // // final respuesta = await client.getUrl(url);
    // respuesta.headers.set('content-type', 'aplication/json');

    // final response = await respuesta.close();
    // final decodeData = json.decode(response.transform(utf8.decoder).toString());
    // print(decodeData);

    final url = Uri(
      scheme: 'https',
      host: 'ferremayoristas.com.mx',
      port: 4111,
      path: '/distance/$time/$origen/$destino/$clienteid/$idFerrum'
    );

    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    final usuario = new Ubicacion.fromJson(decodeData);
    return usuario;

    // final reply = Ubicacion.fromJson(decodeData);
    // return reply;
  }
}