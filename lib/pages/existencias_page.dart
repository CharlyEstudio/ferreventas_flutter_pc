import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// Modelos
import 'package:ferreventas/models/existencias/existencias_model.dart';

// Providers
import 'package:ferreventas/Providers/existencias/existencias_providers.dart';

// Widgets
import 'package:ferreventas/widgets/menu_widget.dart';
import 'package:intl/intl.dart';

class ExistenciasPage extends StatefulWidget {

  @override
  _ExistenciasPageState createState() => _ExistenciasPageState();
}

class _ExistenciasPageState extends State<ExistenciasPage> {
  String _codigo = '';
  final existenciasProvider = new ExistenciasProvider();
  Existencias _existencias = new Existencias();
  final formatCurrency = new NumberFormat.simpleCurrency();

  @override
  void initState() {
    super.initState();
    _existencias.nombre = '';
    _existencias.existencia = 0;
    _existencias.qro = 0;
    _existencias.tx = 0;
    _existencias.precio = 0.00;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Existencias'),
      ),
      drawer: MenuWidget(),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: <Widget>[
          _crearInput(),
          _mostrarCodigo(),
        ],
      ),
    );
  }

  Widget _crearInput() {
    return TextField(
      autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        counter: Text('Números ${_codigo.length}'),
        hintText: 'Código del Producto',
        labelText: 'Código',
        helperText: 'Solo es el código del producto a buscar',
        icon: Icon(Icons.search)
      ),
      onSubmitted: (valor) {
        setState(() {
          _codigo = valor;
          if (_codigo.length == 5) {
            existenciasProvider.getExistencias(codigo: _codigo).then((product) {
              setState(() {
                if (product.hashCode > 0) {
                  _existencias = product;
                } else {
                  _existencias.nombre = 'No existe este código.';
                  _existencias.existencia = 0;
                  _existencias.qro = 0;
                  _existencias.tx = 0;
                  _existencias.precio = 0.00;
                }
              });
            }).catchError((error) {
              _existencias.nombre = 'No existe este código.';
              _existencias.existencia = 0;
              _existencias.qro = 0;
              _existencias.tx = 0;
              _existencias.precio = 0.00;
            });
          }
        });
      },
    );
  }

  Widget _mostrarCodigo() {
    if (_existencias.existencia > 0) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 10.0),
        child: Column(
          children: <Widget>[
            Text('${_existencias.nombre}', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            Divider(),
            Text('Existencias', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            Text('${_existencias.existencia}', style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            Text('Qro: ${_existencias.qro} | Tx: ${_existencias.tx}', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            Divider(),
            Text('Precio', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            Text('${formatCurrency.format(_existencias.precio)}', style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            Divider(),
            Text('Ficha Técnica', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
            IconButton(
              icon: Icon(Icons.picture_as_pdf),
              color: Colors.red,
              iconSize: 100.0,
              tooltip: 'Fecha Técnica',
              onPressed: () {
                launch('https://www.truper.com.mx/pdf/diagramas/$_codigo.pdf');
              },
            ),
            Text('IMPORTANTE: La ficha técnica viene desde Truper, si al abrir el PDF hay un error, es por que esa ficha de ese código no existe.', textAlign: TextAlign.center),
          ],
        ),
      );
    } else {
      return Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 100.0),
          child: Text('No hay información.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0), textAlign: TextAlign.center),
        ),
      );
    }
  }
}