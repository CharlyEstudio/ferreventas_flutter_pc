import 'dart:io';
import 'package:flutter/material.dart';

// Providers
import 'package:ferreventas/Providers/gets/usuario_provider.dart';

// Preferencias de Usuario
import 'package:ferreventas/preferes/preferencias_usuario.dart';

// Sockets
import 'package:ferreventas/sockets/socket.dart';

// Plugins
import 'package:imei_plugin/imei_plugin.dart';
import 'package:device_info/device_info.dart';

// Pages
import 'package:ferreventas/pages/inicio_page.dart';
import 'package:ferreventas/pages/home_page.dart';
import 'package:ferreventas/pages/cartera_page.dart';
import 'package:ferreventas/pages/cancelados_lista_page.dart';
import 'package:ferreventas/pages/existencias_page.dart';
import 'package:ferreventas/pages/clientes_page.dart';
import 'package:ferreventas/pages/cliente_page.dart';

Map<int, Color> color = {
  50: Color.fromRGBO(239,47,36, .1),
  100: Color.fromRGBO(239,47,36, .2),
  200: Color.fromRGBO(239,47,36, .3),
  300: Color.fromRGBO(239,47,36, .4),
  400: Color.fromRGBO(239,47,36, .5),
  500: Color.fromRGBO(239,47,36, .6),
  600: Color.fromRGBO(239,47,36, .7),
  700: Color.fromRGBO(239,47,36, .8),
  800: Color.fromRGBO(239,47,36, .9),
  900: Color.fromRGBO(239,47,36, 1),
};

void main() async {
  final usuarioProv = new UsuarioProvider();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();

  var imei;
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  if (Platform.isIOS) {
    IosDeviceInfo iOSInfo = await deviceInfo.iosInfo;
    imei = iOSInfo.identifierForVendor;
  } else {
    // imei = await ImeiPlugin.getImei();
    // AndroidDeviceInfo imei = await deviceInfo.androidInfo;
    print('Android');
    imei = await ImeiPlugin.getImei();
    print(imei);
  }

  // imei = '357135086465138';
  // imei = '357135086465138';
  // imei = '357135086465138';
  // imei = '357135086465138'; // Miguel Angeles
  // imei = '351813093354539'; // Ivan Espriu
  prefs.imeiMobile = imei;

  final datos = await usuarioProv.getUsuario(imei: imei);

  if (datos.id != 'NOT') {
    prefs.nombre = datos.nombre;
    prefs.imagen = datos.img;
    prefs.idFerrum = datos.idFerrum;
    prefs.email = datos.email;
  }

  runApp(MyApp());
}
 
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final socket = new WebSocket();
  MaterialColor colorCustom = MaterialColor(0xFFEF2F24, color);

  @override
  void initState() {
    super.initState();
    initSocket();
  }

  initSocket() async {
    await socket.initSockets();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ferreventas',
      theme: ThemeData(
        primarySwatch: colorCustom
        // primarySwatch: Colors.teal
        // primarySwatch: Colors.amber
      ),
      initialRoute: 'inicio',
      routes: {
        'inicio': (BuildContext context) => InicioPage(),
        'home': (BuildContext context) => HomePage(),
        'cartera': (BuildContext context) => CarteraPage(),
        'cance-lista': (BuildContext context) => CanceladosListaPage(),
        'existencias': (BuildContext context) => ExistenciasPage(),
        'clientes': (BuildContext context) => ClientesPage(),
        'cliente': (BuildContext context) => ClientePage(),
      },
    );
  }
}