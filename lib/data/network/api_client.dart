import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:todo_list_app/app/app_constants.dart';
import 'package:todo_list_app/data/responses/responses.dart';

part "api_client.g.dart";

@RestApi(baseUrl: AppConstants.baseUrl)
abstract class ApiClient {

  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST("/api/auth/login")
  Future<AuthResponse> login(
    @Field("email") String email,
    @Field("password") String password,
    @Field("device_name") String device_name
  );

  @POST("/api/auth/logout")
  Future<BaseResponse>logout ();

  @POST("/api/auth/register")
  Future<AuthResponse> register(
    @Field("first_name") String first_name,
    @Field("last_name") String last_name,
    @Field("email") String email,
    @Field("password") String password,
    @Field("phone") String phone
  );

  @POST("/api/auth/reset")
  Future<BaseResponse> updatePassword(
    @Field("email") String email,
    @Field("password") String password,
    @Field("new_password") String new_password
  );

  @POST("/api/auth/google")
  Future<AuthResponse> googleLogin(
    @Field("first_name") String first_name,
    @Field("last_name") String last_name,
    @Field("email") String email,
    @Field("sub") String sub,
  );

  @POST("/api/auth/verify/phone")
  Future<BaseResponse> verifyPhone(
    @Field("id") String user_id,
    @Field("phone") String phone,
  );

  @POST("/api/auth/verify/otp")
  Future<BaseResponse> verifyOtp(
    @Field("id") String user_id,
    @Field("otp") String otp,
  );



}