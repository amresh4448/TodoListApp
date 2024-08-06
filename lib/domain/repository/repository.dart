
import 'package:dartz/dartz.dart';
import 'package:todo_list_app/app/app_constants.dart';
import 'package:todo_list_app/data/network/failure.dart';
import 'package:todo_list_app/data/requests/requests.dart';
import 'package:todo_list_app/data/responses/responses.dart';
import 'package:todo_list_app/domain/entities/authentication.dart';
import 'package:todo_list_app/domain/entities/booking.dart';
import 'package:todo_list_app/domain/entities/festival.dart';
import 'package:todo_list_app/domain/entities/home_data.dart';
import 'package:todo_list_app/domain/entities/place.dart';
import 'package:todo_list_app/domain/entities/user.dart';
import 'package:todo_list_app/domain/usecases/profile/profile_update_usecase.dart';

abstract class Repository {
  
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
  Future<Either<Failure, int>> logout();
  Future<Either<Failure, Authentication>> register(RegisterRequest registerRquest);
  Future<Either<Failure, Authentication>> googleRegister(GoogleRegisterRequest registerRquest);
  
  Future<Either<Failure, String>> verifyPhone(String id, String phone);
  Future<Either<Failure, String>> verifyOtp(String id, String otp);
  Future<Either<Failure, String>> updatePassword(UpdateProfileRequest input);
  Future<Either<Failure, String>> updateProfile(UpdateProfileRequest input);

  Future<Either<Failure, HomeDataObject>> getHomeData();
  Future<Either<Failure, List<Festival>>> getUserFestivals(String id);
  Future<Either<Failure, List<Place>>> getUserPlaces(String id);

  Future<Either<Failure, String>> addFavoritePlace(String client_id, String place_id);
  Future<Either<Failure, String>> removeFavoritePlace(String client_id, String place_id);
  Future<Either<Failure, String>> addFavoriteFestival(String client_id, String festival_id);
  Future<Either<Failure, String>> removeFavoriteFestival(String client_id, String festival_id);
  
  Future<Either<Failure, List<Booking>>> getUserBooking(String id);
  Future<Either<Failure, String>> placeBooking(BookingRequest input);


}

