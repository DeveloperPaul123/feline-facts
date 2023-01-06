import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:felinefacts/core/errors/failure.dart';

class UseCaseParameters extends Equatable {
  final int factLimit;
  final int maxLength;
  UseCaseParameters({required this.factLimit, required this.maxLength});

  @override
  List<Object?> get props => [factLimit, maxLength];
}

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
