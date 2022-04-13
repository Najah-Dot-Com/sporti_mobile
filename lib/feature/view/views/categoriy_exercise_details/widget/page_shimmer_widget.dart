import 'package:flutter/material.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_media.dart';

class PageShimmerWidget extends StatelessWidget {
  const PageShimmerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.s28),
      child: ListView(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSize.s28,),
          ClipRRect(borderRadius: BorderRadius.circular(AppSize.s12),
              child:Image.asset(AppMedia.loadingShimmer , width: double.infinity,
                  height: AppSize.s200,
                  fit: BoxFit.cover,)),
          const SizedBox(height: AppSize.s28,),
          ClipRRect(borderRadius: BorderRadius.circular(AppSize.s12),
              child:Image.asset(AppMedia.loadingShimmer , width: double.infinity,
                height: AppSize.s40,
                fit: BoxFit.cover,)),
          const SizedBox(height: AppSize.s12,),
          ClipRRect(borderRadius: BorderRadius.circular(AppSize.s12),
              child:Image.asset(AppMedia.loadingShimmer , width: double.infinity,
                height: AppSize.s40,
                fit: BoxFit.cover,)),
          const SizedBox(height: AppSize.s12,),
          ClipRRect(borderRadius: BorderRadius.circular(AppSize.s12),
              child:Image.asset(AppMedia.loadingShimmer , width: double.infinity,
                height: AppSize.s40,
                fit: BoxFit.cover,)),
          const SizedBox(height: AppSize.s28,),
          ClipRRect(borderRadius: BorderRadius.circular(AppSize.s12),
              child:Image.asset(AppMedia.loadingShimmer , width: double.infinity,
                height: AppSize.s40,
                fit: BoxFit.cover,)),
          const SizedBox(height: AppSize.s12,),
          ClipRRect(borderRadius: BorderRadius.circular(AppSize.s12),
              child:Image.asset(AppMedia.loadingShimmer , width: double.infinity,
                height: AppSize.s40,
                fit: BoxFit.cover,)),
        ],
      ),
    );
  }
}
