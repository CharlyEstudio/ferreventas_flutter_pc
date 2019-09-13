import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Preferencias de Usuario
import 'package:ferreventas/preferes/preferencias_usuario.dart';

// Providers
import 'package:ferreventas/Providers/cartera/vencido130_provider.dart';
import 'package:ferreventas/Providers/cartera/vencido3145_provider.dart';
import 'package:ferreventas/Providers/cartera/vencido4660_provider.dart';
import 'package:ferreventas/Providers/cartera/vencido6190_provider.dart';
import 'package:ferreventas/Providers/cartera/vencido91120_provider.dart';
import 'package:ferreventas/Providers/cartera/vencido121_providers.dart';

// Widgets
import 'package:ferreventas/widgets/menu_widget.dart';

class CarteraPage extends StatelessWidget {

  final prefs = new PreferenciasUsuario();
  final formatCurrency = new NumberFormat.simpleCurrency();

  final vencido130Provider = new Vencido130Provider();
  final vencido3145Provider = new Vencido3145Provider();
  final vencido4660Provider = new Vencido4660Provider();
  final vencido6190Provider = new Vencido6190Provider();
  final vencido91120Provider = new Vencido91120Provider();
  final vencido121Provider = new Vencido121Provider();

  @override
  Widget build(BuildContext context) {
    vencido6190Provider.getVencido(idFerrum: prefs.idFerrum);
    vencido91120Provider.getVencido(idFerrum: prefs.idFerrum);
    vencido121Provider.getVencido(idFerrum: prefs.idFerrum);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cartera'),
      ),
      drawer: MenuWidget(),
      body: ListView(
        children: <Widget>[
          _info(context: context),
        ],
      ),
    );
  }

  Widget _info({BuildContext context}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(height: 10.0),
        Text(
          'Cartera Vencida',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30.0
          ),
        ),
        SizedBox(height: 10.0),
        Table(
          children: [
            TableRow(
              children: [
                _vencido130(context: context, texto: '1 a 30 Días', icono: Icon(Icons.do_not_disturb_on, color: Theme.of(context).primaryColor), padd: 5.0),
                _vencido3145(context: context, texto: '31 a 45 Días', icono: Icon(Icons.do_not_disturb_on, color: Theme.of(context).primaryColor), padd: 5.0),
              ]
            ),
            TableRow(
              children: [
                _vencido4660(context: context, texto: '46 a 60 Días', icono: Icon(Icons.do_not_disturb_off, color: Theme.of(context).primaryColor), padd: 5.0),
                _vencido6190(context: context, texto: '61 a 90 Días', icono: Icon(Icons.do_not_disturb_off, color: Theme.of(context).primaryColor), padd: 5.0),
              ]
            ),
            TableRow(
              children: [
                _vencido91120(context: context, texto: '91 a 120 Días', icono: Icon(Icons.do_not_disturb, color: Theme.of(context).primaryColor), padd: 5.0),
                _vencido121(context: context, texto: '+120 Días', icono: Icon(Icons.do_not_disturb_alt, color: Theme.of(context).primaryColor), padd: 5.0),
              ]
            ),
          ],
        ),
      ],
    );
  }

  Widget _vencido130({BuildContext context, String texto, Icon icono, double padd}) {
    return Container(
      child: Column(
        children: <Widget>[
          Card(
            child: FutureBuilder(
              future: vencido130Provider.getVencido(idFerrum: prefs.idFerrum),
              builder: (BuildContext context, AsyncSnapshot snap) {
                if (snap.hasData) {
                  return Container(
                    width: 190.0,
                    height: 150.0,
                    padding: EdgeInsets.all(padd),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        icono,
                        Text('${formatCurrency.format(snap.data.importe)}', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
                        Text('$texto', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
                      ],
                    ),
                  );
                }
                return Container(
                  width: 190.0,
                  height: 150.0,
                  padding: EdgeInsets.all(padd),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      icono,
                      Text('${formatCurrency.format(0)}', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
                      Text('$texto', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _vencido3145({BuildContext context, String texto, Icon icono, double padd}) {
    return Container(
      child: Column(
        children: <Widget>[
          Card(
            child: FutureBuilder(
              future: vencido3145Provider.getVencido(idFerrum: prefs.idFerrum),
              builder: (BuildContext context, AsyncSnapshot snap) {
                if (snap.hasData) {
                  return Container(
                    width: 190.0,
                    height: 150.0,
                    padding: EdgeInsets.all(padd),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        icono,
                        Text('${formatCurrency.format(snap.data.importe)}', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
                        Text('$texto', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
                      ],
                    ),
                  );
                }
                return Container(
                  width: 190.0,
                  height: 150.0,
                  padding: EdgeInsets.all(padd),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      icono,
                      Text('${formatCurrency.format(0)}', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
                      Text('$texto', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _vencido4660({BuildContext context, String texto, Icon icono, double padd}) {
    return Container(
      child: Column(
        children: <Widget>[
          Card(
            child: FutureBuilder(
              future: vencido4660Provider.getVencido(idFerrum: prefs.idFerrum),
              builder: (BuildContext context, AsyncSnapshot snap) {
                if (snap.hasData) {
                  return Container(
                    width: 190.0,
                    height: 150.0,
                    padding: EdgeInsets.all(padd),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        icono,
                        Text('${formatCurrency.format(snap.data.importe)}', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
                        Text('$texto', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
                      ],
                    ),
                  );
                }
                return Container(
                  width: 190.0,
                  height: 150.0,
                  padding: EdgeInsets.all(padd),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      icono,
                      Text('${formatCurrency.format(0)}', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
                      Text('$texto', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _vencido6190({BuildContext context, String texto, Icon icono, double padd}) {
    return Container(
      child: Column(
        children: <Widget>[
          Card(
            child: FutureBuilder(
              future: vencido6190Provider.getVencido(idFerrum: prefs.idFerrum),
              builder: (BuildContext context, AsyncSnapshot snap) {
                if (snap.hasData) {
                  return Container(
                    width: 190.0,
                    height: 150.0,
                    padding: EdgeInsets.all(padd),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        icono,
                        Text('${formatCurrency.format(snap.data.importe)}', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
                        Text('$texto', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
                      ],
                    ),
                  );
                }
                return Container(
                  width: 190.0,
                  height: 150.0,
                  padding: EdgeInsets.all(padd),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      icono,
                      Text('${formatCurrency.format(0)}', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
                      Text('$texto', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _vencido91120({BuildContext context, String texto, Icon icono, double padd}) {
    return Container(
      child: Column(
        children: <Widget>[
          Card(
            child: FutureBuilder(
              future: vencido91120Provider.getVencido(idFerrum: prefs.idFerrum),
              builder: (BuildContext context, AsyncSnapshot snap) {
                if (snap.hasData) {
                  return Container(
                    width: 190.0,
                    height: 150.0,
                    padding: EdgeInsets.all(padd),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        icono,
                        Text('${formatCurrency.format(snap.data.importe)}', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
                        Text('$texto', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
                      ],
                    ),
                  );
                }
                return Container(
                  width: 190.0,
                  height: 150.0,
                  padding: EdgeInsets.all(padd),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      icono,
                      Text('${formatCurrency.format(0)}', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
                      Text('$texto', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _vencido121({BuildContext context, String texto, Icon icono, double padd}) {
    return Container(
      child: Column(
        children: <Widget>[
          Card(
            child: FutureBuilder(
              future: vencido121Provider.getVencido(idFerrum: prefs.idFerrum),
              builder: (BuildContext context, AsyncSnapshot snap) {
                if (snap.hasData) {
                  return Container(
                    width: 190.0,
                    height: 150.0,
                    padding: EdgeInsets.all(padd),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        icono,
                        Text('${formatCurrency.format(snap.data.importe)}', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
                        Text('$texto', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
                      ],
                    ),
                  );
                }
                return Container(
                  width: 190.0,
                  height: 150.0,
                  padding: EdgeInsets.all(padd),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      icono,
                      Text('${formatCurrency.format(0)}', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
                      Text('$texto', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}