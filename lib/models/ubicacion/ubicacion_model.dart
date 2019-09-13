class Ubicacion {
  bool status;
  String hora;
  int cliente;
  int asesor;
  String origen;
  String destino;
  String distancia;
  bool visita;

  Ubicacion({
    this.status,
    this.hora,
    this.cliente,
    this.asesor,
    this.origen,
    this.destino,
    this.distancia,
    this.visita
  });

  factory Ubicacion.fromJson(Map<String, dynamic> json) => new Ubicacion(
    status: json["status"],
    hora: json["hora"],
    cliente: json["cliente"],
    asesor: json["asesor"],
    origen: json["origen"],
    destino: json["destino"],
    distancia: json["distancia"],
    visita: json["visita"]
  );

  Map<String, dynamic> tojson() => {
    "status": status,
    "hora": hora,
    "cliente": cliente,
    "asesor": asesor,
    "origen": origen,
    "destino": destino,
    "distancia": distancia,
    "visita": visita
  };
}