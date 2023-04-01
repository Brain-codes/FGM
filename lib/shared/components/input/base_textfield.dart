// ignore_for_file: prefer_const_constructors

import 'package:FGM/shared/constants/app_color.dart';
import 'package:FGM/shared/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/app_icon.dart';

class BaseTextField extends StatefulWidget {
  final TextInputType? textInputType;
  final String? hintText;
  final String label;
  final String? errorMessage;
  final Widget? suffixIcon;
  final String? defaultText;
  final FocusNode? focusNode;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final void Function()? functionValidate;
  final String? parametersValidate;
  final TextInputAction? actionKeyboard;
  final void Function()? onSubmitField;
  final void Function()? onFieldTap;
  final void Function()? onSuffixIconTap;
  final bool hasError;
  final Function(String? value)? onTyping;
  final bool enabled;
  List<TextInputFormatter>? inputFormatters;
  final int? numberOfLines;
  final int? maxLength;

  BaseTextField({
    required this.label,
    this.hintText,
    this.focusNode,
    this.errorMessage,
    this.textInputType,
    this.defaultText,
    this.obscureText = false,
    this.validator,
    this.controller,
    this.functionValidate,
    this.parametersValidate,
    this.actionKeyboard = TextInputAction.next,
    this.onSubmitField,
    this.onFieldTap,
    this.suffixIcon,
    this.onSuffixIconTap,
    this.hasError = false,
    this.onTyping,
    this.enabled = true,
    this.inputFormatters,
    this.numberOfLines,
    this.maxLength,
  });

  @override
  _TextFormFieldWidgetState createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<BaseTextField> {
  double bottomPaddingToError = 12;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: AppColors.inActive,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            textAlign: TextAlign.center,
            style: TextThemes(context).getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryTextColor,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            cursorColor: AppColors.primaryColor,
            obscureText: widget.obscureText,
            keyboardType: widget.textInputType,
            textInputAction: widget.actionKeyboard,
            focusNode: widget.focusNode,
            enabled: widget.enabled,
            maxLines: widget.numberOfLines,
            inputFormatters: widget.inputFormatters,
            style: FormTextThemes(context).getFormTextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
            ),
            maxLength: widget.maxLength,
            initialValue: widget.defaultText,
            decoration: InputDecoration(
              suffixIcon: widget.suffixIcon != null
                  ? GestureDetector(
                      child: widget.suffixIcon,
                      onTap: widget.onSuffixIconTap,
                    )
                  : null,
              hintText: widget.hintText,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color:
                        widget.hasError ? AppColors.red : AppColors.inActive),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: widget.hasError
                        ? AppColors.red
                        : AppColors.primaryColor),
              ),
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.normal,
                letterSpacing: 1.2,
              ),
              contentPadding: EdgeInsets.only(
                top: 12,
                bottom: bottomPaddingToError,
                left: 12.0,
                right: 8.0,
              ),
              isDense: false,
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.inActive),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.red),
              ),
            ),
            controller: widget.controller,
            validator: widget.validator,
            onFieldSubmitted: (value) {
              if (widget.onSubmitField != null) widget.onSubmitField!();
            },
            onTap: () {
              if (widget.onFieldTap != null) widget.onFieldTap!();
            },
            onChanged: (val) => widget.onTyping!(val),
          ),
          Visibility(
            visible: widget.errorMessage!.isEmpty ? false : true,
            child: Container(
              padding: const EdgeInsets.only(
                left: 5.0,
              ),
              height: 28,
              child: Row(
                children: <Widget>[
                  SvgPicture.asset(AppIcons.errorInputIcon,
                      height: 14, width: 14),
                  Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Text(
                      widget.errorMessage!,
                      style: TextThemes(context).getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w200,
                        color: AppColors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//OTHER FUNCTIONS

String commonValidation(String value, String messageError) {
  var required = requiredValidator(value, messageError);

  if (required != null) {
    return required;
  }

  return "null";
}

String requiredValidator(value, messageError) {
  if (value.isEmpty) {
    return messageError;
  }

  return "null";
}

void changeFocus(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();

  FocusScope.of(context).requestFocus(nextFocus);
}
