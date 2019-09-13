import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Modelos
import 'package:ferreventas/models/cancelados/cancelados_lista_model.dart';

// Preferencias de Usuario
import 'package:ferreventas/preferes/preferencias_usuario.dart';

// Providers
import 'package:ferreventas/Providers/cancelados/cancelados_lista_provider.dart';

// Widget
import 'package:ferreventas/widgets/menu_widget.dart';

class CanceladosListaPage extends StatelessWidget {
  final prefs = new PreferenciasUsuario();
  final canceladosLista = new CanceladosListaProvider();
  final formatCurrency = new NumberFormat.simpleCurrency();

  @override
  Widget build(BuildContext context) {
    canceladosLista.getCancelados(idFerrum: prefs.idFerrum);

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Cancelados'),
      ),
      drawer: MenuWidget(),
      body: FutureBuilder<List<CanceladoLista>>(
        future: canceladosLista.getCancelados(idFerrum: prefs.idFerrum),
        builder: (BuildContext context, AsyncSnapshot<List<CanceladoLista>> snap) {
          if (!snap.hasData) {
            return Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('SIN INFORMACION', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0)),
                  ],
                ),
              ),
            );
          }

          if (snap.data.length == 0) {
            return Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('SIN PEDIDOS CANCELADOS', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0)),
                  ],
                ),
              ),
            );
          }

          var lista = snap.data;

          return ListView.builder(
            itemCount: lista.length,
            itemBuilder: (BuildContext context, int i) {
              return ListTile(
                title: Text('${lista[i].numero} ${lista[i].nombre}', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('Pedido: ${lista[i].folio} Importe: ${formatCurrency.format(lista[i].importe)}'),
              );
            },
          );
        },
      ),
    );
  }
}