import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_social_clean/src/shared/presentation/widgets/widgets.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final String assetPath;
  final String? caption;
  final String? username;
  const CustomVideoPlayer({
    Key? key,
    required this.assetPath,
    this.caption,
    this.username,
  }) : super(key: key);

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController controller;

  @override
  void initState() {
    if (widget.assetPath.startsWith("assets")) {
      controller = VideoPlayerController.asset(widget.assetPath);
    } else {
      controller = VideoPlayerController.file(File(widget.assetPath));
    }
    controller.initialize().then((_) {
      setState(() {
        //forzo il build
      });
    });
    controller.setVolume(0);
    controller.play();
    controller.setLooping(true); //metto in loop
    super.initState();
  }

  @override
  void dispose() {
    debugPrint("DISPOSING");
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      //video non pronto
      return const SizedBox.shrink();
    } else {
      setState(() {
        // controller.play();
      });
      return GestureDetector(
        onTap: () {
          setState(() {
            if (controller.value.isPlaying) {
              controller.pause();
            } else {
              controller.play();
            }
          });
        },
        child: AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: Stack(children: [
              VideoPlayer(controller),
              const CustomGradientOverlay(),
              (widget.caption == null || widget.username == null)
                  ? const SizedBox.shrink()
                  : _VideoCaption(
                      username: widget.username!, caption: widget.caption!),
            ])),
      );
    }
  }
}

class _VideoCaption extends StatelessWidget {
  const _VideoCaption({
    required this.username,
    required this.caption,
  });

  final String username;
  final String caption;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
          padding: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width * 0.75,
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(caption, style: Theme.of(context).textTheme.bodySmall),
            ],
          )),
    );
  }
}
