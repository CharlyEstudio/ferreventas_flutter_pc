String fechaActual() {
  DateTime now = new DateTime.now();
  String date = new DateTime(now.year, now.month, now.day).toString();
  final fecha = date.split(' ')[0];
  return fecha;
}

String diaActual() {
  DateTime now = new DateTime.now();
  int d = now.weekday;
  String dia;
  switch(d) {
    case 1:
      dia = 'L';
    break;
    case 2:
      dia = 'M';
    break;
    case 3:
      dia = 'I';
    break;
    case 4:
      dia = 'J';
    break;
    case 5:
      dia = 'V';
    break;
    default:
      dia = 'L';
  }
  return dia;
}