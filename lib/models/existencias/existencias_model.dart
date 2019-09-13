class Existencias {
  int clave;
  String nombre;
  int existencia;
  int qro;
  int tx;
  double precio;
  double precio2;

  Existencias({
    this.clave,
    this.nombre,
    this.existencia,
    this.qro,
    this.tx,
    this.precio,
    this.precio2
  });

  factory Existencias.fromJson(Map<String, dynamic> json) => new Existencias(
    clave         : json["clave"],
    nombre        : json["nombre"],
    existencia    : json["existencia"],
    qro           : json["qro"],
    tx            : json["tx"],
    precio        : json["precio"],
    precio2       : json["precio2"]
  );

  Map<String, dynamic> toJosn() => {
    "clave"       : clave,
    "nombre"      : nombre,
    "existencia"  : existencia,
    "qro"         : qro,
    "tx"          : tx,
    "precio"      : precio,
    "precio2"     : precio2,
  };
}