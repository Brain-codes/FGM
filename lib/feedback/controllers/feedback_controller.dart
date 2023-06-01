// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'package:FGM/feedback/model/feedback_model.dart';
import 'package:FGM/feedback/services/feedback_service.dart';
import 'package:FGM/shared/components/snackbar/snack_bar.dart';
import 'package:FGM/shared/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class FeedbackController extends GetxController {
  final FeedbackService _service = FeedbackService(ApiService());
  final isLoading = false.obs;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  final fullName = ''.obs;
  final phoneNumber = ''.obs;
  final message = ''.obs;
  var businessDetails = FeedbackModel().obs;

  Future<void> sendFeedback(
    BuildContext context,
  ) async {
    print('EFE 2');

    isLoading.value = true;
    final response = await _service.sendFeedback(
      fullName.value,
      phoneNumber.value,
      message.value,
    );
    if (response.code! >= 200 && response.code! < 300) {
      if (response.success == true) {
        successSnackBar(
          'Feedback Submitted',
          'Thanks for your honest feedback.',
        );
        fullName.value = '';
        phoneNumber.value = '';
        message.value = '';
        fullNameController.text = '';
        phoneNumberController.text = '';
        messageController.text = '';
        Navigator.pop(context);
      } else {
        errorSnackBar('Oops!', response.message);
      }
    }
    isLoading.value = false;
  }
}
