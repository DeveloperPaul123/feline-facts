part of 'cat_trivia_bloc.dart';

abstract class CatTriviaEvent extends Equatable {
  CatTriviaEvent();
}

class GetCatTrivaListEvent extends CatTriviaEvent {
  GetCatTrivaListEvent();
}
