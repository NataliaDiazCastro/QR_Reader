import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/provider.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      onPressed: () async {
        // String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        //     '#3D8BEF', 'Cancelar', false, ScanMode.QR);
        final barcodeScanRes = 'https://fernando-herrera.com';

        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);
        scanListProvider.nuevoScan('geo:15.33,15.66');
        scanListProvider.nuevoScan(barcodeScanRes);
      },
      child: const Icon(Icons.qr_code_scanner_rounded),
    );
  }
}
