
import 'package:dartz/dartz.dart';

import 'package:todo_list_app/data/network/failure.dart';
import 'package:todo_list_app/domain/entities/booking.dart';
import 'package:todo_list_app/domain/entities/activity.dart';
import 'package:todo_list_app/domain/repository/repository.dart';
import 'package:todo_list_app/domain/usecases/base_usecase.dart';

class ToggleActivityInBookingUseCaseInput {
  Booking booking;
  Activity activity;
  ToggleActivityInBookingUseCaseInput(
    this.booking,
    this.activity,
  );
}

class ToggleActivityInBookingUseCase extends BaseUseCase<ToggleActivityInBookingUseCaseInput, Booking> {
  final Repository _repository;

  ToggleActivityInBookingUseCase(this._repository);
 

  @override
  Future<Either<Failure, Booking>> execute(input) async {
    List<Activity>? activities = input.booking.activities;
    try {
      if( activities == null){
        activities = <Activity>[input.activity];
      }
      else {
        if (activities.contains(input.activity) ){
          activities.remove(input.activity);
        }
        else {
          activities.add(input.activity);
        }
      }

      input.booking.activities = activities;
      
      return Right(input.booking);
    } catch (e) {
      return Left(Failure(-1, e.toString())); 
    }
  }

}