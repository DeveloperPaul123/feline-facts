import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:felinefacts/core/errors/failure.dart';
import 'package:felinefacts/domain/entities/cat_trivia.dart';
import 'package:felinefacts/domain/usecases/get_cat_trivia_list.dart';

part 'cat_trivia_event.dart';
part 'cat_trivia_state.dart';

const SERVER_ERROR = "Unable to retrieve facts from API.";
const CACHE_ERROR = "Could not load facts from database.";

class CatTriviaBloc extends Bloc<CatTriviaEvent, CatTriviaState> {
  final GetCatTriviaListUseCase listUseCase;

  CatTriviaBloc({required this.listUseCase}) : super(Empty()) {
    on<CatTriviaEvent>(mapEventToState, transformer: sequential());
  }

  Future<void> mapEventToState(
      CatTriviaEvent event, Emitter<CatTriviaState> emit) async {
    if (event is GetCatTriviaListEvent) {
      emit(Loading());
      final listEither = await listUseCase.execute();
      emit(listEither.fold(
          (failure) => Error(errorMessage: _mapFailureToMessage(failure)),
          (catTriviaList) => Loaded(triviaList: catTriviaList)));
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_ERROR;
      case CacheFailure:
        return CACHE_ERROR;
      default:
        return "Unexpected error";
    }
  }
}
