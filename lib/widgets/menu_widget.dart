import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/fondo3.jpg'),
                fit: BoxFit.cover
              )
            ),
          ),
          ListTile(
            leading: Icon(Icons.blur_on, color: Theme.of(context).primaryColor),
            title: Text('Inicio'),
            onTap: () {
              Navigator.pushNamed(context, 'inicio');
            },
          ),
          ListTile(
            leading: Icon(Icons.home, color: Theme.of(context).primaryColor),
            title: Text('Home'),
            onTap: () {
              Navigator.pushNamed(context, 'home');
            },
          ),
          ListTile(
            leading: Icon(Icons.storage, color: Theme.of(context).primaryColor),
            title: Text('Clientes en DB'),
            onTap: () {
              Navigator.pushNamed(context, 'clientes');
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.assignment, color: Theme.of(context).primaryColor),
          //   title: Text('Garantías'),
          //   onTap: () {
          //     print('Garantías');
          //   },
          // ),
          ListTile(
            leading: Icon(Icons.error, color: Theme.of(context).primaryColor),
            title: Text('Pedidos Cancelados'),
            onTap: () {
              Navigator.pushNamed(context, 'cance-lista');
            },
          ),
          ListTile(
            leading: Icon(Icons.whatshot, color: Theme.of(context).primaryColor),
            title: Text('Cartera Vencida'),
            onTap: () {
              Navigator.pushNamed(context, 'cartera');
            },
          ),
          ListTile(
            leading: Icon(Icons.developer_board, color: Theme.of(context).primaryColor),
            title: Text('Existencias'),
            onTap: () {
              Navigator.pushNamed(context, 'existencias');
            },
          ),
          ListTile(
            leading: Icon(Icons.save_alt, color: Theme.of(context).primaryColor),
            title: Text('Lista de Precios'),
            onTap: () {
              launch('https://ferremayoristas.com.mx/lista');
            },
          ),
          ListTile(
            leading: Icon(Icons.timeline, color: Theme.of(context).primaryColor),
            title: Text('Estado de Cuenta'),
            onTap: () {
              print('Estado de Cuenta');
            },
          ),
          ListTile(
            leading: Icon(Icons.add_shopping_cart, color: Theme.of(context).primaryColor),
            title: Text('Pedidos Levantados'),
            onTap: () {
              print('Pedidos Levantados');
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.sort, color: Theme.of(context).primaryColor),
          //   title: Text('Formatos'),
          //   onTap: () {
          //     print('Formatos');
          //   },
          // ),
        ],
      ),
    );
  }
}