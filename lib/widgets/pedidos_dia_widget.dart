import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Preferencias de Usuario
import 'package:ferreventas/preferes/preferencias_usuario.dart';

// Providers
import 'package:ferreventas/Providers/gets/pedidos/bajar.dart';
import 'package:ferreventas/Providers/gets/pedidos/surtir.dart';
import 'package:ferreventas/Providers/gets/pedidos/remision.dart';
import 'package:ferreventas/Providers/gets/pedidos/cancelado.dart';
import 'package:ferreventas/Providers/gets/pedidos/total.dart';

class PedidosDiaWidget extends StatelessWidget {

  final prefs = new PreferenciasUsuario();
  final bajarProvider = new BajarProvider();
  final surtirProvider = new SurtirProvider();
  final remisionProvider = new RemisionProvider();
  final canceladoProvider = new CanceladoProvider();
  final pedTotaProvider = new TotalPedidosProvider();

  final formatCurrency = new NumberFormat.simpleCurrency();

  @override
  Widget build(BuildContext context) {

    bajarProvider.getBajar(prefs.idFerrum);
    surtirProvider.getSurtir(prefs.idFerrum);
    remisionProvider.getRemision(prefs.idFerrum);
    canceladoProvider.getCancelado(prefs.idFerrum);
    pedTotaProvider.getTotalPedidos(prefs.idFerrum);

    return Center(
      child: Card(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 10),
              Text('Pedidos del Día', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
              ListTile(
                leading: Icon(Icons.arrow_downward, color: Theme.of(context).primaryColor),
                title: _porBajar(context),
                subtitle: Text('Por Bajar'),
              ),
              ListTile(
                leading: Icon(Icons.shopping_cart, color: Theme.of(context).primaryColor),
                title: _porSurtir(context),
                subtitle: Text('Por Surtir'),
              ),
              ListTile(
                leading: Icon(Icons.playlist_add_check, color: Theme.of(context).primaryColor),
                title: _remisionadosFacturados(context),
                subtitle: Text('Remisionados'),
              ),
              ListTile(
                leading: Icon(Icons.cancel, color: Theme.of(context).primaryColor),
                title: _cancelado(context),
                subtitle: Text('Cancelados'),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.assessment, color: Theme.of(context).primaryColor),
                title: _pedTotal(context),
                subtitle: Text('Pedidos Totales'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _porBajar(BuildContext context) {
    return FutureBuilder(
      future: bajarProvider.getBajar(prefs.idFerrum),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return _texto(context, '${snapshot.data.cantidad}', '${formatCurrency.format(snapshot.data.importe)}', 11.0);
        } else {
          return Text('Sin información.');
        }
      },
    );
  }

  Widget _porSurtir(BuildContext context) {
    return FutureBuilder(
      future: surtirProvider.getSurtir(prefs.idFerrum),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return _texto(context, '${snapshot.data.cantidad}', '${formatCurrency.format(snapshot.data.importe)}', 11.0);
        } else {
          return Text('Sin información.');
        }
      },
    );
  }

  Widget _remisionadosFacturados(BuildContext context) {
    return FutureBuilder(
      future: remisionProvider.getRemision(prefs.idFerrum),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return _texto(context, '${snapshot.data.cantidad}', '${formatCurrency.format(snapshot.data.importe)}', 11.0);
        } else {
          return Text('Sin información.');
        }
      },
    );
  }

  Widget _cancelado(BuildContext context) {
    return FutureBuilder(
      future: canceladoProvider.getCancelado(prefs.idFerrum),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return _texto(context, '${snapshot.data.cantidad}', '${formatCurrency.format(snapshot.data.importe)}', 11.0);
        } else {
          return Text('Sin información.');
        }
      },
    );
  }

  Widget _pedTotal(BuildContext context) {
    return FutureBuilder(
      future: pedTotaProvider.getTotalPedidos(prefs.idFerrum),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return _texto(context, '${snapshot.data.cantidad}', '${formatCurrency.format(snapshot.data.importe)}', 11.0);
        } else {
          return Text('Sin información.');
        }
      },
    );
  }

  Widget _texto(BuildContext context, String cantidad, String importe, double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text(
          '$cantidad pedidos',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: size,
            color: Theme.of(context).primaryColor
          ),
        ),
        Text(
          '$importe pesos',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: size,
            color: Theme.of(context).primaryColor
          ),
        ),
      ],
    );
  }

}