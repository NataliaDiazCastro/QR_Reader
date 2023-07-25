import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/provider.dart';

class MapasScreen extends StatelessWidget {
  const MapasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_, i) => ListTile(
        leading: Icon(
          Icons.map,
          size: 30,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(scans[i].valor),
        subtitle: Text('${scans[i].id}'),
        trailing: Icon(
          Icons.keyboard_arrow_right_rounded,
          color: Colors.grey,
        ),
        onTap: () => print(scans[i].id),
      ),
    );
  }
}
