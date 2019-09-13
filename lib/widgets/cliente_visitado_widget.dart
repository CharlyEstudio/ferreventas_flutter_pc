import 'package:flutter/material.dart';

// Preferencias de Usuario
import 'package:ferreventas/preferes/preferencias_usuario.dart';

// Providers
import 'package:ferreventas/Providers/location/location_provider.dart';
import 'package:ferreventas/Providers/posts/entrada_provider.dart';

class ClientesVisitadosWidget extends StatefulWidget {
  final cliente;
  final nombre;
  final numero;
  final clienteId;
  final lat;
  final lng;
  final visitado;


  ClientesVisitadosWidget({@required this.cliente, @required this.nombre, @required this.lat, @required this.lng, @required this.numero, @required this.clienteId, @required this.visitado});

  @override
  _ClientesVisitadosWidgetState createState() => _ClientesVisitadosWidgetState();
}

class _ClientesVisitadosWidgetState extends State<ClientesVisitadosWidget> {
  final posicion = PosicionProvider();
  final prefs = PreferenciasUsuario();
  final entrada = new EntradaProvider();

  double lat = 0.00;
  double lng = 0.00;
  int clienteid = 0;
  int idFerrum = 0;
  DateTime time = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${widget.nombre}', style: TextStyle(fontSize: 12.0)),
      subtitle: Text('${widget.numero}'),
      trailing: Icon(
        Icons.chevron_right,
        color: Theme.of(context).primaryColor,
      ),
      onTap: () {
        _obtenerPosicion(latCli: widget.lat, lngCli: widget.lng);
      },
      selected: widget.visitado,
    );
  }

  _obtenerPosicion({double latCli, double lngCli}) async {
    await posicion.getPosicion().then((loc) {
      // print(loc.latitude);
      // print(loc.longitude);
      // print(loc.speed);
      // print(loc.speedAccuracy);
      // print(loc.timestamp);
      // print(loc.altitude);
      // print(loc.heading);
      // print(loc.mocked);
      // print(loc.accuracy);
      lat = loc.latitude;
      lng = loc.longitude;
      time = loc.timestamp;
      setState(() {});
    });
    _entrada(time: '$time', lat: 37.4219983, lng: -122.084, latCli: 37.4219983, lngCli: -122.084, clienteid: clienteid, idFerrum: idFerrum);
    // Correcto // _entrada(time: '$time', lat: lat, lng: lng, latCli: latCli, lngCli: lngCli, clienteid: clienteid, idFerrum: idFerrum);
  }

  _entrada({String time, double lat, double lng, double latCli, double lngCli, int clienteid, int idFerrum}) async {
    Navigator.pushNamed(context, 'cliente', arguments: widget.cliente);
    // entrada.postEntrada(time: time, latOri: lat, lngOri: lng, latDes: latCli, lngDes: lngCli, clienteid: clienteid, idFerrum: idFerrum).then((resp) {
    //   if (resp.status) {
    //     Navigator.pushNamed(context, 'cliente', arguments: widget.cliente);
    //   } else {
    //     _showModalSheet();
    //   }
    // });
  }

  void _showModalSheet() {
    showModalBottomSheet(context: context, builder: (builder) {
      return Container(
        child: Text('No te encuentras con el cliente.'),
        padding: EdgeInsets.all(40.0),
      );
    });
  }
}