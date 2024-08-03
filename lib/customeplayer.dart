import 'dart:io';

import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:cached_video_player_plus/cached_video_player_plus.dart';

import 'package:flutter/material.dart';
import 'package:cached_video_player_plus/cached_video_player_plus.dart';

class CustomPlayer extends StatefulWidget {
  final String videoPlayer;

  CustomPlayer({Key? key, required this.videoPlayer}) : super(key: key);

  @override
  _CustomPlayerState createState() => _CustomPlayerState();
}

class _CustomPlayerState extends State<CustomPlayer> {
  late CachedVideoPlayerPlusController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = CachedVideoPlayerPlusController.network(
      widget.videoPlayer,
    );

    _videoController.initialize().then((_) {
      setState(() {});
      _videoController.play();
      _videoController.setLooping(true);
    });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width:
          double.infinity, // Ensures the width is taken from parent constraints
      height: 200, // You can adjust the height as needed
      child: Stack(
        fit: StackFit.expand, // Makes sure children fill the stack
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                if (_videoController.value.isPlaying) {
                  _videoController.pause();
                } else {
                  _videoController.play();
                }
              });
            },
            child: AspectRatio(
              aspectRatio: _videoController.value.aspectRatio,
              child: CachedVideoPlayerPlus(_videoController),
            ),
          ),
          Positioned(
            top: 80,
            left: 60,
            child: _videoController.value.isPlaying
                ? Icon(Icons.pause, color: Colors.white, size: 30)
                : Icon(Icons.play_circle, color: Colors.white, size: 30),
          ),
        ],
      ),
    );
  }
}

class Player extends StatefulWidget {
  Player({super.key, required this.videoplayer});
  File videoplayer;
  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  late CachedVideoPlayerPlusController videocontroller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      videocontroller =
          CachedVideoPlayerPlusController.file(widget.videoplayer);
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
    return Container(
      width:
          double.infinity, // Ensures the width is taken from parent constraints
      height: 200, // You can adjust the height as needed
      child: Stack(
        fit: StackFit.expand, // Makes sure children fill the stack
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                if (videocontroller.value.isPlaying) {
                  videocontroller.pause();
                } else {
                  videocontroller.play();
                }
              });
            },
            child: AspectRatio(
              aspectRatio: videocontroller.value.aspectRatio,
              child: CachedVideoPlayerPlus(videocontroller),
            ),
          ),
          Positioned(
            top: 130,
            left: 140,
            child: videocontroller.value.isPlaying
                ? Icon(Icons.pause, color: Colors.white, size: 30)
                : Icon(Icons.play_circle, color: Colors.white, size: 30),
          ),
        ],
      ),
    );
  }
}
