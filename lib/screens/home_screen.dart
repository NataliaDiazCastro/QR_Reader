import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:qr_reader/models/scan_model.dart';
import 'package:qr_reader/providers/provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/screens/direcciones_screens.dart';
import 'package:qr_reader/screens/mapas_screens.dart';
import 'package:qr_reader/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Historial'),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<ScanListProvider>(context, listen: false)
                  .borrarTodos();
            },
            icon: Icon(Icons.delete_forever),
          )
        ],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtener el Selected menu opt
    final uiProvider = Provider.of<UiProvider>(context);
    // Cambiar para mostrar la pagina respectiva
    final currentIndex = uiProvider.selectedMenuOpt;

    // TODO: Temporal leer la base de datos
    // final tempScan = ScanModel(valor: 'https://google.com');
    // DBProvider.db.nuevoScan(tempScan);
    // DBProvider.db.getTodos().then(print)

    // DBProvider.db.deleteAllScan().then(print);

    // Usar el ScanLisProvider
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    switch (currentIndex) {
      case 0:
        scanListProvider.cargarScansPorTipo('geo');
        return MapasScreen();

      case 1:
        scanListProvider.cargarScansPorTipo('http');
        return DireccionesScreen();
      default:
        return MapasScreen();
    }
  }
}
