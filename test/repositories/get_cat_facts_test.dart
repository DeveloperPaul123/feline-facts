import 'package:dartz/dartz.dart';
import 'package:felinefacts/domain/entities/cat_trivia.dart';
import 'package:felinefacts/domain/repositories/cat_trivia_repository.dart';
import 'package:felinefacts/domain/usecases/get_cat_trivia.dart';
import 'package:felinefacts/domain/usecases/use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockCatFactsRepository extends Mock implements BaseCatTriviaRepository {}

void main() {
  MockCatFactsRepository repository = MockCatFactsRepository();
  GetCatTriviaUseCase useCase = GetCatTriviaUseCase(repository);

  final testCatTrivia = CatTrivia(fact: "", factLength: 0);

  test('Should get single trivia fact for cats from repository', () async {
    // arrange
    // when `getCatFact()` is called with any return the above test object.
    when(repository.getCatFact()).thenAnswer((_) async => Right(testCatTrivia));
    // act
    final result =
        await useCase(UseCaseParameters(factLimit: 10, maxLength: 200));
    // assert
    expect(result, Right(testCatTrivia));
    verify(repository.getCatFact());
    verifyNoMoreInteractions(repository);
  });
}
