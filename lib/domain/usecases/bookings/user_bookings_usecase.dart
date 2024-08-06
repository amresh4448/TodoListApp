
import 'package:dartz/dartz.dart';

import 'package:todo_list_app/data/network/failure.dart';
import 'package:todo_list_app/domain/entities/booking.dart';
import 'package:todo_list_app/domain/repository/repository.dart';
import 'package:todo_list_app/domain/usecases/base_usecase.dart';

class GetBookingsUseCase extends BaseUseCase<String, List<Booking>> {
  final Repository _repository;

  GetBookingsUseCase(this._repository);
 

  @override
  Future<Either<Failure, List<Booking>>> execute(input) async {
   
    final result = await _repository.getUserBooking(input);
    return result;
  }

}