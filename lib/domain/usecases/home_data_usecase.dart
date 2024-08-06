import 'package:dartz/dartz.dart';
import 'package:todo_list_app/app/functions.dart';
import 'package:todo_list_app/data/network/failure.dart';
import 'package:todo_list_app/data/requests/requests.dart';
import 'package:todo_list_app/domain/entities/authentication.dart';
import 'package:todo_list_app/domain/entities/device_info.dart';
import 'package:todo_list_app/domain/entities/home_data.dart';
import 'package:todo_list_app/domain/repository/repository.dart';
import 'package:todo_list_app/domain/usecases/base_usecase.dart';

class HomeDataUseCaseInput {
  HomeDataUseCaseInput();
}

class HomeDataUseCase extends BaseUseCase<HomeDataUseCaseInput, HomeDataObject> {
  final Repository _repository;

  HomeDataUseCase(this._repository);
 

  @override
  Future<Either<Failure, HomeDataObject>> execute(input) async {
    DeviceInfo deviceInfo = await getDeviceDetails();
    
    final result = await _repository.getHomeData();
    return result;
  }

}