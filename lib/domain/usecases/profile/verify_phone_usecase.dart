// ignore_for_file: public_member_api_docs, sort_constructors_first



import 'package:dartz/dartz.dart';

import 'package:todo_list_app/app/app_constants.dart';
import 'package:todo_list_app/app/functions.dart';
import 'package:todo_list_app/data/network/failure.dart';
import 'package:todo_list_app/data/requests/requests.dart';
import 'package:todo_list_app/domain/entities/device_info.dart';
import 'package:todo_list_app/domain/repository/repository.dart';
import 'package:todo_list_app/domain/usecases/base_usecase.dart';

class VerifyPhoneUsecaseInput {
  String user_id;
  String phone;

  VerifyPhoneUsecaseInput(
    this.user_id,
    this.phone,
  );
}

class VerifyPhoneUsecase extends BaseUseCase<VerifyPhoneUsecaseInput, String> {
  final Repository _repository;

  VerifyPhoneUsecase(this._repository);
 

  @override
  Future<Either<Failure, String>> execute(input) async {
    DeviceInfo deviceInfo = await getDeviceDetails();
    
    final result = await _repository.verifyPhone(input.user_id, input.phone);
    return result;
  }

}