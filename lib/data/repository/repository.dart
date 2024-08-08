

import 'package:dio/dio.dart';
import 'package:todo_list_app/data/data_source/remote_data_source.dart';
import 'package:todo_list_app/data/mappers/mapper.dart';
import 'package:todo_list_app/data/network/error_handler.dart';
import 'package:todo_list_app/data/network/network_info.dart';
import 'package:todo_list_app/domain/entities/authentication.dart';
import 'package:todo_list_app/data/requests/requests.dart';
import 'package:todo_list_app/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:todo_list_app/domain/entities/home_data.dart';
import 'package:todo_list_app/domain/repository/repository.dart';

class RepositoryImplementation extends Repository {
  RemoteDataSource _remoteDataSource;
  NetworkInfo _networkInfo;

  RepositoryImplementation(this._networkInfo, this._remoteDataSource);

  @override
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest) async {
    if(await _networkInfo.isConnected){
      try {
        final response = await _remoteDataSource.login(loginRequest);
        if(response.status == ResponseCode.SUCCESS) {
          //Return Response as Entity
          return Right(response.toDomain());
        }
        else {

          return Left(Failure( response.status ?? ResponseCode.DEFAULT, response.message?? ResponseMessage.DEFAULT ));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    else {
      return Left(Failure(502, "Please check your internet connection"));
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(RegisterRequest registerRquest) async {
    if(await _networkInfo.isConnected){
      try {
        final response = await _remoteDataSource.register(registerRquest);
        if(response.status == ResponseCode.SUCCESS) {
          //Return Response as Entity
          return Right(response.toDomain());
        }
        else {
          return Left(Failure( response.status ?? ResponseCode.DEFAULT, response.message?? ResponseMessage.DEFAULT ));
        }
      } catch (error) {
        // var e = (error. as DioError);
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    else {
      return Left(Failure(502, "Please check your internet connection"));
    }
  }

  @override
  Future<Either<Failure, Authentication>> googleRegister(GoogleRegisterRequest registerRquest) async {
    if(await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.googleRegister(registerRquest);
        if(response.status == ResponseCode.SUCCESS) {
          //Return Response as Entity
          return Right(response.toDomain());
        }
        else {
          return Left(Failure( response.status ?? ResponseCode.DEFAULT, response.message?? ResponseMessage.DEFAULT ));
        }
      } catch (error) {
        // var e = (error. as DioError);
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    else {
      return Left(Failure(502, "Please check your internet connection"));
    }
  }

  @override
  Future<Either<Failure, HomeDataObject>> getHomeData() async {
    if(await _networkInfo.isConnected){
      try {
        final response = await _remoteDataSource.getHomeData();
        if(response.status == ResponseCode.SUCCESS) {
          //Return Response as Entity
          return Right(response.toDomain());
        }
        else {
          return Left(Failure( response.status ?? ResponseCode.DEFAULT, response.message?? ResponseMessage.DEFAULT ));
        }
      } catch (error) {
        print(error.toString());
        if(error is DioError){
          var dioError = error;
          return Left(Failure(dioError.response!.statusCode!, dioError.response!.data["message"]));
        }
        else {
          return Left(ErrorHandler.handle(error).failure);
        }
      }
    }
    else {
      return Left(Failure(502, "Please check your internet connection"));
    }
  }

  
  @override
  Future<Either<Failure, String>> updatePassword(UpdateProfileRequest input) async {
    if(await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.updatePassword(input);
        if(response.status == ResponseCode.SUCCESS) {
          //Return Response as Entity
          return Right(response.message!);
        }
        else {
          return Left(Failure( response.status ?? ResponseCode.DEFAULT, response.message?? ResponseMessage.DEFAULT ));
        }
      } catch (error) {
        print(error.toString());
        
        if(error is DioError){
          var dioError = error;
          return Left(Failure(dioError.response!.statusCode!, dioError.response!.data["message"]));
        }
        else {
          return Left(ErrorHandler.handle(error).failure);
        }
        
      }
    }
    else {
      return Left(Failure(502, "Please check your internet connection"));
    }
  }
  

  @override
  Future<Either<Failure, String>> updateProfile(UpdateProfileRequest input) async {
    if(await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.updateProfile(input);
        if(response.status == ResponseCode.SUCCESS) {
          //Return Response as Entity
          return Right(response.message!);
        }
        else {
          return Left(Failure( response.status ?? ResponseCode.DEFAULT, response.message?? ResponseMessage.DEFAULT ));
        }
      } catch (error) {
        print(error.toString());
        if(error is DioError && error.response != null){
          var dioError = error;
          return Left(Failure(dioError.response!.statusCode!, dioError.response!.data["message"]));
        }
        else {
          return Left(ErrorHandler.handle(error).failure);
        }
      }
    }
    else {
      return Left(Failure(502, "Please check your internet connection"));
    }
  }


  @override
  Future<Either<Failure, int>> logout() async {
    if(await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.logout();
        if(response.status == ResponseCode.SUCCESS) {
          //Return Response as Entity
          return Right(response.status!);
        }
        else {
          return Left(Failure( response.status ?? ResponseCode.DEFAULT, response.message?? ResponseMessage.DEFAULT ));
        }
      } catch (error) {
        print(error.toString());
        if(error is DioError && error.response != null) {
          var dioError = error;
          return Left(Failure(dioError.response!.statusCode!, dioError.response!.data["message"]));
        }
        else {
          return Left(ErrorHandler.handle(error).failure);
        }
      }
    }
    else {
      return Left(Failure(502, "Please check your internet connection"));
    }
  }
  
  @override
  Future<Either<Failure, String>> verifyPhone(String id, String phone) async {
    if(await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.verifyPhone(id, phone);
        print(response);
        if(response.status == ResponseCode.SUCCESS) {
          //Return Response as Entity
          return Right(response.message!);
        }
        else {
          return Left(Failure( response.status ?? ResponseCode.DEFAULT, response.message?? ResponseMessage.DEFAULT ));
        }
      } catch (error) {
        print(error.toString());
        if(error is DioError && error.response != null) {
          var dioError = error;
          return Left(Failure(dioError.response!.statusCode!, dioError.response!.data["message"]));
        }
        else {
          return Left(ErrorHandler.handle(error).failure);
        }
      }
    }
    else {
      return Left(Failure(502, "Please check your internet connection"));
    }
  }
  
  @override
  Future<Either<Failure, String>> verifyOtp(String id, String otp) async {
    if(await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.verifyOtp(id, otp);
        if(response.status == ResponseCode.SUCCESS) {
          //Return Response as Entity
          return Right(response.message!);
        }
        else {
          return Left(Failure( response.status ?? ResponseCode.DEFAULT, response.message?? ResponseMessage.DEFAULT ));
        }
      } catch (error) {
        print(error.toString());
        if(error is DioError && error.response != null) {
          var dioError = error;
          return Left(Failure(dioError.response!.statusCode!, dioError.response!.data["message"]));
        }
        else {
          return Left(ErrorHandler.handle(error).failure);
        }
      }
    }
    else {
      return Left(Failure(502, "Please check your internet connection"));
    }
  }









}