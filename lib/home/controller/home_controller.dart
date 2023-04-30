import 'dart:convert';

import 'package:FGM/devotional/model/all_devotional_model.dart';
import 'package:FGM/home/model/all_wotw_model.dart';
import 'package:FGM/home/services/home_service.dart';
import 'package:FGM/media/model/all_media_model.dart';
import 'package:FGM/shared/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final HomeService _service = HomeService(ApiService());
  final isLoading = false.obs;
  final isLoadingMessage = false.obs;
  final isLoadingWotw = false.obs;
  var mediaItem = <AllMediaModel>[].obs;
  var devotionaItem = <AllDevotionalModel>[].obs;
  var wotwItem = <AllWotwModel>[].obs;


  Future<void> getAllMedia(
    BuildContext context,
  ) async {
    isLoadingMessage.value = true;
    final response = await _service.getAllMedia();
    if (response.code == 200) {
      if (response.success == true) {
        final jsonList = response.data as List<dynamic>;
        final result = jsonList.map((e) => AllMediaModel.fromJson(e)).toList();
        mediaItem.value = List<AllMediaModel>.from(result);
      }
    }
    isLoadingMessage.value = false;
  }

  Future<void> getAllWotw(
    BuildContext context,
  ) async {
    isLoadingWotw.value = true;
    final response = await _service.getAllWotw();
    if (response.code == 200) {
      if (response.success == true) {
        final jsonList = response.data as List<dynamic>;
        final result = jsonList.map((e) => AllWotwModel.fromJson(e)).toList();
        wotwItem.value = List<AllWotwModel>.from(result);
      }
    }
    isLoadingWotw.value = false;
  }

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
