import 'package:FGM/event/model/all_event_model.dart';
import 'package:FGM/event/services/event_service.dart';
import 'package:FGM/shared/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EventController extends GetxController {
  final EventService _service = EventService(ApiService());
  final isLoading = false.obs;
  var upcomingEventItem = <AllEventModel>[].obs;
  var liveEventItem = <AllEventModel>[].obs;
  var pastEventItem = <AllEventModel>[].obs;

  Future<void> getAllEvent(
    BuildContext context,
  ) async {
    isLoading.value = true;
    final response = await _service.getAllEvent();
    if (response.code == 200) {
      if (response.success == true) {
        var upcomingEventresult =
            (response.data['upcomingEvents'] as List<dynamic>)
                .map((e) => AllEventModel.fromJson(e))
                .toList();
        var liveEventResult = (response.data['liveEvents'] as List<dynamic>)
            .map((e) => AllEventModel.fromJson(e))
            .toList();
        var pastEventResult = (response.data['pastEvents'] as List<dynamic>)
            .map((e) => AllEventModel.fromJson(e))
            .toList();
        pastEventItem.value = List<AllEventModel>.from(pastEventResult);
        liveEventItem.value = List<AllEventModel>.from(liveEventResult);
        upcomingEventItem.value = List<AllEventModel>.from(upcomingEventresult);
      }
    }
    isLoading.value = false;
  }

  String formatDate(DateTime dateTime) {
    DateFormat dateFormat = DateFormat('MMMM d, yyyy');
    return dateFormat.format(dateTime);
  }

  String formatTime(DateTime dateTime) {
    DateFormat timeFormat = DateFormat('hh:mm a (WAT)');
    return timeFormat.format(dateTime);
  }
}
