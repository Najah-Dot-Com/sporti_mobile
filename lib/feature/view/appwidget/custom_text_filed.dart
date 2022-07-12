import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_font.dart';
import 'package:sporti/util/app_strings.dart';
import 'package:sporti/util/app_style.dart';
import 'package:get/get.dart';

class CustomTextFormFiled extends StatefulWidget /*with AppDimen, AppStyle */ {
  final String? label;
  final TextInputType? keyboardType;
  final bool? obscureText, isBorder, isFill, isInputFormatters;
  final Function(String)? customValid;
  final Function(String)? onSubmitted;
  final Function(String)? onChange;
  final TextEditingController? controller;
  final Color? fillColor, iconColor, suffixIconColor, enabledBorderColor;
  final VoidCallback? fun;
  final TextInputAction? textInputAction;
  final bool? isSmallPadding, isSmallPaddingWidth, isReadOnly;
  final int? maxLine, minLine;
  final TextAlign? textAlign;
  final int? maxLength;
  final FocusNode? focusNode, nexFocusNode;
  final bool? autoFocus;
  final TextStyle? hintStyle;
  final IconData? icon, suffixIcon;
  final double? iconSize;
  final bool? isSuffixIcon;

  /// you can use Theme.of(context).textTheme.bodyText1 for text
  /// you can use Theme.of(context).inputDecorationTheme.enabledBorder border ...

  const CustomTextFormFiled(
      {Key? key,
      this.label,
      this.keyboardType,
      this.obscureText = false,
      this.customValid,
      this.controller,
      this.isBorder = true,
      this.isFill = false,
      this.fillColor,
      this.isInputFormatters = false,
      this.fun,
      this.textInputAction,
      this.isSmallPadding = false,
      this.maxLine,
      this.isSmallPaddingWidth = false,
      this.minLine,
      this.isReadOnly = false,
      this.textAlign,
      this.maxLength,
      this.onSubmitted,
      this.iconColor,
      this.suffixIconColor,
      this.onChange,
      this.focusNode,
      this.nexFocusNode,
      this.hintStyle,
      this.autoFocus = false,
      this.icon,
      this.iconSize,
      this.enabledBorderColor,
      this.isSuffixIcon = false,
      this.suffixIcon})
      : super(key: key);

  @override
  State<CustomTextFormFiled> createState() => _CustomTextFormFiledState();
}

