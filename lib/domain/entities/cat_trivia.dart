import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class CatTrivia extends Equatable {
  final String fact;
  final int factLength;

  CatTrivia({@required this.fact, @required this.factLength})
      : super([fact, factLength]);
}
