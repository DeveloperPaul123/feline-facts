import 'package:felinefacts/core/errors/exception.dart';
import 'package:felinefacts/data/providers/cat_trivia_provider.dart';
import 'package:felinefacts/data/models/cat_trivia_model.dart';
import 'package:flutter/cupertino.dart';

const DATABASE_NAME = "cat_trivia.db";

abstract class BaseCatTriviaLocalDatasource {
  Future<List<CatTriviaModel>> getAllCatTrivia();
  Future<bool> saveCatTrivia(CatTriviaModel triviaModel);
  Future<bool> saveCatTriviaList(List<CatTriviaModel> triviaModels);
}

class CatTriviaLocalDatasource extends BaseCatTriviaLocalDatasource {
  final BaseCatTriviaProvider provider;

  CatTriviaLocalDatasource({@required this.provider}) : super();

  @override
  Future<List<CatTriviaModel>> getAllCatTrivia() async {
    final allTrivia = await provider.getAllTrivia();
    // no values available so we throw.
    if(allTrivia.length == 0) {
      throw CacheException();
    }
    return Future.value(allTrivia);
  }

  @override
  Future<bool> saveCatTrivia(CatTriviaModel triviaModel) async {
    final newId = await provider.insert(triviaModel);
    return newId == -1;
  }

  @override
  Future<bool> saveCatTriviaList(List<CatTriviaModel> triviaModels) async {
    final ids = await provider.insertAll(triviaModels);
    return ids.contains(-1);
  }
}
