class Vencido {
  double importe;

  Vencido({
    this.importe,
  });

  factory Vencido.fromJson(Map<String, dynamic> json) => new Vencido(
    importe: json["importe"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "importe": importe,
  };
}