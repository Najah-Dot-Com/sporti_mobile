import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:sporti/feature/model/group_data.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/network/firebase/group_features.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_font.dart';
import 'package:sporti/util/app_shaerd_data.dart';
import 'package:sporti/util/app_strings.dart';
import 'package:sporti/util/app_style.dart';
import 'package:sporti/util/app_shaerd_data.dart';

class GroupItemListWidget extends StatefulWidget {
  const GroupItemListWidget({
    Key? key,
    required this.group,
    required this.isAdmin,
  }) : super(key: key);
  final GroupData group;
  final bool isAdmin;

  @override
  State<GroupItemListWidget> createState() => _GroupItemListWidgetState();
}

class _GroupItemListWidgetState extends State<GroupItemListWidget> {
  Uint8List? image;

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return // Generated code for this menuItem Widget...
        Container(
      width: MediaQuery.of(context).size.width,
      height: AppSize.s100,
      margin: const EdgeInsets.only(bottom: AppSize.s20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [AppShadow.boxShadowLight()!],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
            AppSize.s8, AppSize.s8, AppSize.s8, AppSize.s8),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                  AppSize.s0, AppSize.s1, AppSize.s1, AppSize.s1),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  onTap: widget.isAdmin ? () => _selectImage() : () {},
                  child: image != null
                      ? Image.memory(
                          image!,
                          width: AppSize.s70,
                          height: AppSize.s100,
                          fit: BoxFit.cover,
                        )
                      : imageNetwork(
                          url: widget.group.url!.isNotEmpty
                              ? widget.group.url
                              : null,
                          width: AppSize.s70,
                          height: AppSize.s100,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                    AppSize.s8, AppSize.s8, AppSize.s4, AppSize.s0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.group.title.toString(),
                      style: themeData.textTheme.subtitle1?.copyWith(
                        color: AppColor.black,
                        fontSize: AppFontSize.s20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            AppSize.s0, AppSize.s4, AppSize.s8, AppSize.s0),
                        child: CustomTextView(
                          txt: widget.group.desc ?? AppStrings.txtHintForum.tr,
                          textAlign: TextAlign.start,
                          textStyle: themeData.textTheme.subtitle2?.copyWith(
                            color: AppColor.grey,
                            fontSize: AppFontSize.s14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                  AppSize.s0, AppSize.s4, AppSize.s0, AppSize.s0),
              child: widget.isAdmin
                  ? InkWell(
                      onTap: () => switchGroupState(),
                      child: Icon(
                        widget.group.isActive!
                            ? Icons.radio_button_checked_rounded
                            : Icons.radio_button_off,
                        color: widget.group.isActive!
                            ? AppColor.primary
                            : AppColor.grey,
                        size: AppSize.s24,
                      ),
                    )
                  : Icon(
                      Icons.chevron_right_rounded,
                      color: AppColor.grey,
                      size: AppSize.s24,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  _selectImage() async {
    var image =
        await pickImage(ImageSource.gallery, AppSize.s200, AppSize.s200);
    setImage(image);
    // StorageUtils.instance.uploadImage(image);
  }

  void setImage(image) async {
    this.image = image;
    setState(() {});
    // update();
    await GroupFeatures.instance.uploadImage(image, widget.group.id.toString()).then((value) {
      if (value.isNotEmpty) {
        GroupFeatures.instance.updateGroupImage(widget.group.copyWith(url: value));
      }
    });
  }

  switchGroupState() {
    GroupFeatures.instance.updateGroupState(widget.group);
  }
}
