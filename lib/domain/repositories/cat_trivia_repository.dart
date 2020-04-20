import 'package:dartz/dartz.dart';
import 'package:felinefacts/core/errors/exception.dart';
import 'package:felinefacts/core/errors/failure.dart';
import 'package:felinefacts/core/network/network_info.dart';
import 'package:felinefacts/data/datasources/cat_trivia_local_datasource.dart';
import 'package:felinefacts/data/datasources/cat_trivia_remote_datasource.dart';
import 'package:felinefacts/domain/entities/cat_trivia.dart';
import 'package:flutter/cupertino.dart';

abstract class BaseCatTriviaRepository {
  Future<Either<Failure, List<CatTrivia>>> getCatFacts(
      int numberOfFacts, int maxLength);
  Future<Either<Failure, CatTrivia>> getCatFact();
}

class CatTriviaRepository implements BaseCatTriviaRepository {
  final BaseCatTriviaLocalDatasource localDatasource;
  final BaseCatTriviaRemoteDataSource remoteDataSource;
  final BaseNetworkInfo networkInfo;

  CatTriviaRepository(
      {@required this.localDatasource,
      @required this.remoteDataSource,
      @required this.networkInfo});

  @override
  Future<Either<Failure, CatTrivia>> getCatFact() async {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<CatTrivia>>> getCatFacts(
      int numberOfFacts, int maxLength) async {
    // local cache is single source of truth, so if it's empty we need to fill it up
    try {
      final allLocalFacts = await localDatasource.getAllCatTrivia();
      return Right(allLocalFacts);
    } on CacheException {
      // we have no facts, pull them from the API
      if (await networkInfo.isConnected) {
        try {
          // retrive from API
          final catTrivia =
              await remoteDataSource.getCatFacts(numberOfFacts, maxLength);
          // cache locally
          localDatasource.saveCatTriviaList(catTrivia);
          return Right(catTrivia);
        } on ServerException {
          return Left(ServerFailure());
        }
      }
    }
    // no internet so we can't retrieve new facts
    return Left(ServerFailure());
  }
}
