import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:minakomi/export.dart';

import '../blocs/auth/auth_bloc.dart';

enum ValidType { none, name, password, email, fullname, notEmpty }

class CustomTextField extends StatefulWidget {
  final String? label;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? prefix;
  final Widget? prefixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final bool showSuffix;
  final bool obscureText;
  final VoidCallback? onSuffixIconTap;
  final ValidType validType;
  final bool enabled;
  final Function(bool)? onValid;
  final TextCapitalization textCapitalization;
  final String Function(String?)? validator;
  final String? hintText;
  final Color? colorDisable;
  final int? maxLength;
  final String? textError;
  final double? width;
  final VoidCallback? onTap;
  final EdgeInsets? contentPadding;
  final double textSize;
  final int? maxLines;
  final int? minLines;
  final FocusNode? focus;
  final Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final int? maxCounter;
  final BoxConstraints? constraints;
  const CustomTextField({
    Key? key,
    this.prefix,
    this.prefixIcon,
    this.label,
    this.onSuffixIconTap,
    this.inputFormatters,
    this.controller,
    this.suffixIcon,
    this.keyboardType,
    this.onChanged,
    this.validType = ValidType.none,
    this.showSuffix = true,
    this.obscureText = false,
    this.enabled = true,
    this.onValid,
    this.validator,
    this.hintText,
    this.colorDisable,
    this.maxLength,
    this.width,
    this.textCapitalization = TextCapitalization.none,
    this.textError,
    this.onTap,
    this.contentPadding,
    this.textSize = 17,
    this.maxLines = 1,
    this.minLines,
    this.focus,
    this.onFieldSubmitted,
    this.textInputAction,
    this.maxCounter,
    this.constraints,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focus;
  bool hasFocus = false;
  bool valid = false;
  bool hasChanged = false;
  @override
  void initState() {
    super.initState();
    _focus = widget.focus ?? FocusNode();
    if (widget.controller != null && widget.controller!.text.isNotEmpty) {
      hasChanged = true;
    }
    switch (widget.validType) {
      case ValidType.none:
        valid = true;
        break;
      case ValidType.name:
        if (widget.controller != null &&
            widget.controller!.text.isValidName()) {
          valid = true;
        } else {
          valid = false;
        }
        break;
      case ValidType.password:
        if (widget.controller != null &&
            widget.controller!.text.isValidPassword(
                passwordValidType: PasswordValidType.atLeast8Characters)) {
          valid = true;
        } else {
          valid = false;
        }
        break;
      case ValidType.email:
        if (widget.controller != null &&
            widget.controller!.text.isValidEmail()) {
          valid = true;
        } else {
          valid = false;
        }
        break;
      case ValidType.fullname:
        if (widget.controller != null &&
            widget.controller!.text.isValidFullName()) {
          valid = true;
        } else {
          valid = false;
        }
        break;
      case ValidType.notEmpty:
        if (widget.controller != null && widget.controller!.text.isNotEmpty) {
          valid = true;
        } else {
          valid = false;
        }
    }
    _focus.addListener(() {
      if (_focus.hasFocus) {
        setState(() {
          hasFocus = true;
        });
      } else {
        setState(() {
          hasFocus = false;
        });
      }
    });
  }

  String getError() {
    if (widget.textError != null) {
      return '${widget.textError}';
    }
    switch (widget.validType) {
      case ValidType.none:
        return '';
      case ValidType.name:
        return 'key_too_short'.tr();
      case ValidType.password:
        return 'key_weak_password'.tr();
      case ValidType.email:
        return 'key_invalid_email_address'.tr();
      case ValidType.fullname:
        return 'key_invalid'.tr();

      case ValidType.notEmpty:
        return 'key_this_field_cant_be_empty'.tr();
    }
  }

  @override
  Widget build(BuildContext context) {
    Color borderColor = Colors.white;
    if (BlocProvider.of<AuthBloc>(context).state.themeData!.brightness ==
        Brightness.light) {
      borderColor = Colors.black;
    }
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            _focus.requestFocus();
          },
          child: TextFormField(
            textInputAction: widget.textInputAction,
            onFieldSubmitted: widget.onFieldSubmitted,
            validator: widget.validator,
            focusNode: _focus,
            textCapitalization: widget.textCapitalization,
            enabled: widget.enabled,
            onTap: widget.onTap,
            onChanged: (value) {
              if (hasChanged == false && value.isNotEmpty) {
                setState(() {
                  hasChanged = true;
                });
              }
              switch (widget.validType) {
                case ValidType.none:
                  break;
                case ValidType.name:
                  if (value.isValidName()) {
                    setState(() {
                      valid = true;
                    });
                  } else {
                    setState(() {
                      valid = false;
                    });
                  }
                  break;
                case ValidType.password:
                  if (value.isValidPassword(
                    passwordValidType: PasswordValidType.atLeast8Characters,
                  )) {
                    setState(() {
                      valid = true;
                    });
                  } else {
                    setState(() {
                      valid = false;
                    });
                  }
                  break;
                case ValidType.email:
                  if (value.isValidEmail()) {
                    setState(() {
                      valid = true;
                    });
                  } else {
                    setState(() {
                      valid = false;
                    });
                  }
                  break;
                case ValidType.fullname:
                  if (value.isValidFullName()) {
                    setState(() {
                      valid = true;
                    });
                  } else {
                    setState(() {
                      valid = false;
                    });
                  }
                  break;
                case ValidType.notEmpty:
                  if (value.isNotEmpty) {
                    setState(() {
                      valid = true;
                    });
                  } else {
                    setState(() {
                      valid = false;
                    });
                  }
              }
              if (widget.onChanged != null) {
                widget.onChanged!(value);
              }
              if (widget.onValid != null) {
                widget.onValid!(valid);
              }
              setState(() {});
            },
            keyboardType: widget.keyboardType,
            controller: widget.controller,
            obscureText: widget.obscureText,
            inputFormatters: widget.inputFormatters,
            style: AppStyles.textSize17(
              fontWeight: FontWeight.w500,
              color: widget.enabled ? null : AppColors.greyText,
            ).copyWith(fontSize: widget.textSize),
            scrollPadding: EdgeInsets.zero,
            maxLength: widget.maxLength,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            decoration: InputDecoration(
              constraints: widget.constraints,
              hintText: widget.hintText,
              counter: widget.maxLength != null &&
                      widget.controller != null &&
                      hasFocus
                  ? Text(
                      "${widget.controller!.text.characters.length} /${widget.maxLength}",
                      style: AppStyles.textSize13())
                  : null,
              errorMaxLines: 2,
              labelStyle: AppStyles.textSize17(
                fontWeight: FontWeight.w500,
                color: const Color(0xff8f8f8f),
              ).copyWith(fontSize: widget.textSize),
              errorText: ((!valid && hasChanged) || widget.textError != null)
                  ? getError()
                  : null,
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                ),
              ),
              contentPadding: widget.contentPadding ??
                  const EdgeInsets.symmetric(horizontal: 17, vertical: 13),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: borderColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: borderColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                ),
              ),
              labelText: widget.label,
              counterText: '',
              focusColor: AppColors.primary,
              errorStyle: AppStyles.textSize12(color: AppColors.primary),
              prefix: widget.prefix,
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon == null
                  ? null
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 17),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (widget.suffixIcon != null)
                            GestureDetector(
                              onTap: widget.onSuffixIconTap,
                              child: widget.suffixIcon,
                            ),
                          if (widget.validType != ValidType.none &&
                              widget.suffixIcon == null)
                            GestureDetector(
                              onTap: widget.onSuffixIconTap,
                              child:
                                  valid ? const Icon(Icons.check) : Container(),
                            ),
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomPhoneNumberField extends StatefulWidget {
  final String? label;
  final TextEditingController? controller;
  final PhoneNumber? initialValue;
  final bool? isEnabled;
  final Function? onInputChanged;
  final Function? onInputValidated;
  final Function? onFieldSubmitted;
  final Function? onSaved;
  final bool? autoFocus;
  final FocusNode? focusNode;
  final bool? hasError;
  final List<String>? countries;
  final double fontSize;
  const CustomPhoneNumberField({
    Key? key,
    this.label,
    this.controller,
    this.initialValue,
    this.isEnabled = true,
    this.onInputChanged,
    this.onInputValidated,
    this.onFieldSubmitted,
    this.onSaved,
    this.autoFocus = false,
    this.focusNode,
    this.hasError = false,
    this.countries,
    this.fontSize = 17,
  }) : super(key: key);
  @override
  _CustomPhoneNumberFieldState createState() => _CustomPhoneNumberFieldState();
}

