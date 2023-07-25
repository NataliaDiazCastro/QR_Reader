import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:qr_reader/screens/screens.dart';
import 'providers/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UiProvider()),
        ChangeNotifierProvider(create: (_) => ScanListProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Reader',
        initialRoute: 'home',
        routes: {
          'home': (_) => HomeScreen(),
          'mapa': (_) => MapaScreen(),
        },
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          // colorScheme: ColorScheme.light().copyWith(primary: Colors.deepPurple),
          floatingActionButtonTheme:
              FloatingActionButtonThemeData(backgroundColor: Colors.deepPurple),
        ),
      ),
    );
  }
}
