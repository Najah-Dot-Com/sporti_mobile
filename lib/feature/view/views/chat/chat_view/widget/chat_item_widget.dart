import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sporti/feature/model/comment_data.dart';
import 'package:sporti/feature/model/group_data.dart';
import 'package:sporti/feature/view/appwidget/bottom_sheet/gloable_bottom_sheet.dart';
import 'package:sporti/network/firebase/group_features.dart';
import 'package:sporti/network/utils/constance_netwoek.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_font.dart';
import 'package:sporti/util/app_shaerd_data.dart';
import 'package:sporti/util/app_strings.dart';
import 'package:sporti/util/date_time_util.dart';
import 'package:sporti/util/sh_util.dart';

class ChatItemWidget extends StatelessWidget {
  const ChatItemWidget({
    Key? key,
    required this.comment,required this.group,
  }) : super(key: key);
  final CommentData comment;
  final GroupData group;

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return InkWell(
      splashColor: AppColor.transparent,
      highlightColor: AppColor.transparent,
      hoverColor: AppColor.transparent,
      onLongPress: () {
        if(comment.uid == SharedPref.instance.getUserData().username) {
          Get.bottomSheet(
             GlobalBottomSheet(
              title:AppStrings.txtDeleteComment.tr,
              isTwoBtn: true,
              onCancelBtnClick: (){
                Get.back();
              },
               onOkBtnClick: ()=> _deleteComment(),
            ),
            isScrollControlled: true);
        }else{

        }
      },
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
            AppSize.s0, AppSize.s0, AppSize.s0, AppSize.s12),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: imageNetwork(
                url:
                    "${comment.profilePic != null && comment.profilePic!.isEmpty ? null : comment.profilePic.toString()}",
                width: AppSize.s40,
                height: AppSize.s40,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      AppSize.s12, AppSize.s0, AppSize.s0, AppSize.s0),
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.75,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDBE2E7),
                      borderRadius: BorderRadius.circular(AppSize.s12),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          AppSize.s12, AppSize.s8, AppSize.s12, AppSize.s8),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            comment.name.toString(),
                            style: themeData.textTheme.bodyText1?.copyWith(
                              color: AppColor.black,
                              fontSize: AppFontSize.s14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SelectableText(
                            comment.text.toString(),
                            style: themeData.textTheme.bodyText2?.copyWith(
                              color: AppColor.grey,
                              fontSize: AppFontSize.s14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      AppSize.s12, AppSize.s4, AppSize.s10, AppSize.s0),
                  child: Text(
                    DateUtility.getChatTime(comment.datePublished.toString()),
                    style: themeData.textTheme.bodyText2?.copyWith(
                      color: AppColor.grey,
                      fontSize: AppFontSize.s14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _deleteComment() {
    GroupFeatures.instance.deleteComment(comment, group);
    Get.back();
  }
}
