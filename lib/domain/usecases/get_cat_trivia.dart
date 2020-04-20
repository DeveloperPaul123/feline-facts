import 'package:dartz/dartz.dart';
import 'package:felinefacts/core/errors/failure.dart';
import 'package:felinefacts/domain/entities/cat_trivia.dart';
import 'package:felinefacts/domain/repositories/cat_trivia_repository.dart';
import 'package:felinefacts/domain/usecases/use_case.dart';

class GetCatTriviaUseCase implements UseCase<CatTrivia, UseCaseParameters> {
  final BaseCatTriviaRepository repository;
  GetCatTriviaUseCase(this.repository);

  @override
  Future<Either<Failure, CatTrivia>> call(UseCaseParameters params) async {
    return await repository.getCatFact();
  }
}
