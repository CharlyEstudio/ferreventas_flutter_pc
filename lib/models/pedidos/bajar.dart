class Bajar {
  int cantidad;
  double importe;

  Bajar({
    this.cantidad,
    this.importe
  });

  factory Bajar.fromJson(Map<String, dynamic> json) => new Bajar(
    cantidad: json["cantidad"],
    importe: json["importe"].toDouble()
  );

  Map<String, dynamic> tojson() => {
    "cantidad": cantidad,
    "importe": importe
  };
}