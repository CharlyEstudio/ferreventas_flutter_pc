class CanceladosLista {
  List<CanceladoLista> items = new List();
  CanceladosLista();

  CanceladosLista.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final lista = new CanceladoLista.fromJsonMap(item);
      items.add(lista);
    }
  }
}

class CanceladoLista {
  int numero;
  String nombre;
  int folio;
  double importe;

  CanceladoLista({
    this.numero,
    this.nombre,
    this.folio,
    this.importe
  });

  CanceladoLista.fromJsonMap(Map<String, dynamic> json) {
    numero            = json["numero"];
    nombre            = json["nombre"];
    folio             = json["folio"];
    importe           = json["importe"];
  }

  CanceladoLista.fromJsonMapDB(Map<String, dynamic> json) {
    numero            = json["numero"];
    nombre            = json["nombre"];
    folio             = json["folio"];
    importe           = json["importe"] / 1;
  }

  Map<String, dynamic> toJson() => {
    'numero'                : numero,
    'nombre'                : nombre,
    'folio'                 : folio,
    'importe'               : importe
  };
}
