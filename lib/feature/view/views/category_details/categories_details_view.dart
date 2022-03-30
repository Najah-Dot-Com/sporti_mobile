import 'package:flutter/material.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/feature/view/views/category_details/widget/categories_list_item_widget.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_font.dart';
import 'package:sporti/util/app_shaerd_data.dart';
import 'package:sporti/util/app_strings.dart';
import 'package:get/get.dart';
import 'package:sporti/util/app_style.dart';
import 'package:sporti/util/constance.dart';

class CategoriesDetailsView extends StatelessWidget {
  const CategoriesDetailsView({Key? key}) : super(key: key);

  final String fakeImage = "https://i0.wp.com/post.healthline.com/wp-content/uploads/2021/07/1377301-1183869-The-8-Best-Weight-Benches-of-2021-1296x728-Header-c0dcdf.jpg?w=1575";


  PreferredSizeWidget myAppbar(ThemeData themeData) => AppBar(
    backgroundColor: AppColor.white,
    centerTitle: true,
    title: CustomTextView(
      txt: AppStrings.txtExercises.tr,
      textStyle:
      themeData.textTheme.headline2?.copyWith(color: AppColor.black),
    ),
    leading: IconButton(
      onPressed: () => Get.back(),
      icon: Icon(
        Icons.arrow_back_ios,
        color: AppColor.black,
      ),
    ),
  );


  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Scaffold(
      appBar: myAppbar(themeData),
      floatingActionButton: FloatingActionButton(backgroundColor: AppColor.primary,onPressed: _onAddBtnClick,child: Icon(Icons.add ,color: AppColor.white,),),
      body: SingleChildScrollView(
        physics: AppStyleScroll.customScrollViewIOS(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSize.s28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSize.s28,),
              imageNetwork(width: double.infinity, height: AppSize.s200,fit: BoxFit.cover , url: fakeImage),
              const SizedBox(height: AppSize.s28,),
              CustomTextView(
                txt: AppStrings.txtDetailsNote.tr ,
                textStyle: themeData.textTheme.subtitle2?.copyWith(color: AppColor.grey),
              ),
              const SizedBox(height: AppSize.s20,),
              ListView.builder(
                  physics:const  NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context , index){
                    return const CategoriesListItemWidget();
                  })

            ],
          ),
        ),
      ),
    );
  }

  void _onAddBtnClick() {
  }
}