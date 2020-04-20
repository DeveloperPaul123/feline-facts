import 'dart:convert';

import 'package:felinefacts/entities/cat_trivia.dart';
import 'package:felinefacts/models/cat_trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fixtures/fixture_reader.dart';

void main() {
  final model = CatTriviaModel(
    fact: "During the time of the Spanish Inquisition, Pope Innocent VIII condemned cats as evil and thousands of cats were burned. Unfortunately, the widespread killing of cats led to an explosion of the rat population, which exacerbated the effects of the Black Death.", 
    factLength: 259
    );
  test('Should be a subclass of CatTrivia', () async {
    expect(model, isA<CatTrivia>());
  });

  group('fromJson', () {
    test(
      'Should return valid model from JSON',
      () async {
          final Map<String, dynamic> jsonMap = json.decode(fixture('cat_fact.json'));
          final result = CatTriviaModel.fromMap(jsonMap);
          expect(result, model);
      }
    );
  });
}
