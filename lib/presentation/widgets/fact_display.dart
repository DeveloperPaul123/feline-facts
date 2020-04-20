import 'package:flutter/material.dart';

class FactDisplay extends StatelessWidget {
  final String fact;
  final int index;
  final int totalFacts;
  FactDisplay({Key key, @required this.fact, @required this.index, @required this.totalFacts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        child: Column(
          children: <Widget>[
            Text(
              "Fact ${index + 1} of $totalFacts",
              textAlign: TextAlign.center,
              style: textTheme.headline3,
            ),
            SizedBox(height: 16.0,),
            Text(
              fact,
              textAlign: TextAlign.justify,
              style: textTheme.bodyText2.apply(
                fontSizeFactor: 2.0
              ),
            ),
          ],
        ),
      ),
    );
  }
}
