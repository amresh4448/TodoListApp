
import 'package:dartz/dartz.dart';
import 'package:todo_list_app/data/network/failure.dart';
import 'package:todo_list_app/domain/entities/festival.dart';
import 'package:todo_list_app/domain/repository/repository.dart';
import 'package:todo_list_app/domain/usecases/base_usecase.dart';

class FavoriteFestivalsUseCaseInput {
  String id;
  FavoriteFestivalsUseCaseInput(
    this.id,
  );
}

class FavoriteFestivalsUseCase extends BaseUseCase<FavoriteFestivalsUseCaseInput, List<Festival>> {
  final Repository _repository;

  FavoriteFestivalsUseCase(this._repository);
 

  @override
  Future<Either<Failure, List<Festival>>> execute(input) async {
   
    final result =  _repository.getUserFestivals(input.id);
    return result;
  }

}