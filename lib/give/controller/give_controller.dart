// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:FGM/give/give_payment_successful.dart';
import 'package:FGM/give/model/all_give_model.dart';
import 'package:FGM/give/services/give_service.dart';
import 'package:FGM/shared/components/snackbar/snack_bar.dart';
import 'package:FGM/shared/services/api_service.dart';
import 'package:FGM/shared/services/local_database_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:page_transition/page_transition.dart';

class GiveController extends GetxController {
  final GiveService _service = GiveService(ApiService());
  final isLoading = false.obs;
  final isLoadingToPay = false.obs;
  final isLoadingPayment = false.obs;
  TextEditingController ammountPayController = TextEditingController();
  final ammountPay = ''.obs;
  final _user = LocalDatabaseService().getData(DbKeyStrings.userDetailsKey);
  var giveItem = <AllGiveModel>[].obs;

  Future<void> getAllAccount(
    BuildContext context,
  ) async {
    isLoading.value = true;
    final response = await _service.getAllAccount();
    if (response.code == 200) {
      if (response.success == true) {
        var result = (response.data as List<dynamic>)
            .map((e) => AllGiveModel.fromJson(e))
            .toList();
        giveItem.value = List<AllGiveModel>.from(result);
      }
    }
    isLoading.value = false;
  }

  makePayment(BuildContext context, PaystackPlugin plugin) async {
    isLoadingToPay.value = true;
    int price = int.parse(ammountPay.value) * 100;
    Charge charge = Charge()
      ..amount = price
      ..reference = 'ref ${DateTime.now()}'
      ..email = _user['email']
      ..currency = 'NGN';
    CheckoutResponse response = await plugin.checkout(
      context,
      method: CheckoutMethod.card,
      charge: charge,
    );
    if (response.status == true) {
      createPayment(context, response);
    } else {
      errorSnackBar('Oops!', response.message);
    }
    isLoadingToPay.value = false;
  }

  Future<void> createPayment(
    BuildContext context,
    data,
  ) async {
    isLoadingPayment.value = true;
    final response = await _service.createPayment(
      _user['name'],
      _user['email'],
      int.parse(ammountPay.value),
      data,
    );
    if (response.success == true) {
      ammountPay.value = '';
      ammountPayController.text = '';
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeftWithFade,
          child: PaymentSuccessful(),
        ),
      );
    } else {
      errorSnackBar('Oops!', response.message);
    }
    isLoadingPayment.value = false;
  }
}
