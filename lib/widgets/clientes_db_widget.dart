import 'package:flutter/material.dart';

// Base de Datos Interno SQLite
import 'package:ferreventas/db/db_provider.dart';

// Widgets
import 'package:ferreventas/widgets/cliente_visitado_widget.dart';

class ClientesDBWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // future: cli.getClientes(idFerrum: prefs.idFerrum),
      future: DBProvider.db.getTodosClientes(),
      builder: (BuildContext context, AsyncSnapshot snap) {
        if (!snap.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final lista = snap.data;

        if (lista.length == 0) {
          return Center(
            child: Card(
              borderOnForeground: true,
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Sin lista de Clientes')
                  ],
                ),
              ),
            ),
          );
        }

        return Card(
          borderOnForeground: true,
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Mis Clientes', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
                SizedBox(
                  height: 300.00,
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 10.0),
                    itemCount: lista.length,
                    itemBuilder: (BuildContext context, int i) {
                      if (lista[i].visita == 'NOT') {
                        return ClientesVisitadosWidget(cliente: lista[i], clienteId: lista[i].clienteid, lat: lista[i].lat, lng: lista[i].lng, nombre: lista[i].nombre, numero: lista[i].numero, visitado: false);
                      } else {
                        return ClientesVisitadosWidget(cliente: lista[i], clienteId: lista[i].clienteid, lat: lista[i].lat, lng: lista[i].lng, nombre: lista[i].nombre, numero: lista[i].numero, visitado: true);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}