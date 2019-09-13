import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math';
import 'package:intl/intl.dart';

// Modelos
import 'package:ferreventas/models/clientes_model.dart';

// Widgets
import 'package:ferreventas/widgets/menu_widget.dart';

class ClientePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Cliente cliente = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      drawer: MenuWidget(),
      body: Container(
        child: Stack(
          children: <Widget>[
            _fondo(context: context),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _menu(context: context, numero: cliente.numero),
                  _nombre(cliente: cliente, context: context),
                  _cartera(cliente: cliente, context: context),
                  _diasVenc(cliente: cliente, context: context),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.message, color: Theme.of(context).primaryColor),
                              iconSize: 50.0,
                              onPressed: () {
                                print('Enviar Mensaje');
                              },
                            ),
                            Text('Enviar Mensaje'),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.add_shopping_cart, color: Theme.of(context).primaryColor),
                              iconSize: 50.0,
                              onPressed: () {
                                print('Levantar Pedido');
                              },
                            ),
                            Text('Levantar Pedido'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _fondo({BuildContext context}) {
    final gradiante = Container(
      width: double.infinity,
      height: double.infinity,
    );

    final caja = Transform.rotate(
      angle: -pi / 5.0,
      child: Container(
        width: 600.0,
        height: 600.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(300.0),
          color: Theme.of(context).primaryColor,
        ),
      ),
    );

    return Stack(
      children: <Widget>[
        gradiante,
        Positioned(
          child: caja,
          top: -100.0,
          left: -300.0,
        ),
      ],
    );
  }

  Widget _menu({BuildContext context, String numero}) {
    return SafeArea(
      child: Container(
        child: Row(
          children: <Widget>[
            IconButton(
              padding: EdgeInsets.all(10.0),
              icon: Icon(Icons.chevron_left, size: 30.0),
              color: Colors.white,
              onPressed: () {
                Navigator.pushNamed(context, 'home');
              },
            ),
            Icon(Icons.person_pin, color: Colors.white),
            SizedBox(width: 5.0),
            Text('$numero', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _nombre({Cliente cliente, BuildContext context}) {
    return Table(
      columnWidths: {1: FractionColumnWidth(.64), 2: FractionColumnWidth(1)},
      defaultColumnWidth: FlexColumnWidth(10.0),
      children: [
        TableRow(
          children: [
            _imagen(color: Colors.black, icon: Icons.person_pin, url: cliente.getImageCli(), context: context),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 32.0),
                Text('${cliente.membresia}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0)),
                Text('${cliente.nombre}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                Text('RFC: ${cliente.rfc}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 11.0)),
                Row(
                  children: <Widget>[
                    Icon(Icons.location_on, size: 12, color: Colors.white),
                    Text('${cliente.lat},${cliente.lng}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 9.0)),
                  ],
                ),
                SizedBox(height: 20.0),
                Text('${cliente.email}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 10.0)),
                Text('${cliente.comercio}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 10.0)),
                Text('${cliente.domicilio}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 10.0)),
              ],
            ),
          ]
        )
      ],
    );
  }

  Widget _cartera({Cliente cliente, BuildContext context}) {
    return Container(
      child: Table(
        columnWidths: {1: FractionColumnWidth(.65), 2: FractionColumnWidth(1)},
        children: [
          TableRow(
            children: [
              _importes(color: Colors.white, saldo: cliente.saldo, limite: cliente.limite, disponible: cliente.disponible, texto1: 'Saldo Actual', texto2: 'Limite', context: context),
            ]
          )
        ],
      ),
    );
  }

  Widget _diasVenc({Cliente cliente, BuildContext context}) {
    return Container(
      child: Table(
        children: [
          TableRow(
            children: [
              _facVen(color: Colors.black, numero: cliente.vencidos, texto: 'Facturas Vencidas', context: context),
              _diasCred(color: Colors.black, numero: cliente.dias, texto: 'Días de Crédito', context: context),
              _forPag(color: Colors.black, forma: cliente.forpag, texto: 'Forma de Pago', context: context),
            ]
          )
        ],
      ),
    );
  }

  Widget _imagen({Color color, IconData icon, String url, BuildContext context}) {
    return Container(
      height: 180.0,
      margin: EdgeInsets.all(15.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(url),
          fit: BoxFit.cover
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 2.0,
            color: Colors.black,
            offset: Offset(1.0, 1.0),
          )
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0)
      ),
    );
  }

  Widget _importes({Color color, double saldo, double limite, double disponible, String texto1, String texto2, BuildContext context}) {
    final formatCurrency = new NumberFormat.simpleCurrency();
    return Container(
      height: 80.0,
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 2.0,
            color: Colors.grey,
            offset: Offset(1.0, 1.0),
          )
        ],
        color: color,
        borderRadius: BorderRadius.circular(20.0)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('${formatCurrency.format(saldo)}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Theme.of(context).primaryColor)),
                  Text(texto1, style: TextStyle(color: Colors.black, fontSize: 10.0), overflow: TextOverflow.fade, textAlign: TextAlign.center),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('${formatCurrency.format(limite)}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Theme.of(context).primaryColor)),
                  Text(texto2, style: TextStyle(color: Colors.black, fontSize: 10.0), overflow: TextOverflow.fade, textAlign: TextAlign.center),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('${formatCurrency.format(disponible)}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Theme.of(context).primaryColor)),
                  Text('Disponible', style: TextStyle(color: Colors.black, fontSize: 10.0), overflow: TextOverflow.fade, textAlign: TextAlign.center),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _forPag({Color color, String forma, String texto, BuildContext context}) {
    IconData icono;
    String tipo;
    switch (forma) {
      case 'E':
        icono = Icons.attach_money;
        tipo = 'Efectivo';
      break;
      case 'R':
        icono = Icons.computer;
        tipo = 'Transferencia';
      break;
      case 'C':
        icono = Icons.border_color;
        tipo = 'Cheque';
      break;
      case 'T':
        icono = Icons.credit_card;
        tipo = 'Tarjeta';
      break;
      default:
        icono = Icons.monetization_on;
        tipo = 'Cualquiera';
    }
    return Container(
      height: 180.0,
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 2.0,
            color: Colors.grey,
            offset: Offset(1.0, 1.0),
          )
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SizedBox(height: 5.0),
          CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            radius: 35.0,
            child: Icon(icono, color: Colors.white, size: 50.0),
          ),
          Text('$texto $tipo', style: TextStyle(color: color), textAlign: TextAlign.center),
          SizedBox(height: 5.0)
        ],
      ),
    );
  }

  Widget _facVen({Color color, int numero, String texto, BuildContext context}) {
    return Container(
      height: 180.0,
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 2.0,
            color: Colors.grey,
            offset: Offset(1.0, 1.0),
          )
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 5.0),
          Text('$numero', style: TextStyle(fontSize: 80.0, color: Theme.of(context).primaryColor)),
          Text(texto, style: TextStyle(color: color), overflow: TextOverflow.fade, textAlign: TextAlign.center),
          SizedBox(height: 5.0)
        ],
      ),
    );
  }

  Widget _diasCred({Color color, int numero, String texto, BuildContext context}) {
    return Container(
      height: 180.0,
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 2.0,
            color: Colors.grey,
            offset: Offset(1.0, 1.0),
          )
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 5.0),
          Text('$numero', style: TextStyle(fontSize: 80.0, color: Theme.of(context).primaryColor)),
          Text(texto, style: TextStyle(color: color), overflow: TextOverflow.fade, textAlign: TextAlign.center),
          SizedBox(height: 5.0)
        ],
      ),
    );
  }
}