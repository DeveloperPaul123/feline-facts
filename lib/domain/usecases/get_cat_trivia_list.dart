
import 'package:dartz/dartz.dart';
import 'package:felinefacts/core/errors/failure.dart';
import 'package:felinefacts/domain/entities/cat_trivia.dart';
import 'package:felinefacts/domain/repositories/cat_trivia_repository.dart';

class GetCatTriviaListUseCase {
  final BaseCatTriviaRepository repository;

  GetCatTriviaListUseCase(this.repository);

  Future<Either<Failure, List<CatTrivia>>> execute() async {
    // just get all of them for now
    // TODO: In the future, don't hard code this
    return await repository.getCatFacts(1000, 500);
  }
}
