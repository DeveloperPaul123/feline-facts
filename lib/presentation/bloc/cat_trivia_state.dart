part of 'cat_trivia_bloc.dart';

abstract class CatTriviaState extends Equatable {
  CatTriviaState([List props = const <dynamic>[]]);
  @override
  List<Object?> get props => [props];
}

class Empty extends CatTriviaState {}

class Loading extends CatTriviaState {}

class Loaded extends CatTriviaState {
  final List<CatTrivia> triviaList;
  Loaded({required this.triviaList}) : super([triviaList]);
}

class Error extends CatTriviaState {
  final String errorMessage;
  Error({required this.errorMessage}) : super([errorMessage]);
}
