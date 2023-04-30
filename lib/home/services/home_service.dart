import 'package:FGM/shared/constants/app_config.dart';
import 'package:FGM/shared/model/base_api_response.dart';
import 'package:FGM/shared/services/api_service.dart';

class HomeService {
  final ApiService _apiService;

  HomeService(this._apiService);

  Future<BaseApiResponse> getAllDevotional() async {
    return _apiService.get(
      '${AppConfig.fgmApiBaseUrl}devotional',
    );
  }

  Future<BaseApiResponse> getAllMedia() async {
    return _apiService.get(
      '${AppConfig.fgmApiBaseUrl}messages',
    );
  }

    Future<BaseApiResponse> getAllWotw() async {
    return _apiService.get(
      '${AppConfig.fgmApiBaseUrl}wotw',
    );
  }
}
