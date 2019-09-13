import 'dart:async';

import 'package:adhara_socket_io/adhara_socket_io.dart';

const URI = 'https://ferremayoristas.com.mx:3001';

class WebSocket {
  static final WebSocket _instancia = new WebSocket._internal();

  final _socketConecatdoController = StreamController<int>.broadcast();
  Function(int) get conectadoSink => _socketConecatdoController.sink.add;
  Stream<int> get conectadoStream => _socketConecatdoController.stream;

  void disposeStreams() {
    _socketConecatdoController?.close();
  }

  factory WebSocket() {
    return _instancia;
  }

  WebSocket._internal();

  SocketIOManager _manager;
  SocketIO _socket;

  initSockets() async {
    _manager = SocketIOManager();
    _socket = await _manager.createInstance(SocketOptions(
      URI,
      query: {},
      transports: [Transports.WEB_SOCKET, Transports.POLLING]
    ));
    _socket.onConnect((_) {
      print('Conectado');
      estado(true);
    });
    _socket.onDisconnect((_) {
      print('Desconectado');
      estado(false);
    });
    _socket.connect();
  }

  estado(bool state) {
    if (state) {
      conectadoSink(1);
    } else {
      conectadoSink(0);
    }
  }

  accion(String evento, dynamic datos) async {
    if (_socket != null) {
      _socket.emit(evento, [datos]);
    }
  }

  escuchar(String evento) async {
    if (_socket != null) {
      return _socket.on(evento, (data) {
        print(data);
        return data;
      });
    }
  }
}