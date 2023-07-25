import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.selectedMenuOpt;

    return BottomNavigationBar(
      onTap: (value) => uiProvider.selectedMenuOpt = value,
      elevation: 0,
      currentIndex: currentIndex,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.map_rounded),
          label: 'Mapa',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.compass_calibration_rounded),
          label: 'Direcciones',
        ),
      ],
    );
  }
}
