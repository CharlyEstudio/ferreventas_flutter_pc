import 'package:flutter/material.dart';

class FondoWallpaperWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image(
                    image: AssetImage('assets/img/fondo2.jpg'),
                    fit: BoxFit.fitHeight,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}