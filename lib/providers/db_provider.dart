import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:qr_reader/models/scan_model.dart';
export 'package:qr_reader/models/scan_model.dart';

class DBProvider {
//
  static Database? _database;

  static final DBProvider db = DBProvider._();

  DBProvider._();

  // Obtener la base de datos
  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  Future<Database?> initDB() async {
    // Path de donde se almacenara la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');
    print(path);

    // Creación de la base de datos
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute(''' 
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            tipo TEXT,
            valor TEXT
          )
        ''');
      },
    );

    // Incrementar la version, cada que se cambie o se implementen nuevas tablas en la base de datos
  }

  Future<int> nuevoScanRaw(ScanModel newScan) async {
    //
    final id = newScan.id;
    final tipo = newScan.tipo;
    final valor = newScan.valor;

    // Verificar la BD
    final db = await database;

    final res = await db?.rawInsert('''
      INSERT INTO Scans( id, tipo, valor)
        VALUES($id, '$tipo', '$valor')
    ''');

    return res!;
  }

  Future<int> nuevoScan(ScanModel newScan) async {
    final db = await database;
    final res = await db?.insert('Scans', newScan.toJson());

    print(res);

    // El res es el id del ultimo registrto insertado;
    return res!;
  }

  // Consulta los registros segun un id
  Future<ScanModel?> getScanById(int id) async {
    final db = await database;
    final res = await db?.query('Scans', where: 'id = ?', whereArgs: [id]);

    return res!.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  // Consulta todos los registros de la tabla
  Future<List<ScanModel>?> getTodos() async {
    final db = await database;
    final res = await db?.query('Scans');

    return res!.isNotEmpty
        ? res.map((e) => ScanModel.fromJson(e)).toList()
        : [];
  }

  // Consulta registro segun el tipo
  Future<List<ScanModel>?> getScansPorTipo(String tipo) async {
    final db = await database;
    final res = await db?.rawQuery(''' 
        SELECT * FROM Scans WHERE tipo =  '$tipo'
      ''');

    return res!.isNotEmpty
        ? res.map((e) => ScanModel.fromJson(e)).toList()
        : [];
  }

  // Actualiza un resgistro
  Future<int> updateScan(ScanModel newScan) async {
    final db = await database;
    final res = await db?.update('Scans', newScan.toJson(),
        where: 'id = ?', whereArgs: [newScan.id]);

    return res!;
  }

  // Elimina un resgistro especifico
  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db?.delete('Scans', where: 'id = ?', whereArgs: [id]);

    return res!;
  }

  // Elimina todos los resgistros
  Future<int> deleteAllScan() async {
    final db = await database;
    final res = await db?.rawDelete('''
        DELETE FROM Scans
      ''');

    return res!;
  }
}