class _CustomTextFormFiledState extends State<CustomTextFormFiled> {
  bool obscureText = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obscureText = widget.obscureText!;
    setState(() {});
  }

  final ValueNotifier<TextDirection> _textDir =
      ValueNotifier(TextDirection.ltr);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _textDir,
        builder: (context, TextDirection textDirectionListenable, child) {
          return TextFormField(
            maxLength: widget.maxLength,
            autofocus: widget.autoFocus!,
            focusNode: widget.focusNode,
            onTap: widget.fun,
            cursorColor: AppColor.primary,
            textAlignVertical: TextAlignVertical.top,
            textAlign: widget.textAlign ?? TextAlign.start,
            controller: widget.controller,
            obscureText: obscureText /*widget.obscureText!*/,
            obscuringCharacter: '*',
            maxLines: widget.maxLine ?? 1,
            minLines: widget.minLine ?? 1,
            readOnly: widget.isReadOnly ?? false,
            style: AppTextStyle.getRegularStyle(
              color: AppColor.black,
              fontSize: AppFontSize.s16,
            ),
            textDirection: _textDir.value,
            // textDirection: TextDirection.ltr,
            // textDirection:obscureText!?TextDirection.ltr:TextDirection.rtl ,
            textInputAction: widget.textInputAction ?? TextInputAction.newline,
            // ignore: missing_return
            validator: (String? value) {
              if (value!.isEmpty || value == "") {
                return AppStrings.txtFiledRequired.tr;
              } else if (widget.customValid != null) {
                return widget.customValid!(value);
              } else {
                return null;
              }
              // return null;
            },
            onChanged: (values) {
              if (widget.onChange != null) {
                widget.onChange!(values);
                if (values.trim().length < 2) {
                  final dir = getDirection(values);
                  if (dir != textDirectionListenable) _textDir.value = dir;
                }
              } else {
                if (values.trim().length < 2) {
                  final dir = getDirection(values);
                  if (dir != textDirectionListenable) _textDir.value = dir;
                }
              }
            },
            onFieldSubmitted: (value) {
              try {
                widget.focusNode?.unfocus();
                FocusScope.of(context)
                    .requestFocus(widget.nexFocusNode /*?? FocusNode()*/);
                widget.onSubmitted!(value);
              } catch (e) {
                widget.focusNode?.unfocus();
              }
            },
            onSaved: (newValue) {
              widget.focusNode?.unfocus();
              FocusScope.of(context)
                  .requestFocus(widget.nexFocusNode /*?? FocusNode()*/); //remo
            },
            decoration: (widget.icon == null && widget.suffixIcon == null)
                ? inputDecoration()
                : widget.icon != null
                    ? inputDecorationWithIcon()
                    : inputDecorationWithSuffixIcon(),

            keyboardType: widget.keyboardType ?? TextInputType.emailAddress,

            inputFormatters: widget.isInputFormatters!
                ? [
                    FilteringTextInputFormatter.digitsOnly,
                    CustomInputFormatter()
                  ]
                : [],
          );
        });
  }

  InputDecoration inputDecorationWithIcon() {
    return InputDecoration(
        prefixIcon: Icon(
          widget.icon,
          color: widget.iconColor,
          size: widget.iconSize,
        ),
        prefixIconConstraints: widget.icon == null
            ? const BoxConstraints(maxWidth: 0, minWidth: 0)
            : const BoxConstraints(
                minWidth: 38,
                minHeight: 25,
              ),
        counterText: "",
        isDense: true,
        filled: widget.isFill,
        errorStyle: const TextStyle(
            /*  height: 0,*/ /*backgroundColor: Colors.white*/
            ),
        enabledBorder: widget.isFill!
            ? UnderlineInputBorder(
                borderRadius: BorderRadius.circular(AppSize.s4),
                borderSide: BorderSide(color: AppColor.black))
            : UnderlineInputBorder(
                borderRadius: BorderRadius.circular(AppSize.s4),
                borderSide: BorderSide(color: AppColor.grey1)),
        fillColor: widget.fillColor ?? AppColor.white,
        contentPadding: EdgeInsets.only(
            left: widget.isSmallPaddingWidth! ? AppPadding.p12 : AppSize.s40,
            right: widget.isSmallPaddingWidth! ? AppPadding.p12 : AppSize.s28,
            top: widget.isSmallPadding! ? AppPadding.p12 : AppPadding.p20,
            bottom: widget.isSmallPadding! ? AppPadding.p12 : AppPadding.p20),
        hintText: widget.label,
        hintStyle: widget.hintStyle ??
            AppTextStyle.getRegularStyle(
              color: AppColor.grey1,
              fontSize: AppFontSize.s14,
            ),
        focusedBorder: widget.isBorder!
            ? UnderlineInputBorder(
                borderRadius: BorderRadius.circular(AppSize.s4),
                borderSide: BorderSide(
                    color: widget.fillColor ?? AppColor.primary, width: 2))
            : InputBorder.none,
        errorBorder: widget.isBorder!
            ? UnderlineInputBorder(
                borderRadius: BorderRadius.circular(AppSize.s4),
                borderSide: BorderSide(
                    color: widget.fillColor ?? AppColor.primary, width: 2))
            : InputBorder.none,
        border: widget.isBorder!
            ? UnderlineInputBorder(
                borderRadius: BorderRadius.circular(AppSize.s4),
                borderSide: BorderSide(color: AppColor.grey1))
            : InputBorder.none);
  }

  InputDecoration inputDecorationWithSuffixIcon() {
    return InputDecoration(
        suffixIcon: InkWell(
          onTap: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          child: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility_outlined,
            color: widget.iconColor ?? AppColor.grey,
            size: widget.iconSize,
          ),
        ),
        suffixIconConstraints: widget.suffixIcon == null
            ? const BoxConstraints(maxWidth: 0, minWidth: 0)
            : const BoxConstraints(
                minWidth: 38,
                minHeight: 25,
              ),
        counterText: "",
        isDense: true,
        filled: widget.isFill,
        errorStyle: const TextStyle(
            /*  height: 0,*/ /*backgroundColor: Colors.white*/
            ),
        enabledBorder: widget.isFill!
            ? UnderlineInputBorder(
                borderRadius: BorderRadius.circular(AppSize.s4),
                borderSide: BorderSide(color: AppColor.black))
            : UnderlineInputBorder(
                borderRadius: BorderRadius.circular(AppSize.s4),
                borderSide: BorderSide(color: AppColor.grey1)),
        fillColor: widget.fillColor ?? AppColor.white,
        contentPadding: EdgeInsets.only(
            left: widget.isSmallPaddingWidth! ? AppPadding.p12 : AppSize.s40,
            right: widget.isSmallPaddingWidth! ? AppPadding.p12 : AppSize.s28,
            top: widget.isSmallPadding! ? AppPadding.p12 : AppPadding.p20,
            bottom: widget.isSmallPadding! ? AppPadding.p12 : AppPadding.p20),
        hintText: widget.label,
        hintStyle: widget.hintStyle ??
            AppTextStyle.getRegularStyle(
              color: AppColor.grey1,
              fontSize: AppFontSize.s14,
            ),
        focusedBorder: widget.isBorder!
            ? UnderlineInputBorder(
                borderRadius: BorderRadius.circular(AppSize.s4),
                borderSide: BorderSide(
                    color: widget.fillColor ?? AppColor.primary, width: 2))
            : InputBorder.none,
        errorBorder: widget.isBorder!
            ? UnderlineInputBorder(
                borderRadius: BorderRadius.circular(AppSize.s4),
                borderSide: BorderSide(
                    color: widget.fillColor ?? AppColor.primary, width: 2))
            : InputBorder.none,
        border: widget.isBorder!
            ? UnderlineInputBorder(
                borderRadius: BorderRadius.circular(AppSize.s4),
                borderSide: BorderSide(color: AppColor.grey1))
            : InputBorder.none);
  }

  InputDecoration inputDecoration() {
    return InputDecoration(
        counterText: "",
        isDense: true,
        filled: widget.isFill,
        errorStyle: const TextStyle(
            /*  height: 0,*/ /*backgroundColor: Colors.white*/
            ),
        enabledBorder: widget.enabledBorderColor != null
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSize.s4),
                borderSide: BorderSide(color: widget.enabledBorderColor!))
            : widget.isFill!
                ? UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSize.s4),
                    borderSide: BorderSide(color: AppColor.transparent))
                : UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSize.s4),
                    borderSide: BorderSide(color: AppColor.grey1)),
        fillColor: widget.fillColor ?? AppColor.white,
        contentPadding: EdgeInsets.only(
            left: widget.isSmallPaddingWidth! ? AppPadding.p12 : AppSize.s40,
            right: widget.isSmallPaddingWidth! ? AppPadding.p12 : AppSize.s28,
            top: widget.isSmallPadding! ? AppPadding.p12 : AppPadding.p20,
            bottom: widget.isSmallPadding! ? AppPadding.p12 : AppPadding.p20),
        hintText: widget.label,
        hintStyle: widget.hintStyle ??
            AppTextStyle.getRegularStyle(
              color: AppColor.grey1,
              fontSize: AppFontSize.s14,
            ),
        errorBorder: widget.isBorder!
            ? UnderlineInputBorder(
                borderRadius: BorderRadius.circular(AppSize.s4),
                borderSide: BorderSide(
                    color: widget.fillColor ?? AppColor.primary, width: 2))
            : InputBorder.none,
        focusedBorder: widget.isBorder!
            ? UnderlineInputBorder(
                borderRadius: BorderRadius.circular(AppSize.s4),
                borderSide: BorderSide(
                    color: widget.fillColor ?? AppColor.primary, width: 2))
            : InputBorder.none,
        border: widget.isBorder!
            ? UnderlineInputBorder(
                borderRadius: BorderRadius.circular(AppSize.s4),
                borderSide: BorderSide(color: AppColor.grey1))
            : InputBorder.none);
  }

  TextDirection getDirection(String v) {
    final string = v.trim();
    if (string.isEmpty) return TextDirection.ltr;
    final firstUnit = string.codeUnitAt(0);
    if (firstUnit > 0x0600 && firstUnit < 0x06FF ||
        firstUnit > 0x0750 && firstUnit < 0x077F ||
        firstUnit > 0x07C0 && firstUnit < 0x07EA ||
        firstUnit > 0x0840 && firstUnit < 0x085B ||
        firstUnit > 0x08A0 && firstUnit < 0x08B4 ||
        firstUnit > 0x08E3 && firstUnit < 0x08FF ||
        firstUnit > 0xFB50 && firstUnit < 0xFBB1 ||
        firstUnit > 0xFBD3 && firstUnit < 0xFD3D ||
        firstUnit > 0xFD50 && firstUnit < 0xFD8F ||
        firstUnit > 0xFD92 && firstUnit < 0xFDC7 ||
        firstUnit > 0xFDF0 && firstUnit < 0xFDFC ||
        firstUnit > 0xFE70 && firstUnit < 0xFE74 ||
        firstUnit > 0xFE76 && firstUnit < 0xFEFC ||
        firstUnit > 0x10800 && firstUnit < 0x10805 ||
        firstUnit > 0x1B000 && firstUnit < 0x1B0FF ||
        firstUnit > 0x1D165 && firstUnit < 0x1D169 ||
        firstUnit > 0x1D16D && firstUnit < 0x1D172 ||
        firstUnit > 0x1D17B && firstUnit < 0x1D182 ||
        firstUnit > 0x1D185 && firstUnit < 0x1D18B ||
        firstUnit > 0x1D1AA && firstUnit < 0x1D1AD ||
        firstUnit > 0x1D242 && firstUnit < 0x1D244) {
      return TextDirection.rtl;
    }
    return TextDirection.ltr;
  }
}

class CustomInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write(
            ' '); // Replace this with anything you want to put after each 4 numbers
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}
