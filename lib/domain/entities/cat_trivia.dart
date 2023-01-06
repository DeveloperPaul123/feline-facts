import 'package:equatable/equatable.dart';

class CatTrivia extends Equatable {
  final String fact;
  final int factLength;

  CatTrivia({required this.fact, required this.factLength});

  @override
  List<Object?> get props => [fact, factLength];
}
