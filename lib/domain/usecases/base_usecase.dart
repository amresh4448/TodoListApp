import 'package:dartz/dartz.dart';
import 'package:todo_list_app/data/network/failure.dart';

abstract class BaseUseCase<In, Out> {
  Future<Either<Failure, Out>> execute(In input);
}

