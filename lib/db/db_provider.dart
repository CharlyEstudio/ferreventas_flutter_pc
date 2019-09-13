// Directory
import 'dart:io';

// Path
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

// SQLite
import 'package:sqflite/sqflite.dart';

// Modelos
import 'package:ferreventas/models/clientes_model.dart';
export 'package:ferreventas/models/clientes_model.dart';

class DBProvider {
  static Database _database;

  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if(_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ClientesDB.db');
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE Cliente ('
          ' clienteid INTEGER PRIMARY KEY,'
          ' disponible DOUBLE,'
          ' venta INTEGER,'
          ' fecact TEXT,'
          ' visita TEXT,'
          ' diavis TEXT,'
          ' numero TEXT,'
          ' nombre TEXT,'
          ' rfc TEXT,'
          ' comercio TEXT,'
          ' domicilio TEXT,'
          ' email TEXT,'
          ' perid INTEGER,'
          ' asesor TEXT,'
          ' lat DOUBLE,'
          ' lng DOUBLE,'
          ' activo INTEGER,'
          ' membresia TEXT,'
          ' lista INTEGER,'
          ' limite DOUBLE,'
          ' saldo DOUBLE,'
          ' dias INTEGER,'
          ' ultima TEXT,'
          ' forpag TEXT,'
          ' vencidos INTEGER'
          ')'
        );
      }
    );
  }

  // Crear registro a la base de datos
  // Si quiero enviar todo los campos
  Future<int> nuevocliente(Cliente nuevoCliente) async {
    // print(nuevoCliente.disponible);
    final db = await database;
    final res = await db.insert('Cliente', nuevoCliente.toJson());
    return res;
  }

  // SELECT - obtener información
  Future<Cliente> getClienteId(int id) async {
    final db = await database;
    final res = await db.query('Cliente', where: 'clienteid = ?', whereArgs: [id]);
    return res.isNotEmpty ? Cliente.fromJsonMap(res.first) : null;
  }

  // SELECT - obtener todos los items
  Future<List<Cliente>> getTodosClientes() async {
    final db = await database;
    final res = await db.query('Cliente');
    List<Cliente> list = res.isNotEmpty
                              // ? res.map((c) => Cliente.fromJsonMap(c)).toList()
                              ? res.map((c) => Cliente.fromJsonMapDB(c)).toList()
                              : [];
    return list;
  }

  // SELECT - Ver si tiene venta
  Future<Cliente> getConVentaId(int id) async {
    final db = await database;
    final res = await db.rawQuery('SELECT * FROM Cliente WHERE clienteid = $id AND venta = 1');
    return res.isNotEmpty ? Cliente.fromJsonMap(res.first) : null;
  }

  // Actualizar registros
  Future<int> updateCliente(Cliente updateCliente) async {
    final db = await database;
    final res = await db.update('Cliente', updateCliente.toJson(), where: 'clienteid = ?', whereArgs: [updateCliente.clienteid]);
    return res;
  }

  // Actualizar Disponible
  Future<int> updateDisponible(int clienteid, double importe) async {
    final db = await database;
    final res = await db.rawUpdate('UPDATE Cliente SET disponible = $importe WHERE clienteid = $clienteid');
    return res;
  }

  // Actualizar Cliente Visitado
  Future<int> updateVisita(int clienteid, String texto) async {
    final db = await database;
    final res = await db.rawUpdate("UPDATE Cliente SET visita = '$texto' WHERE clienteid = $clienteid");
    return res;
  }

  // Eliminar registros
  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete('Cliente', where: 'clienteid = ?', whereArgs: [id]);
    return res;
  }

  // Delete all
  Future<int> deleteAllClientes() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Cliente');
    return res;
  }

}