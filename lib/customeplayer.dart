import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/material.dart';

class CustomPlayer extends StatefulWidget {
  CustomPlayer({super.key, required this.videoplayer});
  String videoplayer;
  @override
  State<CustomPlayer> createState() => _CustomPlayerState();
}

class _CustomPlayerState extends State<CustomPlayer> {
  late CachedVideoPlayerPlusController videocontroller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      videocontroller = CachedVideoPlayerPlusController.networkUrl(
          Uri.parse(widget.videoplayer));
    });

    videocontroller.initialize();
    videocontroller.play();
    videocontroller.setLooping(true);
  }

  @override
  void dispose() {
    super.dispose();
    videocontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (videocontroller.value.isPlaying) {
          videocontroller.pause();
        } else {
          videocontroller.play();
        }
      },
      child: Expanded(
        child: Container(
          height: 100,
          child: CachedVideoPlayerPlus(videocontroller),
        ),
      ),
    );
  }
}
