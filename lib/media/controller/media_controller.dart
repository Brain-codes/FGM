import 'package:FGM/media/model/all_media_model.dart';
import 'package:FGM/media/services/media_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../shared/services/api_service.dart';

class MediaController extends GetxController {
  final MediaService _service = MediaService(ApiService());
  final isLoading = false.obs;
  var mediaItem = <AllMediaModel>[].obs;

  Future<void> getAllMedia(BuildContext context, ) async {
    isLoading.value = true;
    final response = await _service.getAllMedai();
    if (response.code == 200) {
      if (response.success == true) {
        var result = (response.data as List<dynamic>)
            .map((e) => AllMediaModel.fromJson(e))
            .toList();
        mediaItem.value = List<AllMediaModel>.from(result);
      }
    }
    isLoading.value = false;
  }
}
