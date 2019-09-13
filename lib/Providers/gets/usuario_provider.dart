import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

// Modelos
import 'package:ferreventas/models/usuario_model.dart';

class UsuarioProvider {

  bool _cargando = false;

  final _usuariosStreamController = StreamController<Usuario>.broadcast();

  Function(Usuario) get usuarioSink => _usuariosStreamController.sink.add;

  Stream<Usuario> get usuariosStream => _usuariosStreamController.stream;

  void disposeStreams() {
    _usuariosStreamController?.close();
  }

  Future<Usuario> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    if (decodeData['status'] != null) {
      Usuario usuario = new Usuario();
      usuario.id = 'NOT';
      usuario.idFerrum = 0;
      usuario.imei = '';
      usuario.img = '';
      usuario.lat = 0;
      usuario.lng = 0;
      usuario.nombre = '';
      usuario.rol = '';
      usuario.time = 0;
      usuario.velocidad = 0;
      usuario.activo = 'NO';
      usuario.altitud = 0;
      usuario.email = '';
      usuario.exactitud = 0;
      return usuario;
    } else {
      final usuario = new Usuario.fromJson(decodeData);
      return usuario;
    }
  }

  Future<Usuario> getUsuario({String imei}) async {
    if (_cargando) return null;

    _cargando = true;
    final url = Uri(
      scheme: 'https',
      host: 'ferremayoristas.com.mx',
      port: 4111,
      path: 'gps/imei',
      queryParameters: {
        'imei': imei
      }
    );

    final respuesta = await _procesarRespuesta(url);
    _cargando = false;
    return respuesta;
  }
}