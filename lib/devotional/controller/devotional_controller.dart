import 'package:FGM/devotional/model/all_devotional_model.dart';
import 'package:FGM/devotional/services/devotional_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../shared/services/api_service.dart';

class DevotionalController extends GetxController {
  final DevotionalService _service = DevotionalService(ApiService());
  final isLoading = false.obs;
  var devotionaItem = <AllDevotionalModel>[].obs;

  Future<void> getAllDevotional(
    BuildContext context,
  ) async {
    isLoading.value = true;
    final response = await _service.getAllDevotional();
    if (response.code == 200) {
      if (response.success == true) {
        var result = (response.data as List<dynamic>)
            .map((e) => AllDevotionalModel.fromJson(e))
            .toList();
        devotionaItem.value = List<AllDevotionalModel>.from(result);
        print(devotionaItem[0].content);
      }
    }
    isLoading.value = false;
  }
}
