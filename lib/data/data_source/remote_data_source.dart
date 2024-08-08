import 'package:todo_list_app/data/requests/requests.dart';
import 'package:todo_list_app/data/network/api_client.dart';
import 'package:todo_list_app/data/responses/responses.dart';

abstract class RemoteDataSource {
  Future<AuthResponse> login(LoginRequest loginRequest);
  Future<BaseResponse> logout();
  Future<AuthResponse> register(RegisterRequest registerRquest);
  Future<AuthResponse> googleRegister(GoogleRegisterRequest registerRquest);
  
  Future<BaseResponse> verifyPhone(String id, String phone);
  Future<BaseResponse> verifyOtp(String id, String otp);
  Future<HomeDataResponse> getHomeData();
  Future<BaseResponse> updateProfile(UpdateProfileRequest request);
  Future<BaseResponse> updatePassword(UpdateProfileRequest request);
}

class RemoteDataSourceImplementation implements RemoteDataSource {
  ApiClient _appServiceClient;
  RemoteDataSourceImplementation(this._appServiceClient);

  @override
  Future<AuthResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(loginRequest.email, loginRequest.password, loginRequest.device_name);
  }
  
  
  @override
  Future<BaseResponse> updatePassword(UpdateProfileRequest request) async {
    return await _appServiceClient.updatePassword(request.email!, request.password!, request.new_password!);
  }
  

  
 
  @override
  Future<AuthResponse> register(RegisterRequest registerRquest) async {
    return await _appServiceClient.register(
      registerRquest.first_name, 
      registerRquest.last_name, 
      registerRquest.email, 
      registerRquest.password, 
      registerRquest.phone
    );
  }
  
  @override
  Future<BaseResponse> logout() async {
    return await _appServiceClient.logout();
  }

  @override
  Future<BaseResponse> verifyPhone(String id, String phone) async {
    var result =  await _appServiceClient.verifyPhone(id, phone);
    return result;
  }

  @override
  Future<BaseResponse> verifyOtp(String id, String otp) async {
    return await _appServiceClient.verifyOtp(id, otp);
  }
  
  @override
  Future<AuthResponse> googleRegister(GoogleRegisterRequest registerRquest) async {
    return await _appServiceClient.googleLogin(
      registerRquest.first_name, 
      registerRquest.last_name, 
      registerRquest.email, 
      registerRquest.sub
    );
  }

    Future<AuthResponse> getTask(GoogleRegisterRequest registerRquest) async {
    return await _appServiceClient.googleLogin(
      registerRquest.first_name, 
      registerRquest.last_name, 
      registerRquest.email, 
      registerRquest.sub
    );
  }
  
  @override
  Future<HomeDataResponse> getHomeData() {
    // TODO: implement getHomeData
    throw UnimplementedError();
  }
  
  @override
  Future<BaseResponse> updateProfile(UpdateProfileRequest request) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }

  

}