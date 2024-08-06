
import 'package:dartz/dartz.dart';

import 'package:todo_list_app/data/network/failure.dart';
import 'package:todo_list_app/domain/repository/repository.dart';
import 'package:todo_list_app/domain/usecases/base_usecase.dart';

class RemoveFavoriteFestivalUseCaseInput {
  String user_id;
  String festival_id;
  RemoveFavoriteFestivalUseCaseInput(
    this.user_id,
    this.festival_id,
  );
}

class RemoveFavoriteFestivalUseCase extends BaseUseCase<RemoveFavoriteFestivalUseCaseInput, String> {
  final Repository _repository;

  RemoveFavoriteFestivalUseCase(this._repository);
 

  @override
  Future<Either<Failure, String>> execute(input) async {
   
    final result =  _repository.removeFavoriteFestival(input.user_id, input.festival_id);
    return result;
  }

}