class TotalPedidos {
  int cantidad;
  double importe;

  TotalPedidos({
    this.cantidad,
    this.importe
  });

  factory TotalPedidos.fromJson(Map<String, dynamic> json) => new TotalPedidos(
    cantidad: json["cantidad"],
    importe: json["importe"].toDouble()
  );

  Map<String, dynamic> tojson() => {
    "cantidad": cantidad,
    "importe": importe
  };
}