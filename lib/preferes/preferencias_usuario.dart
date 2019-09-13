import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {

  static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // GET & SET IMEI
  get imeiMobile {
    return _prefs.getString('imeiMobile') ?? '351813093354539';
  }

  set imeiMobile(String value) {
    _prefs.setString('imeiMobile', value);
  }

  // GET & SET Nombre Usuario
  get nombre {
    return _prefs.getString('nombre') ?? 'Sin Usuario';
  }

  set nombre(String value) {
    _prefs.setString('nombre', value);
  }

  // GET & SET Img Usuario
  get imagen {
    return _prefs.getString('img') ?? 'xxx';
  }

  set imagen(String value) {
    _prefs.setString('img', value);
  }

  // GET & SET idFerrum Usuario
  get idFerrum {
    return _prefs.getInt('idFerrum') ?? 11;
  }

  set idFerrum(int value) {
    _prefs.setInt('idFerrum', value);
  }

  // GET & SET Email Usuario
  get email {
    return _prefs.getString('email') ?? 'Sin Correo';
  }

  set email(String value) {
    _prefs.setString('email', value);
  }
}