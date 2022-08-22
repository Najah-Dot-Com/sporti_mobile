import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:sporti/feature/model/comment_data.dart';
import 'package:sporti/feature/model/group_data.dart';
import 'package:sporti/feature/view/appwidget/custom_text_filed.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/feature/view/views/chat/chat_view/widget/chat_item_widget.dart';
import 'package:sporti/feature/view/views/home_page/widget/widget_home_tab/shimmer_your_work_widget.dart';
import 'package:sporti/network/firebase/group_features.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_font.dart';
import 'package:sporti/util/app_shaerd_data.dart';
import 'package:sporti/util/app_strings.dart';
import 'package:sporti/util/constance.dart';
import 'package:sporti/util/sh_util.dart';

class ChatView extends StatefulWidget {
  const ChatView({
    Key? key,
    required this.group,
  }) : super(key: key);
  final GroupData group;

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  TextEditingController messageController = TextEditingController();
  
  ScrollController scrollController = ScrollController();

  PreferredSizeWidget myAppbar(ThemeData themeData) => AppBar(
        backgroundColor: AppColor.white,
        centerTitle: false,
        title: CustomTextView(
          txt: widget.group.title,
          textStyle:
              themeData.textTheme.headline2?.copyWith(color: AppColor.black),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
            color: AppColor.black,
          ),
        ),
      );

  Widget sendMessageWidget() {
    return Container(
      margin:
          EdgeInsets.only(bottom: Platform.isIOS ? AppSize.s40 : AppSize.s0),
      padding: const EdgeInsets.only(
          left: AppSize.s10,
          bottom: AppSize.s6,
          top: AppSize.s10,
          right: AppSize.s10),
      height: AppSize.s70,
      width: double.infinity,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          // GestureDetector(
          //   onTap: (){
          //   },
          //   child: Container(
          //     height: 30,
          //     width: 30,
          //     decoration: BoxDecoration(
          //       color: Colors.lightBlue,
          //       borderRadius: BorderRadius.circular(30),
          //     ),
          //     child: Icon(Icons.add, color: Colors.white, size: 20, ),
          //   ),
          // ),
          // SizedBox(width: 15,),
          Expanded(
            child: CustomTextFormFiled(
              label: AppStrings.txtWriteMessage.tr,
              isBorder: false,
              fillColor: AppColor.white,
              isSmallPaddingWidth: true,
              isSmallPadding: true,
              controller: messageController,
              textInputAction: TextInputAction.done,
              minLine: Constance.maxLineOne,
              maxLine: Constance.maxLine1000,
              enabledBorderColor: AppColor.white,
              onSubmitted: (value) {
                if (value.isEmpty) {
                  return;
                }
                _sendMessage();
              },
            ),
          ),
          const SizedBox(
            width: AppSize.s16,
          ),
          FloatingActionButton(
            onPressed: () {
              if (messageController.text.isEmpty) {
                return;
              }
              _sendMessage();
            },
            child: Icon(
              Icons.send,
              color: AppColor.white,
              size: AppSize.s18,
            ),
            backgroundColor: AppColor.primary,
            elevation: 0,
          ),
        ],
      ),
    );
  }

  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async{
       handleJump();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);

    return Scaffold(
      appBar: myAppbar(themeData),
      bottomSheet: sendMessageWidget(),
      body: StreamBuilder(
          stream: GroupFeatures.instance.getGroupComments(group: widget.group),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.only(
                    top: AppSize.s20, right: AppSize.s16, left: AppSize.s16),
                children: const [
                  ShimmerSelectYourWorkWidget(),
                  ShimmerSelectYourWorkWidget(),
                  ShimmerSelectYourWorkWidget(),
                  ShimmerSelectYourWorkWidget(),
                  ShimmerSelectYourWorkWidget(),
                  ShimmerSelectYourWorkWidget(),
                  ShimmerSelectYourWorkWidget(),
                ],
              );
            }
            if (snapshot.hasData) {
              return SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          AppSize.s20, AppSize.s20, AppSize.s20, AppSize.s0),
                      // primary: false,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ChatItemWidget(comment:CommentData.fromJson(snapshot.data!.docs[index].data()) , group:widget.group);
                      },
                    ),
                    const SizedBox(height: AppSize.s100,),
                  ],
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
    );
  }

  void _sendMessage() {

    String comment = messageController.text.toString();
    var userData = SharedPref.instance.getUserData();
    GroupFeatures.instance.postComment(text: comment,
        name: userData.fullname.toString(),
        postId: widget.group.id.toString(),
        profilePic: userData.picture.toString(),
        uid: userData.username.toString());
    messageController.clear();
    handleJump();
  }

  void handleJump() async{
  //   if (scrollController.hasClients) {
  //     Logger().e("sd");
  //     // scrollController.jumpTo(scrollController.position.maxScrollExtent);
  //
  //     double contentHeight = (MediaQuery.of(context).size.height / 4)  + scrollController.position.maxScrollExtent/*> 700 ? MediaQuery.of(context).size.height * 0.89 : MediaQuery.of(context).size.height * 0.85*/;
  //
  //     // scrollController.jumpTo(contentHeight);
  //     await scrollController.animateTo(
  //       contentHeight,
  //       curve: Curves.easeOut,
  //       duration: const Duration(milliseconds: 300),
  //     );
  //     // setState(() {});
  //   }
   }
}
