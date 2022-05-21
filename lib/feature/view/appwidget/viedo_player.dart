import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:sporti/feature/view/appwidget/three_size_dot.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:video_player/video_player.dart';



class VideoPlayer extends StatefulWidget {
  final String? videoUrl;
  final Function(VideoPlayerController)? onVideoChangeCallback;
  const VideoPlayer({Key? key,required this.videoUrl,required this.onVideoChangeCallback}) : super(key: key);

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late VideoPlayerController videoPlayerController;

  late ChewieController chewieController;

  var playerWidget;

  @override
  void initState() {
    super.initState();
    initVideoPlayer();
  }

  initVideoPlayer() async {
    videoPlayerController = VideoPlayerController.network(
        "${widget.videoUrl}");
    await videoPlayerController.initialize();
     chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        looping: false,
        zoomAndPan: true,
        deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitDown,DeviceOrientation.portraitUp,],
        deviceOrientationsOnEnterFullScreen: [DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight,],
        showOptions: true,
        showControls: true,
        showControlsOnInitialize: true,
        allowPlaybackSpeedChanging: true,
        allowedScreenSleep: true,
        allowMuting: true,
        autoInitialize: true,
        // placeholder: ShimmerLoadingAnnouncement(),
        aspectRatio: (MediaQuery.of(context).size.width /
            MediaQuery.of(context).size.width) /*w,h*/
        );
    videoPlayerController.addListener(() {
      widget.onVideoChangeCallback!(videoPlayerController);
      // videoPlayerController.position.then((value) {
      //   Logger().d(value);
      // });
    });
    playerWidget = Chewie(
      controller: chewieController,
    );
    setState(() {});
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
   Widget build(BuildContext context) {
    return Container(
        color: AppColor.lightGrey,
        width: double.infinity,
        height: AppSize.s350,
        child: Stack(
          children: [
            PositionedDirectional(
                start: 0,
                end: 0,
                bottom: 0,
                top: 0,
                child: ThreeSizeDot(color_1: AppColor.primary,color_2: AppColor.primary,color_3: AppColor.primary,)),
            SizedBox(
              child: playerWidget,
            ),
          ],
        ));
  }
}
