import 'package:FGM/shared/constants/app_config.dart';
import 'package:FGM/shared/model/base_api_response.dart';
import 'package:FGM/shared/services/api_service.dart';

class AuthService {
  final ApiService _apiService;

  AuthService(this._apiService);

  Future<BaseApiResponse> login(String email, String password) async {
    final body = {'email': email, 'password': password};
    return _apiService.post('${AppConfig.fgmApiBaseUrl}auth/login', body: body);
  }


    Future<BaseApiResponse> register(
    String name,
    String email,
    String phone,
    String password,
  ) async {
    final body = {
      'name': name,
      'email': email,
      'phoneNumber': phone,
      'password': password,
    };
    return _apiService.post('${AppConfig.fgmApiBaseUrl}auth/register',
        body: body);
  }



  Future<BaseApiResponse> refreshToken(
      String token, String refreshToken) async {
    final body = {'token': token, 'refreshToken': refreshToken};
    return _apiService.post('${AppConfig.fgmApiBaseUrl}auth/refresh-token',
        body: body);
  }
}
