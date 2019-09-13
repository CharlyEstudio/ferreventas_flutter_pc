class Cancelado {
  int cantidad;
  double importe;

  Cancelado({
    this.cantidad,
    this.importe
  });

  factory Cancelado.fromJson(Map<String, dynamic> json) => new Cancelado(
    cantidad: json["cantidad"],
    importe: json["importe"].toDouble()
  );

  Map<String, dynamic> tojson() => {
    "cantidad": cantidad,
    "importe": importe
  };
}