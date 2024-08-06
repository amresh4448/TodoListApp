import 'package:dartz/dartz.dart';
import 'package:todo_list_app/app/functions.dart';
import 'package:todo_list_app/data/network/failure.dart';
import 'package:todo_list_app/data/requests/requests.dart';
import 'package:todo_list_app/domain/entities/authentication.dart';
import 'package:todo_list_app/domain/entities/device_info.dart';
import 'package:todo_list_app/domain/repository/repository.dart';
import 'package:todo_list_app/domain/usecases/base_usecase.dart';

class GoogleLoginUseCaseInput {
  String first_name; 
  String last_name;
  String email;
  String sub;

  GoogleLoginUseCaseInput(
    this.first_name,
    this.last_name,
    this.email,
    this.sub,
  );
}


class GoogleLoginUseCase extends BaseUseCase<GoogleLoginUseCaseInput, Authentication> {
  final Repository _repository;

  GoogleLoginUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(input) async {
    DeviceInfo deviceInfo = await getDeviceDetails();
    
    return await _repository.googleRegister(GoogleRegisterRequest(
      input.first_name, 
      input.last_name, 
      input.email, 
      input.sub
    ));
    
  }

}
  
  
  
  
  
 