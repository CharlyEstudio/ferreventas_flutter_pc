class Usuarios {
  List<Usuario> items = new List();
  Usuarios();

  Usuarios.fromJsonList(List jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final usuario = new Usuario.fromJsonMap(item);
      items.add(usuario);
    }
  }
}

class Usuario {
  String rol;
  String img;
  double lat;
  double lng;
  int time;
  int altitud;
  double exactitud;
  double velocidad;
  String activo;
  String id;
  String imei;
  int idFerrum;
  String nombre;
  String email;
  String fecactual;

  Usuario({
    this.rol,
    this.img,
    this.lat,
    this.lng,
    this.time,
    this.altitud,
    this.exactitud,
    this.velocidad,
    this.activo,
    this.id,
    this.imei,
    this.idFerrum,
    this.nombre,
    this.email
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => new Usuario(
    rol: json['rol'],
    img: json['img'],
    lat: json['lat'].toDouble(),
    lng: json['lng'].toDouble(),
    time: json['time'],
    altitud: json['altitud'],
    exactitud: json['exactitud'] / 1,
    velocidad: json['velocidad'] / 1,
    activo: json['activo'],
    id: json['id'],
    imei: json['imei'],
    idFerrum: json['idFerrum'],
    nombre: json['nombre'],
    email: json['email']
  );

  Map<String, dynamic> toJson() => {
    "rol": rol,
    "img": img,
    "lat": lat,
    "lng": lng,
    "time": time,
    "altitud": altitud,
    "exactitud": exactitud,
    "velocidad": velocidad,
    "activo": activo,
    "id": id,
    "imei": imei,
    "idFerrum": idFerrum,
    "nombre": nombre,
    "email": email,
    "fecactual": fecactual
  };

  Usuario.fromJsonMap(Map<String, dynamic> json) {
    rol = json['rol'];
    img = json['img'];
    lat = json['lat'] / 1;
    lng = json['lng'] / 1;
    time = json['time'];
    altitud = json['altitud'];
    exactitud = json['exactitud'];
    velocidad = json['velocidad'];
    activo = json['activo'];
    id = json['id'];
    imei = json['imei'];
    idFerrum = json['idFerrum'].cast<int>();
    nombre = json['nombre'];
    email = json['email'];
    fecactual = '';
  }
}