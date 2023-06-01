import 'package:FGM/shared/constants/app_config.dart';
import 'package:FGM/shared/model/base_api_response.dart';
import 'package:FGM/shared/services/api_service.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

class GiveService {
  final ApiService _apiService;

  GiveService(this._apiService);

  Future<BaseApiResponse> getAllAccount() async {
    return _apiService.get(
      '${AppConfig.fgmApiBaseUrl}give',
    );
  }

  Future<BaseApiResponse> createPayment(
    String fullname,
    String email,
    int amount,
    CheckoutResponse data,
  ) async {
    final body = {
      'fullname': fullname,
      'email': email,
      'amount': amount,
      'data': data.toString(),
    };

    return _apiService.post(
      '${AppConfig.fgmApiBaseUrl}payments',
      body: body,
    );
  }
}
