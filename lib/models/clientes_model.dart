class Clientes {
  List<Cliente> items = new List();
  Clientes();

  Clientes.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final cliente = new Cliente.fromJsonMap(item);
      items.add(cliente);
    }
  }
}

class Cliente {
  String uniqueId;
  double disponible;
  int venta;
  String visto;
  int clienteid;
  String fecact;
  String visita;
  String diavis;
  String numero;
  String nombre;
  String rfc;
  String comercio;
  String domicilio;
  String email;
  int perid;
  String asesor;
  double lat;
  double lng;
  int activo;
  String membresia;
  int lista;
  double limite;
  double saldo;
  int dias;
  String ultima;
  String forpag;
  int vencidos;

  Cliente({
    this.clienteid,
    this.disponible,
    this.venta,
    this.fecact,
    this.visita,
    this.diavis,
    this.numero,
    this.nombre,
    this.rfc,
    this.comercio,
    this.domicilio,
    this.email,
    this.perid,
    this.asesor,
    this.lat,
    this.lng,
    this.activo,
    this.membresia,
    this.lista,
    this.limite,
    this.saldo,
    this.dias,
    this.ultima,
    this.forpag,
    this.vencidos
  });

  Cliente.fromJsonMap(Map<String, dynamic> json) {
    clienteid         = json["clienteid"];
    disponible        = 0.00;
    venta             = 0;
    fecact            = json["fecact"];
    visita            = json["visita"];
    diavis            = json["diavis"];
    numero            = json["numero"];
    nombre            = json["nombre"];
    rfc               = json["rfc"];
    comercio          = json["comercio"];
    domicilio         = json["domicilio"];
    email             = json["email"];
    perid             = json["perid"];
    asesor            = json["asesor"];
    lat               = json["lat"] / 1;
    lng               = json["lng"] / 1;
    activo            = json["activo"];
    membresia         = json["membresia"];
    lista             = json["lista"];
    limite            = json["limite"] / 1;
    saldo             = json["saldo"] / 1;
    dias              = json["dias"];
    ultima            = json["ultima"];
    forpag            = json["forpag"];
    vencidos          = json["vencidos"];
  }

  Cliente.fromJsonMapDB(Map<String, dynamic> json) {
    clienteid         = json["clienteid"];
    disponible        = json["disponible"];
    venta             = 0;
    fecact            = json["fecact"];
    visita            = json["visita"];
    diavis            = json["diavis"];
    numero            = json["numero"];
    nombre            = json["nombre"];
    rfc               = json["rfc"];
    comercio          = json["comercio"];
    domicilio         = json["domicilio"];
    email             = json["email"];
    perid             = json["perid"];
    asesor            = json["asesor"];
    lat               = json["lat"] / 1;
    lng               = json["lng"] / 1;
    activo            = json["activo"];
    membresia         = json["membresia"];
    lista             = json["lista"];
    limite            = json["limite"] / 1;
    saldo             = json["saldo"] / 1;
    dias              = json["dias"];
    ultima            = json["ultima"];
    forpag            = json["forpag"];
    vencidos          = json["vencidos"];
  }

  Map<String, dynamic> toJson() => {
    'clienteid'             : clienteid,
    'disponible'            : disponible,
    'venta'                 : venta,
    'fecact'                : fecact,
    'visita'                : visita,
    'diavis'                : diavis,
    'numero'                : numero,
    'nombre'                : nombre,
    'rfc'                   : rfc,
    'comercio'              : comercio,
    'domicilio'             : domicilio,
    'email'                 : email,
    'perid'                 : perid,
    'asesor'                : asesor,
    'lat'                   : lat,
    'lng'                   : lng,
    'activo'                : activo,
    'membresia'             : membresia,
    'lista'                 : lista,
    'limite'                : limite,
    'saldo'                 : saldo,
    'dias'                  : dias,
    'ultima'                : ultima,
    'forpag'                : forpag,
    'vencidos'              : vencidos
  };

  getImageCli() {
    return 'https://ferremayoristas.com.mx/assets/clientes/$numero.jpg';
  }
}
