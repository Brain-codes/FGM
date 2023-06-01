// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:FGM/auth/ui/auth_screens_header.dart';
import 'package:FGM/give/controller/give_controller.dart';
import 'package:FGM/give/model/all_give_model.dart';
import 'package:FGM/shared/components/bottom_sheet/base_bottom_sheet.dart';
import 'package:FGM/shared/components/buttons/filled_button.dart';
import 'package:FGM/shared/components/buttons/filled_loading_button.dart';
import 'package:FGM/shared/components/buttons/small_outlined_circular_button.dart';
import 'package:FGM/shared/components/input/base_textfield.dart';
import 'package:FGM/shared/components/loading/devotional_loading.dart';
import 'package:FGM/shared/components/loading/fullscreen_loading.dart';
import 'package:FGM/shared/components/tiles/account_tile.dart';
import 'package:FGM/shared/constants/app_color.dart';
import 'package:FGM/shared/constants/app_string.dart';
import 'package:FGM/shared/services/local_database_services.dart';
import 'package:FGM/shared/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

class GiveScreen extends StatefulWidget {
  const GiveScreen({super.key});

  @override
  State<GiveScreen> createState() => _GiveScreenState();
}

class _GiveScreenState extends State<GiveScreen> {
  final GiveController _GiveController = Get.put(GiveController());

  List<AllGiveModel>? _giveItem;
  var publicKey = dotenv.get(
    'PAYSTACT_PUBLIC_KEY',
    fallback: '',
  );
  final plugin = PaystackPlugin();
  String message = ";";
  bool _ammountHasError = false;
  String _errorMessage = '';
  final _user = LocalDatabaseService().getData(DbKeyStrings.userDetailsKey);
  final _formKey = GlobalKey<FormState>();

  getAllAccount() async {
    await _GiveController.getAllAccount(context);
    setState(() {
      _giveItem = _GiveController.giveItem;
    });
  }

  _onlinePaymentField() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      useRootNavigator: true,
      isScrollControlled: true,
      enableDrag: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: _formKey,
                  child: BaseBottomSheet(items: [
                    AuthScreensHeader(
                      heading: 'Online Payment',
                      description:
                          'Make a seamless transaction to make your pledges, tithe and offerings.',
                      showLogo: false,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    BaseTextField(
                      textInputType: TextInputType.phone,
                      actionKeyboard: TextInputAction.done,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(
                          top: 15,
                          right: 10,
                        ),
                        child: Text(
                          'NGN',
                          textAlign: TextAlign.center,
                          style: TextThemes(context).getTextStyle(
                            color: AppColors.primaryTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      label: AppStrings.ammount,
                      controller: _GiveController.ammountPayController,
                      hasError: _ammountHasError,
                      errorMessage: _ammountHasError ? _errorMessage : '',
                      onTyping: (value) =>
                          _GiveController.ammountPay.value = value!,
                      enabled: !_GiveController.isLoading.value,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () => _GiveController.isLoadingToPay.value
                          ? FilledLoadingButtonWidget()
                          : FilledButton(
                              onTaps: () {
                                _makePayment();
                              },
                              buttonTitle: 'Make Payment',
                            ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ]),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _makePayment() async {
    if (_GiveController.ammountPayController.text.isEmpty) {
      setState(() {
        _ammountHasError = true;
        _errorMessage = 'Amout can\'t be lesser than 0';
      });
      return;
    }

    if (_formKey.currentState!.validate()) {
      setState(() {
        _ammountHasError = false;
      });
      Navigator.pop(context);
      _GiveController.makePayment(context, plugin);
    }
  }

  @override
  void initState() {
    getAllAccount();
    plugin.initialize(publicKey: publicKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        // Hide the keyboard when the user taps outside of the text field
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Obx(
          () => Stack(
            children: [
              LayoutBuilder(
                builder: (context, constraint) {
                  return SafeArea(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              AppStrings.navGive,
                              style: TextThemes(context).getTextStyle(
                                color: AppColors.primaryTextColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Thank you for partnering with us. We appreciate your generosity and God bless you',
                              style: TextThemes(context).getTextStyle(
                                fontSize: 14,
                              ),
                            ),

                            SizedBox(
                              height: 20,
                            ),
                            Obx(
                              () => _GiveController.isLoading.value
                                  ? DevotionalLoader()
                                  : SizedBox(
                                      child: ListView.builder(
                                        itemCount: _giveItem!.length,
                                        padding: EdgeInsets.only(
                                          bottom: 20,
                                        ),
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 20,
                                            ),
                                            child: AccountTile(
                                              accountNumber:
                                                  '${_giveItem?[index].accountNumber}',
                                              accountName:
                                                  _giveItem?[index].accountName,
                                              bankName:
                                                  _giveItem?[index].bankName,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                            ),

                            //OR
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.placeHolderTextColor
                                            .withOpacity(0.25),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                  ),
                                  child: Text(
                                    'Or',
                                    style: TextThemes(context).getTextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.placeHolderTextColor,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.placeHolderTextColor
                                            .withOpacity(0.25),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(
                              height: 20,
                            ),
                            Obx(
                              () => _GiveController.isLoadingToPay.value
                                  ? FilledLoadingButtonWidget()
                                  : FilledButton(
                                      onTaps: () {
                                        _onlinePaymentField();
                                      },
                                      buttonTitle: 'Pay Online',
                                    ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              if (_GiveController.isLoadingPayment.value) CustomLoader(),
            ],
          ),
        ),
      ),
    );
  }
}
