import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Utiles & Herramientas
import 'package:ferreventas/Providers/herramientas/utils_provider.dart';

// Base de Datos Interno SQLite
import 'package:ferreventas/db/db_provider.dart';

// Widgets
import 'package:ferreventas/widgets/pedidos_dia_widget.dart';
import 'package:ferreventas/widgets/custom_appbar_widget.dart';
import 'package:ferreventas/widgets/clientes_db_widget.dart';

// Preferencias de Usuario
import 'package:ferreventas/preferes/preferencias_usuario.dart';

// Socket
import 'package:ferreventas/sockets/socket.dart';

// Plugins
import 'package:pull_to_refresh/pull_to_refresh.dart';

// Widgets
import 'package:ferreventas/widgets/menu_widget.dart';

// Provider
import 'package:ferreventas/Providers/gets/clientes_provider.dart';
import 'package:ferreventas/Providers/gets/pedidos/bajar.dart';
import 'package:ferreventas/Providers/gets/pedidos/cancelado.dart';
import 'package:ferreventas/Providers/gets/pedidos/remision.dart';
import 'package:ferreventas/Providers/gets/pedidos/surtir.dart';
import 'package:ferreventas/Providers/gets/pedidos/total.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final socket = new WebSocket();
  final prefs = new PreferenciasUsuario();
  final cli = new ClientesProvider();
  final bajarProvider = new BajarProvider();
  final surtirProvider = new SurtirProvider();
  final remisionProvider = new RemisionProvider();
  final canceladoProvider = new CanceladoProvider();
  final pedTotaProvider = new TotalPedidosProvider();
  RefreshController _refresh = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuWidget(),
      body: SmartRefresher(
        enablePullDown: true,
        header: CustomHeader(
          builder: (BuildContext context, RefreshStatus mode) {
            Widget body;

            if (mode == RefreshStatus.idle) {
              body = Text('Deslice para actualizar');
            } else if (mode == RefreshStatus.refreshing) {
              body = CupertinoActivityIndicator();
            } else {
              body = Text('Actualizado');
            }
            
            return Container(
              height: 55.0,
              child: Center(
                child: body,
              ),
            );
          },
        ),
        controller: _refresh,
        onRefresh: _onRefresh,
        child: CustomScrollView(
          slivers: <Widget>[
            CustomAppBarWidget(),
            _lista(idFerrum: prefs.idFerrum),
          ],
        ),
      ),
    );
  }

  Widget _lista({int idFerrum}) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: <Widget>[
                StreamBuilder<int>(
                  initialData: 0,
                  stream: socket.conectadoStream,
                  builder: (BuildContext context, AsyncSnapshot<int> snap) {
                    if (!snap.hasData) {
                      return Container(
                        child: Center(
                          child: Text('No hay información o este equipo no tiene autorización'),
                        ),
                      );
                    }

                    if (snap.data == 0) {
                      // print(snap.data);
                      // falta saber si hay registros en la db, si no hay, mostrar una ventana de sin datos
                      // _actualizar();
                    }

                    var fecact = fechaActual();
                    // DBProvider.db.deleteAllClientes();

                    DBProvider.db.getTodosClientes().then((all) {
                      if (all.length > 0) {
                        if (all[0].fecact.split('T')[0] != fecact) {
                          _actualizar();
                        } else {
                          for (var i = 0; i < all.length; i++) {
                            // print(all[i].fecact);
                            // print(all[i].clienteid);
                            // print(all[i].diavis);
                            // print(all[i].disponible);
                          }
                        }
                      } else {
                        _actualizar();
                      }
                    });
                    
                    return Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          PedidosDiaWidget(),
                          ClientesDBWidget(),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          )
        ]
      ),
    );
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _lista(idFerrum: prefs.idFerrum);
    _refresh.refreshCompleted();
  }

  void _actualizar() {
    DBProvider.db.deleteAllClientes();
    cli.getClientes(idFerrum: prefs.idFerrum).then((customers) {
      for (var i = 0; i < customers.length; i++) {
        DBProvider.db.nuevocliente(customers[i]);
        var dispo = customers[i].limite - customers[i].saldo;
        DBProvider.db.updateDisponible(customers[i].clienteid, dispo).then((status) {
          print(status);
        });
      }
    });
  }
}