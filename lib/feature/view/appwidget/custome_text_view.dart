import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../util/app_shaerd_data.dart';

class CustomTextView extends StatelessWidget {
  final String? txt;
  final TextAlign? textAlign;
  final TextStyle? textStyle;
  final int? maxLine;
  final TextOverflow? textOverflow;
  final bool? isUpperCase;

  const CustomTextView({Key? key, this.txt, this.textAlign, this.textStyle, this.maxLine, this.textOverflow, this.isUpperCase = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      isUpperCase!?txt!.toUpperCase()
      :txt?? "",
      overflow: textOverflow,
      textAlign: textAlign,
      style: textStyle,
      softWrap: false,
      maxLines: maxLine,
    );
  }
}
