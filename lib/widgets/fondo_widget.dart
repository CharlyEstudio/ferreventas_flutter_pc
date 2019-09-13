import 'package:flutter/material.dart';

class FondoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          child: _circulo(context),
          top: -450.0,
          left: -100.0,
        )
      ],
    );
  }

  Widget _circulo(BuildContext context) {
    return Container(
      height: 600.0,
      width: 600.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(500.0),
        color: Theme.of(context).primaryColor
      ),
    );
  }
}