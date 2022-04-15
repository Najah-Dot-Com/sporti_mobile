import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sporti/feature/view/views/search/widget/shimmer_search_widget.dart';
import 'package:sporti/feature/viewmodel/search_viewmodel.dart';
import 'package:sporti/util/app_dimen.dart';

import 'card_item_widget.dart';

class PackageExerciseListWidget extends StatelessWidget {
  const PackageExerciseListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchViewModel>(
        init: SearchViewModel(),
        builder: (logic) {
          return Column(
            children: [
              const SizedBox(
                height: AppSize.s12,
              ),
              if (logic.isLoading) ...[
                const Expanded(child:  ShimmerSearchWidget()),
              ] else if (!logic.isLoading && logic.packageExerciseList.isEmpty) ...[
                const SizedBox.shrink()
              ] else ...[
                Expanded(
                  child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: logic.packageExerciseList.length,
                      padding:
                      const EdgeInsets.symmetric(horizontal: AppSize.s12),
                      keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: AppSize.s18,
                          mainAxisSpacing: AppSize.s20,
                          childAspectRatio: (AppSize.s130 / AppSize.s140)),
                      itemBuilder: (context, index) {
                        return  CardItemWidget(isPackage:true , data: logic.packageExerciseList[index],);
                      }),
                ),
              ]
            ],
          );
        });
  }
}
