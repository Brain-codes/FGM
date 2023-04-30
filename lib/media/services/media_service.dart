import 'package:FGM/shared/model/base_api_response.dart';
import 'package:FGM/shared/services/api_service.dart';

import '../../shared/constants/app_config.dart';

class MediaService {
  final ApiService _apiService;

  MediaService(this._apiService);

  Future<BaseApiResponse> getAllMedai() async {
    return _apiService.get(
      '${AppConfig.fgmApiBaseUrl}messages',
    );
  }
}