class _CustomPhoneNumberFieldState extends State<CustomPhoneNumberField> {
  bool _showIcon = false;
  PhoneNumber? _initPhoneNumber;
  @override
  void initState() {
    _initPhoneNumber = widget.initialValue;
    widget.controller!.addListener(() {
      if (widget.controller!.text != '') {
        setState(() {
          _showIcon = true;
        });
      } else {
        setState(() {
          _showIcon = false;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isLTR =
        EasyLocalization.of(context)!.currentLocale!.languageCode != 'ar';

    return Stack(
      children: [
        InternationalPhoneNumberInput(
          countries: widget.countries,
          initialValue:
              _initPhoneNumber ?? PhoneNumber(isoCode: 'AU', dialCode: '+61'),
          searchBoxDecoration: InputDecoration(
            enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            border: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            labelText: widget.label,
            labelStyle: AppStyles.textSize17(fontWeight: FontWeight.w500)
                .copyWith(fontSize: widget.fontSize),
          ),
          onInputChanged: (PhoneNumber number) {
            if (_initPhoneNumber?.dialCode != number.dialCode) {
              _initPhoneNumber = number;
            }
            if (widget.onInputChanged != null) {
              if (number.phoneNumber!.replaceAll('${number.dialCode}', '') !=
                  '0') {
                widget.onInputChanged!(number);
              } else {
                widget.controller!.text = '';
              }
            }
            print(number.phoneNumber);
          },
          focusNode: widget.focusNode,
          onInputValidated: (bool value) {
            if (widget.onInputValidated != null) {
              widget.onInputValidated!(value);
            }
          },
          cursorColor: Colors.white,
          spaceBetweenSelectorAndTextField: 12,
          textAlignVertical: TextAlignVertical.top,
          selectorConfig: const SelectorConfig(
            selectorType: PhoneInputSelectorType.DIALOG,
            trailingSpace: false,
            leadingPadding: 0,
          ),
          ignoreBlank: true,
          autoValidateMode: AutovalidateMode.disabled,
          selectorTextStyle: AppStyles.textSize17(
            fontWeight: FontWeight.w500,
          ).copyWith(fontSize: widget.fontSize),
          textFieldController: widget.controller,
          textStyle: AppStyles.textSize17(
            fontWeight: FontWeight.w500,
          ).copyWith(fontSize: widget.fontSize),
          locale: EasyLocalization.of(context)!.currentLocale!.languageCode,
          isEnabled: widget.isEnabled!,
          inputDecoration: InputDecoration(
            hintText: 'key_phone_number'.tr(),
            hintStyle:
                AppStyles.textSize16(color: Colors.white.withOpacity(0.7)),
            border: InputBorder.none,
          ),
          onFieldSubmitted: (text) {
            if (widget.onFieldSubmitted != null) {
              widget.onFieldSubmitted!();
            }
          },
          autoFocus: widget.autoFocus!,
          formatInput: false,
          keyboardType: TextInputType.number,
          inputBorder: const OutlineInputBorder(),
          onSaved: (PhoneNumber number) {
            if (widget.onSaved != null) {
              widget.onSaved!(number);
            }
          },
          isLTR: isLTR,
        ),
        if (_showIcon)
          PositionedDirectional(
            end: 25,
            bottom: 0,
            top: 0,
            child: Align(
              alignment: Alignment.centerRight,
              child: widget.hasError!
                  ? const Icon(Icons.check, color: AppColors.primary)
                  : const Icon(Icons.error, color: Colors.red, size: 22),
            ),
          )
      ],
    );
  }
}
