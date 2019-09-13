class Surtir {
  int cantidad;
  double importe;

  Surtir({
    this.cantidad,
    this.importe
  });

  factory Surtir.fromJson(Map<String, dynamic> json) => new Surtir(
    cantidad: json["cantidad"],
    importe: json["importe"].toDouble()
  );

  Map<String, dynamic> tojson() => {
    "cantidad": cantidad,
    "importe": importe
  };
}