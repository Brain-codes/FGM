import 'package:FGM/shared/model/base_api_response.dart';
import 'package:FGM/shared/services/api_service.dart';

import '../../shared/constants/app_config.dart';

class DevotionalService {
  final ApiService _apiService;

  DevotionalService(this._apiService);


    Future<BaseApiResponse> getAllDevotional(
   
  ) async {
    return _apiService.get(
      '${AppConfig.fgmApiBaseUrl}devotional',
    );
  }
}
