import 'package:felinefacts/injection_container.dart' as di;
import 'package:felinefacts/presentation/screens/facts_screen.dart';
import 'package:flutter/material.dart';

void main() {
  di.init();
  runApp(FelineFactsApp());
} 
 
class FelineFactsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feline Facts',
      home: FactsScreen(),
      theme: ThemeData(
        accentColor: Colors.blue[800]
      ),
    );
  }
}