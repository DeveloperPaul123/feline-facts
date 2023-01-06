import 'dart:convert';

import 'package:felinefacts/core/errors/exception.dart';
import 'package:felinefacts/data/models/cat_trivia_model.dart';
import 'package:http/http.dart' as http;

const API_ENDPOINT = "catfact.ninja";
const FACTS_ENDPOINT = "facts";
const FACT_ENDPOINT = "fact";

abstract class BaseCatTriviaRemoteDataSource {
  /// Throws a [ServerException] for all error codes.
  Future<List<CatTriviaModel>> getCatFacts(int numberOfFacts, int maxLength);

  /// Throws a [ServerException] for all error codes.
  Future<CatTriviaModel> getCatFact();
}

class CatTriviaRemoteDataSource implements BaseCatTriviaRemoteDataSource {
  final http.Client client;

  CatTriviaRemoteDataSource({required this.client});

  @override
  Future<CatTriviaModel> getCatFact() async {
    final response = await client.get(
        Uri.dataFromString("$API_ENDPOINT/$FACT_ENDPOINT"),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode != 200) {
      throw ServerException();
    }

    return CatTriviaModel.fromMap(json.decode(response.body));
  }

  @override
  Future<List<CatTriviaModel>> getCatFacts(
      int numberOfFacts, int maxLength) async {
    final queryParameters = {
      'limit': numberOfFacts.toString(),
      'max_length': maxLength.toString()
    };

    final url = Uri.https(API_ENDPOINT, '/$FACTS_ENDPOINT', queryParameters);
    final response =
        await client.get(url, headers: {'Content-Type': 'application/json'});
    if (response.statusCode != 200) {
      throw ServerException();
    }
    final jsonData = json.decode(response.body);
    final factList = jsonData['data'];
    return factList
        .map<CatTriviaModel>((e) => CatTriviaModel.fromMap(e))
        .toList();
  }
}
