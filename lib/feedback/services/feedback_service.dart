import 'package:FGM/shared/constants/app_config.dart';
import 'package:FGM/shared/model/base_api_response.dart';
import 'package:FGM/shared/services/api_service.dart';

class FeedbackService {
  final ApiService _apiService;

  FeedbackService(this._apiService);

  Future<BaseApiResponse> sendFeedback(
    String fullname,
    String phoneNumber,
    String message,
  ) async {
    final body = {
      "fullname": fullname,
      "phoneNumber": phoneNumber,
      "comment": message,
    };
    return _apiService.post(
      '${AppConfig.fgmApiBaseUrl}feedback',
      body: body,
    );
  }
}
