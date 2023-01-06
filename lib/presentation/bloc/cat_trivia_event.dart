part of 'cat_trivia_bloc.dart';

abstract class CatTriviaEvent extends Equatable {
  CatTriviaEvent();
  @override
  List<Object?> get props => [];
}

class GetCatTriviaListEvent extends CatTriviaEvent {
  GetCatTriviaListEvent();
}
