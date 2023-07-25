import 'package:flutter/material.dart';
import 'package:qr_reader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String tipoSeleccionado = 'http';

  Future<ScanModel> nuevoScan(String valor) async {
    //
    final newScan = ScanModel(valor: valor);
    // Id del registro insertado
    final id = await DBProvider.db.nuevoScan(newScan);
    // Asignar el ID de la base de datos al modelo
    newScan.id = id;

    if (tipoSeleccionado == newScan.tipo) {
      scans.add(newScan);
      // Se notifica cuando hay un cambio
      notifyListeners();
    }
    return newScan;
  }

  cargarScans() async {
    final scan = await DBProvider.db.getTodos();
    scans = [...scan!];
    notifyListeners();
  }

  cargarScansPorTipo(String tipo) async {
    final scan = await DBProvider.db.getScansPorTipo(tipo);
    scans = [...scan!];
    tipoSeleccionado = tipo;
    notifyListeners();
  }

  borrarTodos() async {
    await DBProvider.db.deleteAllScan();
    scans = [];
    notifyListeners();
  }

  borraScanPorId(int id) async {
    await DBProvider.db.deleteScan(id);
    cargarScansPorTipo(tipoSeleccionado);
  }
}
