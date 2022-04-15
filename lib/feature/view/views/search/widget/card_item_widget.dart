import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sporti/feature/model/exercises_package_data.dart';
import 'package:sporti/feature/view/views/categoriy_exercise_details/categoriy_exercise_details_view.dart';
import 'package:sporti/feature/view/views/category_details/categories_details_view.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_shaerd_data.dart';
import 'package:sporti/util/app_strings.dart';
import 'package:sporti/util/constance.dart';

class CardItemWidget extends StatelessWidget {
  const CardItemWidget({Key? key, required this.isPackage, required this.data, }) : super(key: key);
  final bool isPackage;
  final ExercisesData data;
  final String fakeImage = "https://i0.wp.com/post.healthline.com/wp-content/uploads/2021/07/1377301-1183869-The-8-Best-Weight-Benches-of-2021-1296x728-Header-c0dcdf.jpg?w=1575";

  Widget get imageWidget => imageNetwork(
      url: data.image ??fakeImage,
      width: double.infinity,
      height: AppSize.s140,
      fit: BoxFit.cover);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return InkWell(
      onTap: _onItemClick,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s12),
          color: AppColor.white,
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            imageWidget,
            SizedBox(
              height: AppSize.s65,
              width: AppSize.s190,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    data.title.toString(),
                    style: theme.textTheme.headline6,
                    overflow: TextOverflow.ellipsis,
                    maxLines: Constance.maxLineOne,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    "6 ${AppStrings.txtExercises}",
                    style: theme.textTheme.subtitle2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onItemClick() {
    if(isPackage){
      //go to package
      Get.to(CategoriesDetailsView(
        id: data.id.toString(),
        title: data.title.toString(),
        package: data,
      ));
    }else{
       Get.to( CategoriyExerciseDetailsView(packageDetails:data));
    }

  }
}
