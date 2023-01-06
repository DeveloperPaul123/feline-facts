import 'package:felinefacts/injection_container.dart' as di;
import 'package:felinefacts/presentation/screens/facts_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tekartik_app_flutter_sqflite/sqflite.dart';

void main() {
  if (!kIsWeb) {
    sqfliteWindowsFfiInit();
  }
  di.init();
  runApp(FelineFactsApp());
}

class FelineFactsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return MaterialApp(
        title: 'Feline Facts',
        home: FactsScreen(),
        theme: theme.copyWith(
            colorScheme:
                theme.colorScheme.copyWith(secondary: Colors.indigo[800])));
  }
}
