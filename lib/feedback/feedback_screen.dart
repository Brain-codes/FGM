// ignore_for_file: prefer_const_constructors, unused_field

import 'package:FGM/feedback/controllers/feedback_controller.dart';
import 'package:FGM/shared/components/buttons/filled_button.dart';
import 'package:FGM/shared/components/buttons/filled_loading_button.dart';
import 'package:FGM/shared/components/buttons/outlined_button.dart';
import 'package:FGM/shared/components/input/feedback_textfield.dart';
import 'package:FGM/shared/constants/app_color.dart';
import 'package:FGM/shared/constants/app_string.dart';
import 'package:FGM/shared/extensions/form_validator.dart';
import 'package:FGM/shared/themes/text_theme.dart';
import 'package:FGM/shared/ui/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class FeedBackScreen extends StatefulWidget {
  const FeedBackScreen({super.key});

  @override
  State<FeedBackScreen> createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  final FeedbackController _feedbackController = Get.put(FeedbackController());
  bool _fullNameHasError = false;
  bool _messageHasError = false;
  bool _phoneNumberHasError = false;
  String _errorMessage = '';
  final _formKey = GlobalKey<FormState>();

  Future<void> _handleSendFeedback(BuildContext context) async {
    if (!_feedbackController.fullNameController.text.isValidFullName()) {
      setState(() {
        _fullNameHasError = true;
        _errorMessage = 'Enter Correct Full Name';
      });
      return;
    }

    if (!_feedbackController.phoneNumberController.text.isValidPhone()) {
      setState(() {
        _phoneNumberHasError = true;
        _errorMessage = 'Phone Number is not valid';
      });
      return;
    }

    if (_feedbackController.messageController.text.isEmpty) {
      setState(() {
        _messageHasError = true;
        _errorMessage = 'Field Cannot be Empty';
      });
      return;
    }

    if (_formKey.currentState!.validate()) {
      setState(() {
        _fullNameHasError = false;
        _messageHasError = false;
        _phoneNumberHasError = false;
      });
      _feedbackController.sendFeedback(context);
    }
  }

  @override
  void initState() {
    _feedbackController.fullNameController.addListener(() {
      _fullNameHasError = false;
    });

    _feedbackController.phoneNumberController.addListener(() {
      _phoneNumberHasError = false;
    });

    _feedbackController.messageController.addListener(() {
      _messageHasError = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Obx(
        () => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Feedback',
                    style: TextThemes(context).getTextStyle(
                      color: AppColors.primaryTextColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  FeedBackTextField(
                    textInputType: TextInputType.text,
                    actionKeyboard: TextInputAction.done,
                    label: AppStrings.password,
                    hintText: 'Full Name',
                    controller: _feedbackController.fullNameController,
                    hasError: _fullNameHasError,
                    onTyping: (value) =>
                        _feedbackController.fullName.value = value!,
                    errorMessage: _fullNameHasError ? _errorMessage : '',
                    enabled: !_feedbackController.isLoading.value,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FeedBackTextField(
                    textInputType: TextInputType.text,
                    actionKeyboard: TextInputAction.done,
                    label: AppStrings.password,
                    hintText: 'Phone Number',
                    controller: _feedbackController.phoneNumberController,
                    hasError: _phoneNumberHasError,
                    onTyping: (value) =>
                        _feedbackController.phoneNumber.value = value!,
                    errorMessage: _phoneNumberHasError ? _errorMessage : '',
                    enabled: !_feedbackController.isLoading.value,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FeedBackTextField(
                    textInputType: TextInputType.text,
                    actionKeyboard: TextInputAction.done,
                    label: AppStrings.password,
                    hintText: 'Comment',
                    numberOfLines: 5,
                    controller: _feedbackController.messageController,
                    hasError: _messageHasError,
                    onTyping: (value) =>
                        _feedbackController.message.value = value!,
                    errorMessage: _messageHasError ? _errorMessage : '',
                    enabled: !_feedbackController.isLoading.value,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Obx(
                    () => _feedbackController.isLoading.value
                        ? FilledLoadingButtonWidget()
                        : FilledButton(
                            onTaps: () {
                              _handleSendFeedback(context);
                            },
                            buttonTitle: 'Submit',
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
