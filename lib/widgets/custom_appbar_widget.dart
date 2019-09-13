import 'package:flutter/material.dart';

// Socket
import 'package:ferreventas/sockets/socket.dart';

// Preferencias de Usuario
import 'package:ferreventas/preferes/preferencias_usuario.dart';

class CustomAppBarWidget extends StatefulWidget {
  @override
  _CustomAppBarWidgetState createState() => _CustomAppBarWidgetState();
}

class _CustomAppBarWidgetState extends State<CustomAppBarWidget> {
  final socket = new WebSocket();
  final prefs = new PreferenciasUsuario();

  @override
  void initState() {
    super.initState();
    socket.initSockets();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      snap: true,
      expandedHeight: 350.0,
      actions: <Widget>[
        StreamBuilder<int>(
          stream: socket.conectadoStream,
          builder: (BuildContext context, AsyncSnapshot snap) {
            return Icon(
              snap.data == 1 ? Icons.vpn_lock : Icons.portable_wifi_off,
            );
          },
        ),
        SizedBox(width: 10.0),
        // FotoUserWidget(foto: prefs.imagen),
        SizedBox(width: 10.0)
      ],
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        // titlePadding: EdgeInsets.only(bottom: 100.0),
        title: Text(
          prefs.nombre,
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
        background: Image(image: AssetImage('assets/img/1.jpg'), fit: BoxFit.cover),
      ),
    );
  }
}