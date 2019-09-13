import 'package:flutter/material.dart';

class CustomAppBarClienteWidget extends StatefulWidget {
  final cliente;

  CustomAppBarClienteWidget({@required this.cliente});

  @override
  _CustomAppBarClienteWidgetState createState() => _CustomAppBarClienteWidgetState();
}

class _CustomAppBarClienteWidgetState extends State<CustomAppBarClienteWidget> {

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      snap: true,
      expandedHeight: 350.0,
      actions: <Widget>[
        Icon(Icons.person_pin),
        Container(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Text('${widget.cliente.numero}', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        // title: Text(
        //   '${widget.cliente.nombre}',
        //   style: TextStyle(
        //     fontSize: 20.0,
        //     color: Colors.white,
        //     shadows: [
        //       Shadow(
        //         blurRadius: 5.0,
        //         color: Colors.black,
        //         offset: Offset(1.5, 1.5),
        //       ),
        //     ],
        //   ),
        // ),
        background: Image.network(widget.cliente.getImageCli(), fit: BoxFit.cover),
      ),
    );
  }
}