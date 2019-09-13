import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Sockets
import 'package:ferreventas/sockets/socket.dart';

// Importamos el ícono de Facebook
// import 'package:ferreventas/icons/face_icon_icons.dart';

// Localización
import 'package:ferreventas/Providers/location/location_provider.dart';

// Providers
import 'package:ferreventas/Providers/gets/pedidos/total.dart';

// Widget
import 'package:ferreventas/widgets/fondo_wallpaper_widget.dart';

// Preferencias de Usuario
import 'package:ferreventas/preferes/preferencias_usuario.dart';

class InicioPage extends StatefulWidget {
  @override
  _InicioPageState createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  final socket = new WebSocket();
  final prefs = new PreferenciasUsuario();
  final posicion = PosicionProvider();
  final pedTotaProvider = new TotalPedidosProvider();
  final formatCurrency = new NumberFormat.simpleCurrency();

  double lat = 0.00;
  double lng = 0.00;
  DateTime time = new DateTime.now();

  Icon iconoStatus;

  @override
  void initState() {
    super.initState();
    socket.initSockets();
    _obtenerPosicion();
    pedTotaProvider.getTotalPedidos(prefs.idFerrum);
    iconoStatus = Icon(Icons.portable_wifi_off);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          FondoWallpaperWidget(),
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  FutureBuilder(
                    future: pedTotaProvider.getTotalPedidos(prefs.idFerrum),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return Text('${snapshot.data.cantidad}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 70.0), textAlign: TextAlign.end);
                      } else {
                        return Text('${formatCurrency.format(0)}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 70.0), textAlign: TextAlign.end);
                      }
                    }
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text('${prefs.nombre}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.0), textAlign: TextAlign.end),
                      SizedBox(width: 10.0),
                      Image(
                        image: NetworkImage('https://ferremayoristas.com.mx:3001/img/usuarios/${prefs.imagen}'),
                        height: 40.0,
                        width: 40.0,
                      ),
                    ],
                  ),
                  FutureBuilder(
                    future: pedTotaProvider.getTotalPedidos(prefs.idFerrum),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return Text('${formatCurrency.format(snapshot.data.importe)}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0), textAlign: TextAlign.end);
                      } else {
                        return Text('${formatCurrency.format(0)}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0), textAlign: TextAlign.end);
                      }
                    }
                  ),
                  // Text('28,129.59MXN', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0), textAlign: TextAlign.end),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text('$lat', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10.0), textAlign: TextAlign.end),
                      Text('$lng', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10.0), textAlign: TextAlign.end),
                      Icon(Icons.location_on, color: Colors.white, size: 15.0)
                    ],
                  ),
                  Divider(color: Colors.white, height: 20.0, indent: 100.0),
                  Table(
                    columnWidths: {1: FractionColumnWidth(0.2), 2: FractionColumnWidth(0.2), 3: FractionColumnWidth(0.2)},
                    defaultColumnWidth: FlexColumnWidth(30.0),
                    children: [
                      TableRow(
                        children: [
                          SizedBox(height: 10.0),
                          IconButton(
                            icon: Icon(Icons.people, color: Colors.white,),
                            onPressed: () {
                              Navigator.pushNamed(context, 'home');
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.whatshot, color: Colors.white,),
                            onPressed: () {
                              Navigator.pushNamed(context, 'cartera');
                            },
                          ),
                        ]
                      ),
                      TableRow(
                        children: [
                          SizedBox(height: 10.0),
                          IconButton(
                            icon: Icon(Icons.cancel, color: Colors.white,),
                            onPressed: () {
                              Navigator.pushNamed(context, 'cance-lista');
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.add_shopping_cart, color: Colors.white,),
                            onPressed: () {
                              print('pedidos');
                            },
                          ),
                        ]
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      StreamBuilder<int>(
                        stream: socket.conectadoStream,
                        initialData: 0,
                        builder: (BuildContext context, AsyncSnapshot snap) {
                          if (!snap.hasData) {
                            return Icon(Icons.portable_wifi_off, color: Colors.white, size: 30.0);
                          }

                          if (snap.data == 1) {
                            return Icon(Icons.vpn_lock, color: Colors.green, size: 30.0);
                          } else {
                            return Icon(Icons.vpn_lock, color: Colors.white, size: 30.0);
                          }
                        },
                      ),
                      SizedBox(width: 15.0),
                      Icon(Icons.cloud_queue, color: Colors.green, size: 30.0),
                      SizedBox(width: 10.0),
                      IconButton(
                        icon: Icon(Icons.tap_and_play, color: Colors.white, size: 30.0),
                        onPressed: () {
                          pedTotaProvider.getTotalPedidos(prefs.idFerrum);
                          _obtenerPosicion();
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _obtenerPosicion() async {
    await posicion.getPosicion().then((loc) {
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
    // _entrada(time: '$time', lat: lat, lng: lng, clienteid: clienteid, idFerrum: idFerrum);
  }
}

// FondoWidget(),
//           SingleChildScrollView(
//             child: Center(
//               child: Container(
//                 padding: EdgeInsets.all(5.0),
//                 child: Column(
//                   children: <Widget>[
//                     SizedBox(height: 100.0,),
//                     Container(
//                       height: 80.0,
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           begin: Alignment.topCenter,
//                           end: Alignment.bottomCenter,
//                           colors: [
//                             Color.fromRGBO(250, 250, 250, 1.0),
//                             Color.fromRGBO(250, 250, 250, 1.0)
//                           ],
//                         ),
//                         border: Border.all(color: Colors.white, style: BorderStyle.solid, width: 3.0),
//                         borderRadius: BorderRadius.circular(50.0),
//                       ),
//                       child: Image.network('https://ferremayoristas.com.mx:3001/img/usuarios/${prefs.imagen}'),
//                     ),
//                     Center(
//                       child: Container(
//                         padding: EdgeInsets.all(5.0),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: <Widget>[
//                             Text(
//                               'Bienvenido!',
//                               style: TextStyle(
//                                 fontSize: 30.0,
//                                 color: Color.fromRGBO(60,64,95, 1.0),
//                                 height: 5.0
//                               )
//                             ),
//                             Text('Aquí encontraras toda la información necesaria de tu cartera, formatos, lista de precios, consultas, existencias, levantar pedidos, etc.',
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 fontSize: 13.0,
//                                 color: Color.fromRGBO(60,64,95, 1.0)
//                               )
//                             ),
//                             SizedBox(height: 10.0),
//                             Text(
//                               'Síguenos en',
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 fontSize: 20.0,
//                                 color: Color.fromRGBO(60,64,95, 1.0),
//                                 height: 2.0
//                               )
//                             ),
//                             Container(
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: <Widget>[
//                                   Card(
//                                     borderOnForeground: true,
//                                     child: Container(
//                                       padding: EdgeInsets.all(2.0),
//                                       child: IconButton(
//                                         color: Theme.of(context).primaryColor,
//                                         icon: Icon(FaceIcon.facebook),
//                                         onPressed: () {
//                                           launch('https://www.facebook.com/FerremayoristasOlvera');
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                   Card(
//                                     borderOnForeground: true,
//                                     child: Container(
//                                       padding: EdgeInsets.all(2.0),
//                                       child: IconButton(
//                                         color: Theme.of(context).primaryColor,
//                                         icon: Icon(Icons.vpn_lock),
//                                         onPressed: () {
//                                           launch('https://ferremayoristas.com.mx/');
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(height: 80.0),
//                             ListTile(
//                               title: Text(
//                                 'Siguiente',
//                                 style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColor),
//                                 textAlign: TextAlign.center,
//                               ),
//                               onTap: () {
//                                 print('Ir a Home');
//                                 Navigator.pushNamed(context, 'home');
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),