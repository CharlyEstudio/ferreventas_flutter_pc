import 'package:flutter/material.dart';

// Base de Datos Interso SQLite
import 'package:ferreventas/db/db_provider.dart';

class ClientesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clientes en BD'),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                child: Column(
                  children: <Widget>[
                    FutureBuilder<List<Cliente>>(
                      future: DBProvider.db.getTodosClientes(),
                      builder: (BuildContext context, AsyncSnapshot<List<Cliente>> snap) {
                        if (!snap.hasData) {
                          return Center(
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Text('Sin registros en la base de datos interno.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                                ],
                              ),
                            ),
                          );
                        }

                        if (snap.data.length == 0) {
                          return Center(
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Text('No hay datos guardados.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                                ],
                              ),
                            ),
                          );
                        }

                        var lista = snap.data;

                        return Center(
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * .85,
                                  child: ListView.builder(
                                    padding: EdgeInsets.only(top: 10.0),
                                    itemCount: lista.length,
                                    itemBuilder: (BuildContext context, int i) {
                                      if (lista[i].visita != 'NOT') {
                                        return ListTile(
                                          leading: Icon(Icons.person_pin),
                                          title: Text('${lista[i].nombre}'),
                                          subtitle: Text('${lista[i].numero}'),
                                          // trailing: Icon(Icons.chevron_right),
                                          selected: true,
                                        );
                                      } else {
                                        return ListTile(
                                          leading: Icon(Icons.person_pin),
                                          title: Text('${lista[i].nombre}'),
                                          subtitle: Text('${lista[i].numero}'),
                                          // trailing: Icon(Icons.chevron_right),
                                          selected: false,
                                        );
                                      }
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}