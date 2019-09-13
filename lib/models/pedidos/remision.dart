class Remision {
  int cantidad;
  double importe;

  Remision({
    this.cantidad,
    this.importe
  });

  factory Remision.fromJson(Map<String, dynamic> json) => new Remision(
    cantidad: json["cantidad"],
    importe: json["importe"].toDouble()
  );

  Map<String, dynamic> tojson() => {
    "cantidad": cantidad,
    "importe": importe
  };
}