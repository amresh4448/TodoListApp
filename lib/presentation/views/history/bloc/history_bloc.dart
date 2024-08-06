import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_list_app/app/app_pref.dart';
import 'package:todo_list_app/domain/entities/activity.dart';
import 'package:todo_list_app/domain/entities/booking.dart';
import 'package:todo_list_app/domain/entities/festival.dart';
import 'package:todo_list_app/domain/entities/place.dart';
import 'package:todo_list_app/domain/usecases/bookings/user_bookings_usecase.dart';
import 'package:todo_list_app/presentation/views/checkout/bloc/checkout_bloc.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final GetBookingsUseCase _bookingUsecase;
  final AppPreferences _appPreferences;

  HistoryBloc(this._bookingUsecase, this._appPreferences) : super(HistoryInitial()) {
    on<GetHistory>((event, emit) {
      _getUserBookings(event.user_id);
    });
  }

  _getUserBookings(int user_id) async {
    try {
      Booking? booking = await _appPreferences.getBooking();
      booking ??= Booking(user_id, <Place>[], <Festival>[], <Activity>[]);
      (await _bookingUsecase.execute(user_id.toString())).fold(
        (failure) {
          emit(HistoryError(failure.message));
        }, 
        (entity) async {
          //clear cart
          _appPreferences.setBooking(null);
          emit(HistoryLoaded(entity));
        }
      );
    } catch (e) {
      emit(HistoryError(e.toString()));
    }
  }


}
