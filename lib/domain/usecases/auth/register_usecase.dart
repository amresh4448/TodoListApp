import 'package:dartz/dartz.dart';
import 'package:todo_list_app/app/functions.dart';
import 'package:todo_list_app/data/network/failure.dart';
import 'package:todo_list_app/data/requests/requests.dart';
import 'package:todo_list_app/domain/entities/authentication.dart';
import 'package:todo_list_app/domain/entities/device_info.dart';
import 'package:todo_list_app/domain/repository/repository.dart';
import 'package:todo_list_app/domain/usecases/base_usecase.dart';

class RegisterUseCaseInput {
  String first_name;
  String last_name;
  String email;
  String phone;
  String password;

  RegisterUseCaseInput(
    this.first_name,
    this.last_name,
    this.email,
    this.phone,
    this.password,
  );
}


class RegisterUseCase extends BaseUseCase<RegisterUseCaseInput, Authentication> {
  final Repository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(input) async {
    DeviceInfo deviceInfo = await getDeviceDetails();
    
    return await _repository.register(
      RegisterRequest (
        input.first_name, 
        input.last_name, 
        input.email, 
        input.password, 
        input.phone, 
        deviceInfo.name
      )
    );
  }

}