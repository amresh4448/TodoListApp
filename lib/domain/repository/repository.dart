
import 'package:dartz/dartz.dart';
import 'package:todo_list_app/data/network/failure.dart';
import 'package:todo_list_app/data/requests/requests.dart';
import 'package:todo_list_app/domain/entities/authentication.dart';
import 'package:todo_list_app/domain/entities/home_data.dart';

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

  // Future<List<Task>> getTasks();
  // Future<Either> addTask(Task task);
  // Future<Either> updateTask(Task task);
  // Future<Either> deleteTask(String id);
  // // Future<void> deleteTask(String id);





}

