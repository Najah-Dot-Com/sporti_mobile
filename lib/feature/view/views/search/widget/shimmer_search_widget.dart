import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sporti/feature/viewmodel/search_viewmodel.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_media.dart';

import 'card_item_widget.dart';

class ShimmerSearchWidget extends StatelessWidget {
  const ShimmerSearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: AppSize.s12,
        ),
        Expanded(
          child: GridView.builder(
              shrinkWrap: true,
              itemCount: 4,
              padding:
              const EdgeInsets.symmetric(horizontal: AppSize.s12),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: AppSize.s18,
                  mainAxisSpacing: AppSize.s20,
                  childAspectRatio: (AppSize.s130 / AppSize.s140)),
              itemBuilder: (context, index) {
                return FittedBox(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppSize.s12),
                    clipBehavior: Clip.hardEdge,
                    child: Image.asset(
                      AppMedia.loadingShimmer,
                      width: AppSize.s190,
                      height: AppSize.s200,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
        ),

      ],
    );
  }
}
