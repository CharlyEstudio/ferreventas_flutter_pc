import 'package:flutter/material.dart';

class FotoUserWidget extends StatelessWidget {
  final foto;

  FotoUserWidget({@required this.foto});

  @override
  Widget build(BuildContext context) {
    return Image(
      height: 30.0,
      width: 30.0,
      image: NetworkImage('https://ferremayoristas.com.mx:3001/img/usuarios/$foto')
    );
  }
}