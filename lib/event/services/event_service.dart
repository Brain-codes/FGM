import 'package:FGM/shared/constants/app_config.dart';
import 'package:FGM/shared/model/base_api_response.dart';
import 'package:FGM/shared/services/api_service.dart';

class EventService {
  final ApiService _apiService;

  EventService(this._apiService);

  Future<BaseApiResponse> getAllEvent() async {
    return _apiService.get(
      '${AppConfig.fgmApiBaseUrl}events',
    );
  }
}
