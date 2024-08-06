import 'package:dartz/dartz.dart';
import 'package:todo_list_app/app/functions.dart';
import 'package:todo_list_app/data/network/failure.dart';
import 'package:todo_list_app/data/requests/requests.dart';
import 'package:todo_list_app/domain/entities/authentication.dart';
import 'package:todo_list_app/domain/entities/device_info.dart';
import 'package:todo_list_app/domain/repository/repository.dart';
import 'package:todo_list_app/domain/usecases/base_usecase.dart';

class LoginUseCaseInput {
  String email;
  String password;
  LoginUseCaseInput(this.email, this.password);
}

class LoginUseCase extends BaseUseCase<LoginUseCaseInput, Authentication> {
  final Repository _repository;

  LoginUseCase(this._repository);
 

  @override
  Future<Either<Failure, Authentication>> execute(input) async {
    DeviceInfo deviceInfo = await getDeviceDetails();
    
    return await _repository.login(
      LoginRequest(input.email, input.password, deviceInfo.name)
    );
  }

}